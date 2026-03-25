import logging
import os
from datetime import datetime
from robot.api import logger as robot_logger

BASE_REPORT_DIR = "reports"
LOGGER = None   # biến global để Robot dùng

def Init_Logger(feature_name):
    global LOGGER
    today = datetime.now().strftime("%Y-%m-%d")
    log_dir = os.path.join(BASE_REPORT_DIR, "logs", today)

    os.makedirs(log_dir, exist_ok=True)

    logger = logging.getLogger(feature_name)
    logger.setLevel(logging.INFO)

    log_file = os.path.join(log_dir, f"{feature_name}.log")

    if not logger.handlers:
        file_handler = logging.FileHandler(log_file, encoding="utf-8")
        formatter = logging.Formatter(
            "%(asctime)s - %(levelname)s - %(message)s"
        )
        file_handler.setFormatter(formatter)
        logger.addHandler(file_handler)
    LOGGER = logger
    return logger
# === KEYWORDS CHO ROBOT ===

def _safe_to_string(arg):
    try:
        # Nếu là WebElement → tránh lỗi
        if hasattr(arg, "tag_name"):
            return f"[WebElement: {arg.tag_name}]"
        return str(arg)
    except Exception:
        return "[Unprintable Object]"
    
def log_info(*args):
    message = " ".join(_safe_to_string(a) for a in args)

    # 1. Ghi file
    LOGGER.info(message)

    # 2. Ghi vào Robot (=> log.html + Allure)
    robot_logger.info(message)

def log_error(*args):
    message = " ".join(_safe_to_string(a) for a in args)
    LOGGER.error(message)
    robot_logger.error(message)
