from openpyxl import load_workbook
import os
from robot.running.model import Keyword


def visit_suite(suite):
    file_path = "data/data1.xlsx"

    if not suite.tests:
        return

    test_name = os.path.basename(suite.source).lower()

    #Map sheet và keyword
    if "search" in test_name:
        sheet_name = "Search"
        keyword_name = "Execute Search Test"
    elif "login" in test_name:
        sheet_name = "Login"
        keyword_name = "Execute Login Test"
    elif "register" in test_name:
        sheet_name = "Register"
        keyword_name = "Execute Register Test"
    elif "order" in test_name:
        sheet_name = "Order"
        keyword_name = "Execute Order Test"
    elif "profile" in test_name:
        sheet_name = "Profile"
        keyword_name = "Execute Profile Test"
    else:
        raise Exception("Không xác định được sheet")

    wb = load_workbook(file_path)
    sheet = wb[sheet_name]

    rows = list(sheet.values)

    # XÓA TOÀN BỘ TEST CŨ
    del suite.tests[:]

    for i, row in enumerate(rows[1:], start=1):
        name = row[0] or f"Test_{i}"

        # TẠO TEST MỚI ĐÚNG CÁCH
        test = suite.tests.create(name=name)
        print(f"Creating test: {name} with keyword: {keyword_name}")

        # convert None → ""
        test_args = [str(value) if value is not None else "" for value in row[1:]]
        test.body.clear()
        # TẠO KEYWORD ĐÚNG CÁCH
        test.body.create_keyword(
            name=keyword_name,
            args=test_args
        )
        
        