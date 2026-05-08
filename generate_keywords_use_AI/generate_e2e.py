from datetime import datetime
import os
import json
import re
import sys
import requests

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))
from utils.rune2e import run_robot_test   

OLLAMA_URL = "http://localhost:11434/api/generate"
MODEL = "llama3"

INPUT_FILE = "generate_keywords_use_AI/input/e2e.txt"
E2E_PROMPT = "generate_keywords_use_AI/prompt/generate_e2e_flow_prompt.txt"


# ===== READ FILE =====
def read_file(path):
    with open(path, "r", encoding="utf-8") as f:
        return f.read()

# ===== CALL AI =====
def call_ollama(prompt: str) -> str:
    payload = {
        "model": MODEL,
        "prompt": prompt,
        "stream": False,
        "options": {
        "temperature": 0,
        "num_predict": 301,
        "top_p": 0.9
        }
    }


    response = requests.post(OLLAMA_URL, json=payload)
    return response.json()["response"]


# ===== LOAD KEYWORDS (CHIA NHÓM) =====
def load_keywords_grouped():
    base_dir = "keywords/business"

    groups = {
        "login": [],
        "register": [],
        "search": [],
        "cart": [],
        "order": []
    }

    for root, _, files in os.walk(base_dir):
        for file in files:
            if not file.endswith(".robot"):
                continue

            path = os.path.join(root, file)

            key = None
            name = file.lower()

            if "login" in name:
                key = "login"
            elif "register" in name:
                key = "register"
            elif "search" in name:
                key = "search"
            elif "order" in name:
                key = "order"
            elif "cart" in name:
                key = "cart"

            if not key:
                continue

            with open(path, "r", encoding="utf-8") as f:
                for line in f:
                    raw_line = line.strip()
                    # bỏ rỗng
                    if not raw_line.strip():
                        continue

                    # bỏ section/comment
                    if raw_line.strip().startswith("***"):
                        continue

                    if raw_line.strip().startswith("#"):
                        continue

                    # chỉ lấy keyword level 0
                    if not raw_line.startswith(" ") and not raw_line.startswith("\t"):

                        keyword = raw_line.strip()

                        groups[key].append(keyword)

    # VERIFY
    verify = []
    with open("keywords/verify/verify.robot", "r", encoding="utf-8") as f:
        for line in f:
            raw_line = line.rstrip()

            if not raw_line.strip():
                continue

            if raw_line.strip().startswith("***"):
                continue

            if raw_line.strip().startswith("#"):
                continue

            if not raw_line.startswith(" ") and not raw_line.startswith("\t"):

                verify.append(raw_line.strip())

    return groups, verify


def filter_groups_by_scenario(groups, scenario):
    
    scenario = scenario.lower()

    allowed = []

    if "register" in scenario or "đăng ký" in scenario:
        allowed.append("register")
    if "login" in scenario or "đăng nhập" in scenario:
        allowed.append("login")
    if "search" in scenario or "tìm kiếm" in scenario:
        allowed.append("search")
    if "order" in scenario or "cart" in scenario or "đặt hàng" in scenario:
        allowed.append("order")

    # nếu có order → thường cần login
    if "order" in allowed and "login" not in allowed:
        allowed.append("login")

    print(" Allowed groups:", allowed)

    return {k: v for k, v in groups.items() if k in allowed}

# ===== BUILD PROMPT TEXT (QUAN TRỌNG) =====
def build_keyword_text(groups, verify):
    text = ""

    for k, v in groups.items():
        text += f"=== {k.upper()} KEYWORDS ===\n"
        text += "\n".join(f"- {x}" for x in v)
        text += "\n\n"

    text += "=== VERIFY KEYWORDS ===\n"
    text += "\n".join(f"- {x}" for x in verify)

    return text

# ===== GET ALL VALID KEYWORDS =====
def get_all_valid_keywords(groups, verify):

    valid_keywords = set()

    for keyword_list in groups.values():
        for kw in keyword_list:
            valid_keywords.add(kw.strip())

    for kw in verify:
        valid_keywords.add(kw.strip())

    return valid_keywords


# ===== FILTER INVALID AI STEPS =====
def filter_invalid_steps(steps, valid_keywords):

    cleaned_steps = []

    for step in steps:

        matched = False

        for kw in valid_keywords:

            # step bắt đầu bằng keyword hợp lệ
            if step.startswith(kw):
                matched = True
                break

        if matched:
            cleaned_steps.append(step)
        else:
            print(f"⚠ Invalid keyword removed: {step}")

    return cleaned_steps

def fix_json_string(raw):
    lines = []

    for line in raw.splitlines():
        line = line.strip()

        # bỏ [ ]
        if line.startswith("[") or line.endswith("]"):
            continue

        # bỏ dấu phẩy cuối
        line = line.rstrip(",")

        if not line:
            continue

        # 👉 thêm dấu "" nếu chưa có
        if not line.startswith('"'):
            line = f'"{line}"'

        lines.append(line)

    # ghép lại thành JSON chuẩn
    fixed = "[\n" + ",\n".join(lines) + "\n]"
    return fixed

