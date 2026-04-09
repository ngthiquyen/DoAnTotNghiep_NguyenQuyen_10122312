import os
import sys
import requests
import re

# ===== CẤU HÌNH =====
OLLAMA_URL = "http://localhost:11434/api/generate"
MODEL = "llama3"


INPUT_DIR = "generate_keywords_use_AI/input"
OUTPUT_DIR = "generate_keywords_use_AI/output"
PROMPT_FILE = "generate_keywords_use_AI/prompt/generate_keyword_prompt.txt"

# ===== MAP TỚI FRAMEWORK =====
FILE_MAPPING = {
    "BUSINESS": "keywords/business/business_keywords.robot",
    "UI": "keywords/ui/common_keywords.robot",
    "VERIFY": "keywords/verify/verify.robot"
}

# ===== ACTION SYNONYMS (normalize action meaning) =====
ACTION_SYNONYMS = {
    "enter": "input",
    "type": "input",
    "fill": "input",

    "press": "click",
    "tap": "click"
}

# ===== CAPABILITY MAP =====
def detect_capability(keyword_name: str):

    name = keyword_name.lower()

    if "input" in name or "enter" in name:
        return "input_text"

    if "click" in name or "press" in name:
        return "click_element"

    if "wait" in name and "page" in name:
        return "wait_page"

    if "scroll" in name:
        return "scroll"

    if "select" in name:
        return "select_option"

    if "verify" in name:

        if "visible" in name:
            return "verify_visible"

        if "enabled" in name:
            return "verify_enabled"

        if "disabled" in name:
            return "verify_disabled"

        if "contain" in name:
            return "verify_contains"

        if "present" in name:
            return "verify_present"

        if "not" in name:
            return "verify_not"

        return "verify_generic"

    return "other"

def read_file(path):
    with open(path, "r", encoding="utf-8") as f:
        return f.read()

def call_ollama(prompt: str) -> str:
    payload = {
        "model": MODEL,
        "prompt": prompt,
        "stream": False,
        "options": {
        "temperature": 0.1,
        "num_predict": 301,
        "top_p": 0.9
        }
    }

    response = requests.post(OLLAMA_URL, json=payload)
    response.raise_for_status()

    return response.json()["response"]

# ===== NORMALIZE KEYWORD =====
def normalize_keyword(name: str):

    words = name.lower().split()

    normalized_words = []

    for w in words:
        if w in ACTION_SYNONYMS:
            normalized_words.append(ACTION_SYNONYMS[w])
        else:
            normalized_words.append(w)

    return " ".join(normalized_words)

# ===== PARSE AI RESPONSE =====
def parse_keywords(response_text: str):
    sections = {
        "BUSINESS": [],
        "UI": [],
        "VERIFY": []
    }

    current_section = None

    for line in response_text.splitlines():
        line = line.strip()

        if "BUSINESS KEYWORDS" in line:
            current_section = "BUSINESS"
            continue
        elif "UI ACTION KEYWORDS" in line:
            current_section = "UI"
            continue
        elif "VERIFICATION KEYWORDS" in line:
            current_section = "VERIFY"
            continue
            
        # Skip table headers/separators
        if line.startswith("| Keyword Name") or line.startswith("|--------------"):
            continue

        # Parse table rows
        if line.startswith("|") and current_section:
            parts = [p.strip() for p in line.split("|")]

            # parts example:
            # ['', 'Enter Text Into Field', 'Yes', 'locator, text', 'Input Text', 'Enter text...', '']
            if len(parts) >= 6:
                keyword_name = parts[1]
                description = parts[-2]

                if keyword_name and keyword_name != "...":
                    sections[current_section].append({
                        "name": keyword_name,
                        "description": description,
                        "normalized": normalize_keyword(keyword_name),
                        "capability": detect_capability(keyword_name)
                    })

    return sections

def build_keyword_context(parsed_sections):
    lines = []

    for section, keywords in parsed_sections.items():

        lines.append(f"\n{section} KEYWORDS:")

        for kw in keywords:
            lines.append(f"{kw['name']}")

    return "\n".join(lines)

