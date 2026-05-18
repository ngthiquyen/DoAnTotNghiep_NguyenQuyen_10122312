*** Settings ***
Library    SeleniumLibrary  run_on_failure=None
Library    ../utils/logger.py
Library   ../utils/allure_helper.py
Library    OperatingSystem
Library    String
Library    DateTime


*** Keywords ***
Open Browser Suite
    [Arguments]    ${feature}
    Init Logger    ${feature}

    Open Browser    about:blank    edge
    Maximize Browser Window
    Log Info    ================================
    Log Info    Browser opened
    Step log   Browser opened

Close Browser Suite
    Log Info    Close browser
    Step log   Close browser
    Close All Browsers

Handle Test Failure
    Log    Test failed: ${TEST NAME}
    Step log   Test failed: ${TEST NAME}

    # 1. Timestamp chuẩn
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S

    # 2. Clean test name (dùng TC cho gọn)
    ${clean_test_name}=    Replace String    ${TEST NAME}    ${SPACE}    _
    ${clean_test_name}=    Replace String    ${clean_test_name}    :    _
    ${clean_test_name}=    Replace String    ${clean_test_name}    /    _
    ${clean_test_name}=    Replace String    ${clean_test_name}    \\    _

    # 3. Folder
    ${dir_in}=    Set Variable    ${OUTPUT DIR}${/}screenshots
    Create Directory    ${dir_in}

    # 4. Folder ngoài project
    ${dir_out}=    Set Variable    ${CURDIR}${/}..${/}screenshots
    Create Directory    ${dir_out}

    # 5. Path
    ${path_in}=    Set Variable    ${dir_in}${/}${clean_test_name}_${timestamp}.png
    ${path_out}=    Set Variable    ${dir_out}${/}${clean_test_name}_${timestamp}.png

    # 6. Chụp vào reports/robot/screenshots
    Capture Page Screenshot    ${path_in}

    # 7. Copy thêm ra screenshots/ ngoài project
    Copy File    ${path_in}    ${path_out}

    Log    Screenshot saved at: ${path_in}
    Step log   Screenshot saved at: ${path_in}
    Attach Screenshot    ${path_in} 

