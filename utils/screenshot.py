import os
from datetime import datetime

BASE_REPORT_DIR = os.path.abspath("reports")

def Capture_Screenshot(driver, test_name):
    time_str = datetime.now().strftime("%H%M%S")
    folder = os.path.join(BASE_REPORT_DIR, "screenshots", datetime)

    os.makedirs(folder, exist_ok=True)

    file_path = os.path.join(folder, f"{test_name}_{time_str}.png")
    driver.save_screenshot(file_path)

    return file_path
