import os
import json
import re
import sys
import requests



sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))
from utils.rune2e import run_robot_test


OLLAMA_URL = "http://localhost:11434/api/generate"
MODEL = "llama3"

UC_PROMPT = "generate_keywords_use_AI/prompt/generate_usecase_prompt.txt"
E2E_PROMPT = "generate_keywords_use_AI/prompt/generate_e2e_flow_prompt.txt"


# ===== READ FILE =====
def read_file(path):
    with open(path, "r", encoding="utf-8") as f:
        return f.read()


# ===== CALL AI =====
def call_ollama(prompt):
    payload = {
        "model": MODEL,
        "prompt": prompt,
        "stream": False
    }

    response = requests.post(OLLAMA_URL, json=payload)
    return response.json()["response"]


# ===== LOAD FLOW TỪ TESTS =====
def load_available_flows():
    flows = []

    if not os.path.exists("tests"):
        print("Không có folder tests/")
        sys.exit(1)

    for file in os.listdir("tests"):
        if file.endswith("_auto.robot"):
            name = file.replace("_auto.robot", "")

            flows.append({
                "name": name,
                "file": f"tests/{file}"
            })

    if not flows:
        print("Không tìm thấy flow nào trong tests/")
        sys.exit(1)

    return flows



# ===== MÔ TẢ FLOW =====
FLOW_DESCRIPTIONS = {
    "login": "user logs into system",
    "search": "user searches product",
    "order": "user adds to cart and checkout",
    "register": "user creates account"
}


def build_flow_text(flows):
    lines = []
    for f in flows:
        desc = FLOW_DESCRIPTIONS.get(f["name"], "")
        lines.append(f"- {f['name']}: {desc}")
    return "\n".join(lines)


# ===== SINH USE CASE =====
def generate_use_cases():
    prompt = read_file(UC_PROMPT)
    result = call_ollama(prompt)

    use_cases = [line.strip() for line in result.splitlines() if line.strip()]
    return use_cases


# ===== SAFE PARSE JSON =====
def safe_parse_json(text):
    match = re.search(r"\[.*\]", text, re.DOTALL)
    if match:
        try:
            return json.loads(match.group())
        except:
            pass

    print("Parse lỗi:", text)
    return []

# ===== SINH E2E FLOW =====
def generate_e2e_flow(use_case, flows):
    prompt_template = read_file(E2E_PROMPT)

    flow_text = build_flow_text(flows)

    prompt = prompt_template \
        .replace("{{USE_CASE}}", use_case) \
        .replace("{{FLOWS}}", flow_text)

    result = call_ollama(prompt)

    return safe_parse_json(result)

# ===== MAP FLOW → FILE =====
def map_flow_to_files(e2e_flow, flows):
    files = []

    for step in e2e_flow:
        found = False

        for f in flows:
            if f["name"].lower() == step.lower():
                files.append(f["file"])
                found = True
                break

        if not found:
            print(f"⚠ Flow không tồn tại: {step}")

    return files

# ===== CHECK IMPLEMENT =====
def is_implemented(file_path):
    with open(file_path, "r", encoding="utf-8") as f:
        content = f.read()
        return "# TODO" not in content
    
    
# ===== RUN E2E =====
def run_e2e(file_list):
    for file in file_list:
        if not is_implemented(file):
            print(f"⚠ Chưa implement: {file} → skip")
            return

        success = run_robot_test(file)

        if not success:
            print(f" Fail tại: {file}")
            return

    print(" E2E PASSED")


# ===== SAVE =====
def save_flow(flow, name):
    os.makedirs("generate_keywords_use_AI/output", exist_ok=True)

    filename = name.lower().replace(" ", "_")

    path = f"generate_keywords_use_AI/output/{filename}.json"

    with open(path, "w", encoding="utf-8") as f:
        json.dump(flow, f, indent=4)

    print(f"Saved: {path}")


# ===== MAIN =====
if __name__ == "__main__":
    mode = "generate"
    if len(sys.argv) > 1:
        mode = sys.argv[1]

    flows = load_available_flows()

    print("Available flows:", [f["name"] for f in flows])

    use_cases = generate_use_cases()

    print("\nGenerated Use Cases:")
    for uc in use_cases:
        print("-", uc)

    for uc in use_cases:
        print(f"\n PROCESS: {uc}")

        e2e_flow = generate_e2e_flow(uc, flows)

        if not e2e_flow:
            print("⚠ Không tạo được flow → skip")
            continue

        print("E2E Flow:")
        for i, step in enumerate(e2e_flow, 1):
            print(f"  {i}. {step}")

        save_flow(e2e_flow, uc)

        files = map_flow_to_files(e2e_flow, flows)

        if mode == "execute":
            run_e2e(files)
        else:
            print("⚠ Skip execution (generate only)")