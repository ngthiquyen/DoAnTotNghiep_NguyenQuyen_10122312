*** Settings ***
Library    SeleniumLibrary
Library    ../utils/logger.py
Library    ../utils/screenshot.py
Library    AllureLibrary
Library    OperatingSystem
Library    String


*** Keywords ***
Open Browser Suite
    [Arguments]    ${feature}
    Init Logger    ${feature}

    Open Browser    about:blank    chrome
    Maximize Browser Window

    Log Info    Browser opened

Close Browser Suite
    Log Info    Close browser
    Close All Browsers

Test Teardown    Run Keyword If Test Failed    Handle Test Failure

Handle Test Failure
    Log Error    Test failed: ${TEST NAME}

    ${safe_test_name}=    Replace String    ${TEST NAME}    ${SPACE}    _
    ${screenshot_dir}=    Set Variable    ${OUTPUT DIR}/screenshots
    Create Directory    ${screenshot_dir}

    ${path}=    Capture Page Screenshot
    ...    ${screenshot_dir}/${safe_test_name}.png

    AllureLibrary.Attach File    ${path}    Screenshot    image/png


