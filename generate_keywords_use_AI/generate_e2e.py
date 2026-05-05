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
        "temperature": 0.1,
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

            if not key:
                continue

            with open(path, "r", encoding="utf-8") as f:
                for line in f:
                    line = line.strip()
                    if line and not line.startswith("***") and not line.startswith("#"):
                        if not line.startswith("    "):
                            groups[key].append(line)

    # VERIFY
    verify = []
    with open("keywords/verify/verify.robot", "r", encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if line and not line.startswith("***") and not line.startswith("#"):
                if not line.startswith("    "):
                    verify.append(line)

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


# ===== PARSE JSON =====
def parse_flow(text: str):
    print("\nRAW AI OUTPUT:\n", text)

    # remove markdown
    text = re.sub(r"```.*?```", "", text, flags=re.DOTALL)

    lines = text.splitlines()
    steps = []

    for line in lines:
        line = line.strip()

        if not line:
            continue

        # bỏ prefix 1. / - / ...
        line = re.sub(r"^\d+[\.\)]\s*", "", line)
        line = re.sub(r"^-\s*", "", line)

        # bỏ dấu ", ở cuối
        line = line.rstrip('",')

        # bỏ dấu "
        line = line.strip('"')

        #  loại rác
        if any(x in line.lower() for x in [
            "here is",
            "note:",
            "output",
            "example"
        ]):
            continue

        # normalize space
        line = " ".join(line.split())

        # chỉ giữ dòng hợp lệ
        if len(line.split()) >= 2:
            steps.append(line)

    print("\nPARSED CLEAN STEPS:", steps)

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

    steps = parse_flow(result)

    if not steps:
        print("⚠ Không tạo được step")
        sys.exit()

    print("\nE2E Steps:")
    for i, s in enumerate(steps, 1):
        print(f"{i}. {s}")

    robot_file = generate_robot_file(steps)

    if mode == "execute":
        run_robot_test(robot_file)