def load_framework_keywords(feature_name):
    sections = {
        "BUSINESS": [],
        "UI": [],
        "VERIFY": []
    }

    files = {
        "BUSINESS": f"keywords/business/{feature_name}_business.robot",
        "UI": "keywords/ui/common_keywords.robot",
        "VERIFY": "keywords/verify/verify.robot"
    }

    for section, file_path in files.items():

        if not os.path.exists(file_path):
            continue

        inside_keyword_block = False

        with open(file_path, "r", encoding="utf-8") as f:
            for line in f:
                line = line.rstrip()

                # detect keyword section
                if line.startswith("*** Keywords"):
                    inside_keyword_block = True
                    continue

                if line.startswith("***"):
                    inside_keyword_block = False
                    continue

                if not inside_keyword_block:
                    continue

                # keyword = dòng không indent
                if line and not line.startswith(" "):
                    sections[section].append({
                        "name": line
                    })

    return sections

def generate_business_flow(feature_name, parsed_sections, use_case_text):

    prompt_template = read_file("generate_keywords_use_AI/prompt/generate_flow_prompt.txt")

    keyword_context = build_keyword_context(parsed_sections)

    prompt = prompt_template \
        .replace("{{KEYWORDS}}", keyword_context) \
        .replace("{{USE_CASE}}", use_case_text)

    print(" Generating business flow...")

    result = call_ollama(prompt)

    output_path = os.path.join(
        OUTPUT_DIR, f"{feature_name}_flow.txt"
    )

    with open(output_path, "w", encoding="utf-8") as f:
        f.write(result)

    print(f" Saved flow to: {output_path}")

    return result



def parse_flow(flow_text: str):
    steps = []

    for line in flow_text.splitlines():
        line = line.strip()

        match = re.match(r"^\d+\.\s+(.*)", line)
        if match:
            step = match.group(1).strip()
            steps.append(step)

    return steps

def generate_robot_test(feature_name, flow_text):

    steps = parse_flow(flow_text)

    output_path = f"tests/{feature_name}_auto.robot"
    os.makedirs("tests", exist_ok=True)

    business_file = f"../keywords/business/{feature_name}_business.robot"

    with open(output_path, "w", encoding="utf-8") as f:
        f.write("*** Settings ***\n")
        f.write(f"Resource    {business_file}\n")
        f.write("Resource    ../keywords/ui/common_keywords.robot\n")
        f.write("Resource    ../keywords/verify/verify.robot\n\n")

        f.write("*** Test Cases ***\n")
        f.write(f"{feature_name} Auto Test\n")
        f.write("    [Documentation]    Auto generated from AI flow\n\n")

        for step in steps:
            f.write(f"    {step}\n")

    print(f"Robot test generated: {output_path}")
    
# ===== LẤY KEYWORD ĐÃ TỒN TẠI =====
def get_existing_keywords(file_path: str):
    names = set()
    normalized = set()
    capabilities = set()
    if not os.path.exists(file_path):
        return names, normalized, capabilities

    with open(file_path, "r", encoding="utf-8") as f:
        for line in f:
            stripped = line.strip()

            # Bỏ qua dòng rỗng và dòng indent (TODO)
            if stripped and not line.startswith("    "):
                names.add(stripped)
                normalized.add(normalize_keyword(stripped))
                capabilities.add(detect_capability(stripped))

    return names, normalized, capabilities

# ===== APPEND KEYWORD MỚI =====
def append_keywords(file_path: str, new_keywords: list):
    os.makedirs(os.path.dirname(file_path), exist_ok=True)

    with open(file_path, "a", encoding="utf-8") as f:
        for kw in new_keywords:
            f.write(f"\n{kw['name']}\n")

            if kw["description"]:
                f.write(f"    [Documentation]    {kw['description']}\n")

            f.write("    # TODO: Implement\n")
            