# ===== SAVE RAW AI OUTPUT =====
def save_raw_ai_output(raw_output):
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")

    path = os.path.join(
        "generate_keywords_use_AI/output",
        f"e2e_{timestamp}.txt"
    )

    os.makedirs(os.path.dirname(path), exist_ok=True)

    with open(path, "w", encoding="utf-8") as f:
        f.write(raw_output)

    print(f"Saved AI output: {path}")

# ===== PARSE AI FLOW =====
def parse_flow(text: str):

    print("\nRAW AI OUTPUT:\n", text)

    # =========================================
    # CASE 1: AI trả JSON array
    # =========================================
    match = re.search(r"\[(.*?)\]", text, re.DOTALL)

    if match:

        raw_json = "[" + match.group(1) + "]"

        try:
            steps = json.loads(raw_json)

        except Exception:

            print("⚠ JSON lỗi → đang auto-fix format...")

            fixed_json = fix_json_string(raw_json)

            print("\nFIXED JSON:\n", fixed_json)

            try:
                steps = json.loads(fixed_json)

            except Exception as e:
                print("⚠ JSON parse error:", e)
                steps = []

        cleaned = []

        for step in steps:

            if not isinstance(step, str):
                continue

            step = " ".join(step.split())

            cleaned.append(step)

        print("\nPARSED CLEAN STEPS:", cleaned)

        return cleaned

    # =========================================
    # CASE 2: AI trả Robot Framework format
    # =========================================

    print("⚠ JSON không tồn tại → fallback parse Robot format")

    steps = []

    lines = text.splitlines()

    skip_keywords = [
        "***",
        "[Documentation]",
        "[Teardown]",
        "End-To-End",
        "Test Cases"
    ]

    for line in lines:

        line = line.strip()

        if not line:
            continue

        # bỏ markdown
        if line.startswith("```"):
            continue

        # bỏ header
        if any(k in line for k in skip_keywords):
            continue

        # chỉ lấy step có khoảng trắng keyword
        if "    " in line or line.startswith("Open") or line.startswith("Fill"):

            step = " ".join(line.split())

            steps.append(step)

    print("\nPARSED ROBOT STEPS:", steps)

    return steps


# ===== BUILD FLOW NAME =====
def build_flow_name(steps):
    name_parts = []

    for s in steps:
        s = s.lower()

        if "register" in s and "register" not in name_parts:
            name_parts.append("register")
        elif "login" in s and "login" not in name_parts:
            name_parts.append("login")
        elif "search" in s and "search" not in name_parts:
            name_parts.append("search")
        elif "order" in s and "order" not in name_parts:
            name_parts.append("order")

    return "_".join(name_parts)

# ===== SAVE ROBOT =====
def generate_robot_file(steps):
    os.makedirs("tests/e2e", exist_ok=True)

    filename = build_flow_name(steps)

    if not filename:
        filename = "e2e_test"

    # 👉 thêm timestamp
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")

    filename = f"{filename}_{timestamp}"

    path = f"tests/e2e/{filename}.robot"

    # tránh ghi đè
    counter = 1
    base_path = path
    while os.path.exists(path):
        path = base_path.replace(".robot", f"_{counter}.robot")
        counter += 1

    with open(path, "w", encoding="utf-8") as f:
        f.write("*** Settings ***\n")
        f.write("Resource    ../keywords/business/login_business.robot\n")
        f.write("Resource    ../keywords/business/search_business.robot\n")
        f.write("Resource    ../keywords/business/order_business.robot\n")
        f.write("Resource    ../keywords/business/register_business.robot\n")
        f.write("Resource    ../keywords/verify/verify.robot\n")

        f.write("\n*** Test Cases ***\n")
        f.write(f"E2E {filename}\n")
        f.write("    [Documentation]    AI generated E2E\n\n")

        for step in steps:
            f.write(f"    {step}\n")

    print(f"Saved Robot: {path}")
    return path


# ===== RUN =====
def run_e2e(robot_file):
    print(f"\n Running: {robot_file}")
    run_robot_test(robot_file)


# ===== MAIN =====
if __name__ == "__main__":
    mode = "generate"
    if len(sys.argv) > 1:
        mode = sys.argv[1]

    print("START GENERATE E2E")

    scenario = read_file(INPUT_FILE)
    print("\nSCENARIO:\n", scenario)

    groups, verify = load_keywords_grouped()

    # FILTER KEYWORD THEO SCENARIO
    groups = filter_groups_by_scenario(groups, scenario)

    keyword_text = build_keyword_text(groups, verify)

    prompt_template = read_file(E2E_PROMPT)

    prompt = prompt_template \
        .replace("{{SCENARIO}}", scenario) \
        .replace("{{KEYWORDS}}", keyword_text)

    print("\nSENDING PROMPT TO AI...\n")

    result = call_ollama(prompt)
    
    save_raw_ai_output(result)

    steps = parse_flow(result)
    # validate AI output
    valid_keywords = get_all_valid_keywords(groups, verify)

    steps = filter_invalid_steps(
        steps,
        valid_keywords
    )
    if not steps:
        print("⚠ Không tạo được step")
        sys.exit()

    print("\nE2E Steps:")
    for i, s in enumerate(steps, 1):
        print(f"{i}. {s}")

    robot_file = generate_robot_file(steps)

    if mode == "execute":
        run_robot_test(robot_file)