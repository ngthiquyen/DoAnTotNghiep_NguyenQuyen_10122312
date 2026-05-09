*** Settings ***
Resource    ../keywords/base_test.robot
Resource    ../keywords/business/register_business.robot
Resource    ../keywords/ui/common_keywords.robot
Resource    ../keywords/verify/verify.robot

Variables   ../pages/register_page.py
Test Setup     Open Browser Suite    Register Feature
Test Teardown    Run Keywords
...    Run Keyword If Test Failed    Handle Test Failure
...    AND    Close Browser Suite

*** Test Cases ***
register Auto Test
    [Documentation]    Auto generated from AI flow
    Open Register Page
    Fill Register Form      ngminhtu@gmail.com   ngminhtu   ngminhtu
    Submit Register Form
    Verify Page Contains Text      Email đã được sử dụng

register Auto Test 2
    [Documentation]    Auto generated from AI flow
    Open Register Page
    Fill Register Form      ${EMPTY}   ngminhtu   ngminhtu
    Submit Register Form
    Verify Required Field Message      Please fill out this field.

register Auto Test 3
    [Documentation]    Auto generated from AI flow
    Open Register Page
    Fill Register Form      ngminhtu@gmail.com   ${EMPTY}   ngminhtu
    Submit Register Form
    Verify Required Field Message      Please fill out this field.

register Auto Test 4
    [Documentation]    Auto generated from AI flow
    Open Register Page
    Fill Register Form      ngminhtu@gmail.com    ngminhtu    ${EMPTY}
    Submit Register Form
    Verify Required Field Message      Please fill out this field.

register Auto Test 5
    [Documentation]    Auto generated from AI flow
    Open Register Page
    Fill Register Form      ngminhtugmail.com    ngminhtu    ngminhtu
    Submit Register Form
    Verify Required Field Message      Please 

register Auto Test 6
    [Documentation]    Auto generated from AI flow
    Open Register Page
    Fill Register Form      ngminhtu@       ngminhtu    ngminhtu
    Submit Register Form   
    Verify Required Field Message      Please 

register Auto Test 7
    [Documentation]    Auto generated from AI flow
    Open Register Page
    Fill Register Form      ngminhtu@gmail    ngmi    ngmi
    Submit Register Form   
    Verify Element Text Contains     ${ERROR_MSG_REGISTER}      Mật khẩu tối thiểu phải có 6 ký tự