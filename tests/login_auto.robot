*** Settings ***
Resource    ../keywords/base_test.robot
Resource    ../keywords/business/login_business.robot
Resource    ../keywords/ui/common_keywords.robot
Resource    ../keywords/verify/verify.robot
Variables    ../pages/login_page.py
Variables    ../pages/home_page.py


Test Setup     Open Browser Suite    Login Feature
Test Teardown    Run Keywords
...    Run Keyword If Test Failed    Handle Test Failure
...    AND    Close Browser Suite

*** Test Cases ***

login Auto Test 2
    [Documentation]    Auto generated from AI flow
    Open Login Page     
    Fill Login Form     ngvanhoan@gmail.com    123456789
    Submit Login Form
    Verify Element Text Contains      ${ERROR_MSG}      Tài khoản hoặc mật khẩu không chính xác

login Auto Test 3
    [Documentation]    Auto generated from AI flow
    Open Login Page     
    Fill Login Form     tuyetmai99@gmail.com    ${EMPTY}
    Submit Login Form
    Verify Required Field Message      Please fill out this field.

login Auto Test 1
    [Documentation]    Auto generated from AI flow
    Open Login Page     
    Fill Login Form     ngvanhoan@gmail.com    ngvanhoan
    Submit Login Form
    Verify Element Text Contains      ${ACCOUNT_PAGE}     Tài khoản
    Verify Page Contains Element      ${LOGOUT_BTN}