*** Settings ***
Resource    ../keywords/base_test.robot
Resource    ../keywords/business/login_business.robot
Resource    ../keywords/ui/common_keywords.robot
Resource    ../keywords/verify/verify.robot
Library    DataDriver    ../data/data_test.xlsx      sheet_name=Login

Variables    ../pages/locators_page.py
Suite Setup     Open Browser Suite    Login Feature
Suite Teardown  Close Browser Suite
Test Teardown    Run Keyword If Test Failed    Handle Test Failure
Test Template    Login Flow 

*** Test Cases ***
login Auto Test with ${email} and ${password} expecting ${expected}

*** Keywords ***
Login Flow
    [Arguments]        ${email}    ${password}    ${expected}
    Open Login Page     
    Fill Login Form     ${email}    ${password}
    Submit Login Form
    IF    '${email}' == '' or '${password}' == ''
        Verify Required Field Message       ${expected}

    ELSE
        Verify Element Text Contains    ${ERROR_MSG}    ${LOGOUT_BTN}    ${expected}
    END