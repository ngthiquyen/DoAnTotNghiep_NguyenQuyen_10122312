*** Settings ***
Resource    ../keywords/base_test.robot
Resource   ../keywords/business/business_keywords.robot
Resource   ../keywords/ui/common_keywords.robot
Resource   ../keywords/verify/verify.robot

Library    DataDriver    ../data/data_test.xlsx      sheet_name=Login

Variables    ../pages/locators_page.py

Suite Setup     Open Browser Suite    Login Feature
Suite Teardown  Close Browser Suite
Test Teardown    Run Keyword If Test Failed    Handle Test Failure

Test Template    Execute Login Test

*** Test Cases ***
Login Test with ${email} and ${password} expecting ${expected}

*** Keywords ***
Execute Login Test
    [Arguments]        ${email}    ${password}    ${expected}
    Navigate To Page    ${URL}
    Click On Element    ${LOGIN_URL}
    Input Text To Element    ${EMAIL_INPUT}       ${email}
    Input Text To Element    ${PASSWORD_INPUT}    ${password}
    Submit Form    ${LOGIN_BTN}
    # ===== 1. CHECK VALIDATION (input trống) =====
    IF    '${email}' == '' or '${password}' == ''
        Verify Required Field Message       ${expected}
    # ===== 2. CHECK ALERT OR SUCCESS =====
    ELSE
        Verify Message Or Page    ${ERROR_MSG}    ${LOGOUT_BTN}    ${expected}
    END
    

