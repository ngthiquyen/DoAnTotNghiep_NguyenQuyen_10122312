from datetime import datetime
import os
import sys
import subprocess
import shutil


FEATURE_MAP = {
    "1": ("search", "tests/test_search.robot"),
    "2": ("login", "tests/login_auto.robot"),
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

# ===== TIME STAMP =====
timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")

# ===== PATH =====
RESULTS_DIR = "reports/allure/results"
REPORT_BASE = "reports/allure"
REPORT_DIR = f"{REPORT_BASE}/report_{timestamp}"

ROBOT_DIR = f"reports/robot/run_{timestamp}"

# ===== CREATE DIR =====
os.makedirs(RESULTS_DIR, exist_ok=True)
os.makedirs(ROBOT_DIR, exist_ok=True)

# ===== COPY HISTORY (QUAN TRỌNG - TREND) =====
history_src = f"{REPORT_BASE}/last_report/history"
history_dst = f"{RESULTS_DIR}/history"

if os.path.exists(history_src):
    shutil.copytree(history_src, history_dst, dirs_exist_ok=True)
    
# Command chạy robot
result = subprocess.run([
    venv_python, "-X", "utf8", "-m", "robot",
    "--outputdir", ROBOT_DIR,
    "--listener", f"allure_robotframework:{RESULTS_DIR}",
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
        RESULTS_DIR,
        "-o",
        REPORT_DIR,
        "--clean"
    ], check=True)

    # ===== SAVE LAST REPORT (CHO TREND LẦN SAU) =====
    LAST_REPORT = f"{REPORT_BASE}/last_report"

    if os.path.exists(LAST_REPORT):
        shutil.rmtree(LAST_REPORT)

    shutil.copytree(REPORT_DIR, LAST_REPORT)

    # ===== OPEN REPORT =====
    subprocess.Popen(f'"{ALLURE_CMD}" open {REPORT_DIR}', shell=True)

except Exception as e:
    print("Không chạy được Allure")
    print("Lỗi:", e)