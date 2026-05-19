from datetime import datetime
import os
import sys
import subprocess
import shutil


FEATURE_MAP = {
    "1": ("search", "tests/search_auto_20260510_173326.robot"),
    "2": ("login", "tests/login_auto_20260510_150439.robot"),
    "3": ("register", "tests/register_auto_20260510_162840.robot"),
    "4": ("order", "tests/order_auto_20260515_150607.robot"),
    "5": ("profile", "tests/e2e/login_20260517_213426.robot"),
    "6": ("e2e", "tests/e2e/login_search_order_20260514_124712.robot")
}

print("===== CHỌN TEST =====")
print("1. Search")
print("2. Login")
print("3. Register")
print("4. Order")
print("5. Profile")
print("6. E2E")

# ===== CONFIG =====
venv_python = os.path.join(".venv", "Scripts", "python.exe")

ALLURE_CMD = shutil.which("allure")

if not ALLURE_CMD:
    ALLURE_CMD = r"C:\Users\Dell\scoop\apps\allure\current\bin\allure.bat"


choice = input("Nhập lựa chọn: ").strip()

if choice not in FEATURE_MAP:
    print("Lựa chọn không hợp lệ")
    sys.exit(1)

feature, test_file = FEATURE_MAP[choice]

print(f"\nRunning {feature}...\n")

# ===== TIME STAMP =====
timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")

# ===== PATH THEO TỪNG CHỨC NĂNG =====
ALLURE_FEATURE_BASE = os.path.join("reports", "allure", feature)

RESULTS_DIR = os.path.join(ALLURE_FEATURE_BASE, "results")
REPORT_DIR = os.path.join(ALLURE_FEATURE_BASE, f"report_{timestamp}")
LAST_REPORT = os.path.join(ALLURE_FEATURE_BASE, "last_report")

ROBOT_DIR = os.path.join("reports", "robot", feature, f"run_{timestamp}")

# ===== XÓA RESULTS CŨ ĐỂ KHÔNG BỊ LẪN TEST =====
if os.path.exists(RESULTS_DIR):
    shutil.rmtree(RESULTS_DIR)

# ===== CREATE DIR =====
os.makedirs(RESULTS_DIR, exist_ok=True)
os.makedirs(ROBOT_DIR, exist_ok=True)

# ===== COPY HISTORY CŨ CỦA ĐÚNG FEATURE ĐỂ TẠO TREND =====
history_src = os.path.join(LAST_REPORT, "history")
history_dst = os.path.join(RESULTS_DIR, "history")

if os.path.exists(history_src):
    shutil.copytree(history_src, history_dst, dirs_exist_ok=True)

# ===== RUN ROBOT =====
result = subprocess.run([
    venv_python, "-X", "utf8", "-m", "robot",
    "--outputdir", ROBOT_DIR,
    "--listener", f"allure_robotframework;{RESULTS_DIR}",
    test_file
])

if result.returncode != 0:
    print("Test failed")
else:
    print("Test passed")


print("\nGenerating Allure report...\n")

# ===== GENERATE ALLURE REPORT =====
try:
    subprocess.run([
        ALLURE_CMD,
        "generate",
        RESULTS_DIR,
        "-o",
        REPORT_DIR,
        "--clean"
    ], check=True)

    # ===== SAVE LAST REPORT RIÊNG CHO FEATURE =====
    if os.path.exists(LAST_REPORT):
        shutil.rmtree(LAST_REPORT)

    shutil.copytree(REPORT_DIR, LAST_REPORT)

    # ===== OPEN REPORT =====
    subprocess.Popen(f'"{ALLURE_CMD}" open "{REPORT_DIR}"', shell=True)

    print(f"\nAllure report generated: {REPORT_DIR}")

except Exception as e:
    print("Không chạy được Allure")
    print("Lỗi:", e)