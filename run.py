import os
import sys
import subprocess

FEATURE_MAP = {
    "1": ("search", "tests/test_search.robot"),
    "2": ("login", "tests/test_login.robot"),
}

print("===== CHỌN TEST =====")
print("1. Search")
print("2. Login")
print("3. Register")
print("4. Order")
print("5. Profile")

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
command = f"""
python -X utf8 -m robot ^
--outputdir reports/robot ^
--listener allure_robotframework:reports/allure/results ^
--prerunmodifier utils/mini_datadriver.py ^
{test_file}
"""

os.system(command)

print("\nGenerating Allure report...\n")

# Generate allure report
os.system("allure generate reports/allure/results -o reports/allure/report --clean")

# Open report
subprocess.Popen("allure open reports/allure/report", shell=True)