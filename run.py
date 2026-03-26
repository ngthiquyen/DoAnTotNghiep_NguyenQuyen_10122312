import os
import sys
import subprocess
import shutil

shutil.rmtree("reports/allure/results", ignore_errors=True)
shutil.rmtree("reports/allure/report", ignore_errors=True)
shutil.rmtree("output", ignore_errors=True)

FEATURE_MAP = {
    "1": ("search", "tests/test_search.robot"),
    "2": ("login", "tests/test_login.robot"),
    "3": ("register", "tests/test_register.robot"),
    "4": ("order", "tests/test_order.robot"),
    "5": ("profile", "tests/test_profile.robot"),
}

print("===== CHỌN TEST =====")
print("1. Search")
print("2. Login")
print("3. Register")
print("4. Order")
print("5. Profile")

# ===== CONFIG =====
venv_python = os.path.join(".venv", "Scripts", "python.exe")

# Auto detect allure
ALLURE_CMD = shutil.which("allure")

# fallback nếu không detect được (sửa lại path nếu cần)
if not ALLURE_CMD:
    ALLURE_CMD = r"C:\Users\Dell\scoop\apps\allure\current\bin\allure.bat"


choice = input("Nhập lựa chọn: ").strip()

if choice not in FEATURE_MAP:
    print("Lựa chọn không hợp lệ")
    exit()

feature, test_file = FEATURE_MAP[choice]

print(f"\nRunning {feature}...\n")

# Tạo folder nếu chưa có
os.makedirs("reports/robot", exist_ok=True)
os.makedirs("reports/allure/results", exist_ok=True)

# Command chạy robot
result = subprocess.run([
    venv_python, "-X", "utf8", "-m", "robot",
    "--outputdir", "reports/robot",
    "--listener", "allure_robotframework:reports/allure/results",
    test_file
])
# Nếu fail thì dừng luôn
if result.returncode != 0:
    print("Test failed")
else:
    print("Test passed")


print("\nGenerating Allure report...\n")

# Generate allure report
try:
    subprocess.run([
        ALLURE_CMD,
        "generate",
        "reports/allure/results",
        "-o",
        "reports/allure/report",
        "--clean"
    ], check=True)

    subprocess.Popen(f'"{ALLURE_CMD}" open reports/allure/report', shell=True)

except Exception as e:
    print("Không chạy được Allure")
    print("Lỗi:", e)