# ===== FILTER DUPLICATE KEYWORDS =====
def filter_keywords(keywords, existing_names, existing_normalized, existing_capabilities):

    new_keywords = []

    for kw in keywords:

        name = kw["name"]
        normalized = kw["normalized"]
        capability = kw["capability"]

        # duplicate name
        if name in existing_names:
            print(f"Skip duplicate name: {name}")
            continue

        # duplicate normalized text
        if normalized in existing_normalized:
            print(f"Skip semantic duplicate: {name}")
            continue

        # duplicate capability
        if capability in existing_capabilities and capability != "other":
            print(f"Reuse existing capability ({capability}) for: {name}")
            continue

        new_keywords.append(kw)

        existing_names.add(name)
        existing_normalized.add(normalized)
        existing_capabilities.add(capability)

    return new_keywords

# ===== GHI VÀO FRAMEWORK (CHỈ KEYWORD MỚI) =====
def write_to_framework(parsed_sections: dict, feature_name: str):
    summary = {}

    for section, keywords in parsed_sections.items():
        if section == "BUSINESS":
            file_path = f"keywords/business/{feature_name}_business.robot"
            #nếu chưa có file thì tạo mới
            if not os.path.exists(file_path):
                os.makedirs(os.path.dirname(file_path), exist_ok=True)
                with open(file_path, "w", encoding="utf-8") as f:
                    f.write("*** Settings ***\n\n*** Keywords ***\n")
        else:
            file_path = FILE_MAPPING[section]

        existing_names, existing_normalized, existing_capabilities = get_existing_keywords(file_path)

        new_keywords = filter_keywords(
            keywords,
            existing_names,
            existing_normalized,
            existing_capabilities
        )

        if new_keywords:
            append_keywords(file_path, new_keywords)

        summary[section] = {
            "total_generated": len(keywords),
            "new_added": len(new_keywords)
        }

    return summary

def generate_for_features(feature_name: str):
    input_file = os.path.join(INPUT_DIR, f"{feature_name}.txt")

    if not os.path.exists(input_file):
        print(f" Không tìm thấy file: {input_file}")
        sys.exit(1)

    os.makedirs(OUTPUT_DIR, exist_ok=True)

    prompt_template = read_file(PROMPT_FILE)
    feature_content = read_file(input_file)

    prompt = prompt_template.replace("{{FEATURE}}",feature_content)
    
    output_path = os.path.join(
        OUTPUT_DIR, f"{feature_name}_keywords.txt"
        )
    # ===== HỎI TRƯỚC KHI GHI ĐÈ =====
    if os.path.exists(output_path):
        choice = input(
            f"File '{feature_name}_keywords.txt' đã tồn tại. Ghi đè không? (Y/N): "
            ).strip().lower()

        if choice != "y":
            print(f"Bỏ qua feature: {feature_name}")
            return
        
    print(f" Đang generate keyword cho feature: {feature_name} ...")

    result = call_ollama(prompt)
    
    with open(output_path, "w", encoding="utf-8") as f:
        f.write(result)

    print(f"Generated keywords for: {feature_name}")
    
    # ===== LƯU OUTPUT GỐC =====
    print(f"Đã lưu kết quả AI vào: {output_path}")

    # ===== PARSE VÀ INJECT =====
    parsed_sections = parse_keywords(result)
    if not any(parsed_sections.values()):
        print("⚠ AI output không đúng format. Không inject vào framework.")
        return

    summary = write_to_framework(parsed_sections, feature_name)
    
    # ===== NEW: GENERATE FLOW =====
    framework_keywords = load_framework_keywords(feature_name)

    flow_text = generate_business_flow(
        feature_name,
        framework_keywords,
        feature_content
    )

    # ===== NEW: GENERATE ROBOT TEST =====
    generate_robot_test(feature_name, flow_text)

    print("\n===== SUMMARY =====")
    for section, data in summary.items():
        if data["new_added"] == 0:
            print(f"{section}: No new keywords.")
        else:
            print(
                f"{section}: Generated={data['total_generated']} | "
                f"New Added={data['new_added']}"
            )

    print("\nHoàn tất inject keyword vào framework.")
    

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Vui lòng cung cấp tên feature để generate keywords.")
        print("Cách sử dụng: python generate_keywords_use_AI/generate_keyword.py <feature_name>")
        sys.exit(1)

    feature_name = sys.argv[1]
    generate_for_features(feature_name)