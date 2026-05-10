*** Settings ***
Resource    ../keywords/business/login_business.robot
Resource    ../keywords/business/search_business.robot
Resource    ../keywords/business/order_business.robot
Resource    ../keywords/business/register_business.robot
Resource    ../keywords/verify/verify.robot

*** Test Cases ***
E2E login_20260510_234657
    [Documentation]    AI generated E2E

    Login To System
    Verify Page Contains Text: 'Mở trang đăng nhập.'
    Verify Element Should Be Visible: 'nút đăng nhập'
    Verify Current URL Should Be: 'trang đăng nhập'
    Verify Page Contains Text: 'Xác minh đăng nhập thành công.'
    Verify Element Should Be Visible: 'tài khoản'
    Update Profile
    Verify Required Field Message: 'họ tên'
    Verify Required Field Message: 'số điện thoại'
    Verify Required Field Message: 'địa chỉ'
    Verify Page Contains Text: 'Xác minh cập nhật thành công.'
