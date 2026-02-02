import os
import sys
from click import prompt
import requests

# ===== CẤU HÌNH =====
OLLAMA_URL = "http://localhost:11434/api/generate"
MODEL = "llama3"

INPUT_DIR = "ai/input"
OUTPUT_DIR = "ai/output"
PROMPT_FILE = "ai/prompt/generate_keyword_prompt.txt"

def read_file(path):
    with open(path, "r", encoding="utf-8") as f:
        return f.read()

def call_ollama(prompt: str) -> str:
    payload = {
        "model": MODEL,
        "prompt": prompt,
        "stream": False
    }

    response = requests.post(OLLAMA_URL, json=payload)
    response.raise_for_status()

    return response.json()["response"]

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


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Vui lòng cung cấp tên feature để generate keywords.")
        print("Cách sử dụng: python ai/generate_keyword.py <feature_name>")
        sys.exit(1)

    feature_name = sys.argv[1]
    generate_for_features(feature_name)