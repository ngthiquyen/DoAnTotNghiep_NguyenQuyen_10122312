*** Settings ***
Resource    ../keywords/business/login_business.robot
Resource    ../keywords/business/search_business.robot
Resource    ../keywords/business/order_business.robot
Resource    ../keywords/business/register_business.robot
Resource    ../keywords/verify/verify.robot

*** Test Cases ***
E2E login_20260510_022249
    [Documentation]    AI generated E2E

    Open Login Page
    Fill Login Form ${email} ${password}
    Submit Login Form
    Verify Element Should Be Visible ${LOGIN_URL}
    Update Profile ${name} ${phone} ${address}
    Verify Page Contains Text Cập nhật hồ sơ thành công
