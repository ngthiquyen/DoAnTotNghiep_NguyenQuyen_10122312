from asyncio.log import logger
import logging
import os
from datetime import datetime

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

def log_info(msg):
    LOGGER.info(msg)

def log_error(msg):
    LOGGER.error(msg)