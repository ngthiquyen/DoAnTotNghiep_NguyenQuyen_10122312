*** Settings ***
Library    SeleniumLibrary  run_on_failure=None
Library    ../utils/logger.py
Library    ../utils/screenshot.py
Library    OperatingSystem
Library    String
Library    DateTime


*** Keywords ***
Open Browser Suite
    [Arguments]    ${feature}
    Init Logger    ${feature}

    Open Browser    about:blank    chrome
    Maximize Browser Window
    Log Info    ================================
    Log Info    Browser opened

Close Browser Suite
    Log Info    Close browser
    Log Info    ================================
    Close All Browsers

Test Teardown    Run Keyword If Test Failed    Handle Test Failure

Handle Test Failure
    Log    Test failed: ${TEST NAME}

    # 1. Timestamp chuẩn
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S

    # 2. Clean test name (dùng TC cho gọn)
    ${clean_test_name}=    Replace String    ${TEST NAME}    ${SPACE}    _
    ${clean_test_name}=    Replace String    ${clean_test_name}    :    _
    ${clean_test_name}=    Replace String    ${clean_test_name}    /    _
    ${clean_test_name}=    Replace String    ${clean_test_name}    \\    _

    # 3. Folder
    ${dir}=    Set Variable    ${OUTPUT DIR}${/}screenshots
    Create Directory    ${dir}

    # 4. Path
    ${path}=    Set Variable    ${dir}${/}${clean_test_name}_${timestamp}.png

    # 5. Screenshot
    Capture Page Screenshot    ${path}

    Log    Screenshot saved at: ${path}

