*** Settings ***
Resource    ../keywords/business/login_business.robot
Resource    ../keywords/business/search_business.robot
Resource    ../keywords/business/order_business.robot
Resource    ../keywords/business/register_business.robot
Resource    ../keywords/verify/verify.robot

*** Test Cases ***
E2E login_20260520_015214
    [Documentation]    AI generated E2E

    Login To System
    Verify Current URL Should Be
    Update Profile
    Verify Element Text Contains
    Verify Page Contains Text
