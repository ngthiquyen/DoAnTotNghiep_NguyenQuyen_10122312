*** Settings ***
Resource    ../keywords/base_test.robot
Resource   ../keywords/ui/common_keywords.robot
Resource   ../keywords/verify/verify.robot
Resource   ../keywords/business/business_keywords.robot
Library    DataDriver    ../data/data_test.xlsx      sheet_name=Register

Variables    ../pages/locators_page.py
Suite Setup     Open Browser Suite    Register Feature
Suite Teardown  Close Browser Suite
Test Teardown    Run Keyword If Test Failed    Handle Test Failure
Test Template    Register Test

*** Test Cases ***
Register Test with ${email} and ${password} and ${re_password} expecting ${expected}

*** Keywords ***
Register Test
    [Arguments]        ${email}    ${password}    ${re_password}    ${expected}
    Navigate To Page    ${URL}
    Click On Element    ${REGISTER_URL}
    Input Text To Element    ${EMAIL_INPUT}       ${email}
    Input Text To Element    ${PASSWORD_INPUT}    ${password}
    Input Text To Element    ${RE_PASSWORD_INPUT}  ${re_password}
    Submit Form    ${REGISTER_BTN}
    
    # ===== 1. CHECK VALIDATION (input trống) =====
    IF     '${email}' == '' or '${password}' == '' or '${re_password}' == ''
        Verify Required Field Message       ${expected}
    
    # ===== 2. CHECK VALIDATION (email không hợp lệ) và message lỗi, thành công từ hệ thống =====
    ELSE
        IF  '${expected}' == 'invalid'
            Verify Required Field Message       ${expected}
        ELSE
            Verify Message Or Page   ${ERROR_MSG_REGISTER}   ${ACCOUNT_NAME}   ${expected}
        END
    END