*** Settings ***
Resource    ../keywords/base_test.robot
Resource    ../keywords/business/login_business.robot
Resource    ../keywords/business/search_business.robot
Resource    ../keywords/ui/common_keywords.robot
Resource    ../keywords/verify/verify.robot

Variables    ../pages/search_page.py
Variables    ../pages/login_page.py
Variables    ../pages/home_page.py

Test Setup     Open Browser Suite    Login Feature
Test Teardown    Run Keywords
...    Run Keyword If Test Failed    Handle Test Failure
...    AND    Close Browser Suite

*** Test Cases ***
login Auto Test 1
    [Documentation]    Auto generated from AI flow

    Login To System      ngvanhoan@gmail.com    123456789
    Verify Element Text Contains      ${ERROR_MSG}      Tài khoản hoặc mật khẩu không chính xác

login Auto Test 2
    [Documentation]    Auto generated from AI flow

    Login To System      tuyetmai999    tuyetmai99
    Verify Element Text Contains      ${ERROR_MSG}      Tài khoản hoặc mật khẩu không chính xác

login Auto Test 3
    [Documentation]    Auto generated from AI flow

    Login To System        ngvanhoan@gmail.com     ${EMPTY}
    Verify Required Field Message      Please fill out this field.

login Auto Test 4
    [Documentation]    Auto generated from AI flow

    Login To System      ${EMPTY}    123456789
    Verify Required Field Message      Please fill out this field.

login Auto Test 5
    [Documentation]    Auto generated from AI flow

    Login To System     ngvanhoan@gmail.com   ngvanhoan
    Select Product From Result     0
    Verify Element Text Contains      ${ACCOUNT_PAGE}     Tài khoản
    Verify Page Contains Element      ${LOGOUT_BTN}