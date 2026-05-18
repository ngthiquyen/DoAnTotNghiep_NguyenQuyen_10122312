*** Settings ***
Resource    ../keywords/base_test.robot
Resource    ../keywords/business/login_business.robot
Resource    ../keywords/business/search_business.robot
Resource    ../keywords/business/order_business.robot
Resource    ../keywords/business/register_business.robot
Resource    ../keywords/business/profile_business.robot
Resource    ../keywords/verify/verify.robot

Variables    ../pages/search_page.py
Variables    ../pages/login_page.py
Variables    ../pages/home_page.py
Variables    ../pages/profile_page.py

Test Setup     Open Browser Suite    Profile Feature
Test Teardown    Run Keywords
...    Run Keyword If Test Failed    Handle Test Failure
...    AND    Close Browser Suite

*** Test Cases ***
E2E login_20260517_213426_1
    [Documentation]    AI generated E2E

    Login To System         ngvanhoan@gmail.com     ngvanhoan
    Select Product From Result     0
    Verify Element Should Be Visible    ${ACCOUNT_PAGE} 
    Update Profile      Nguyen Van Hoan    0123456789    123 Nguyen Trai Street
    Verify Element Text Contains        ${SUCCESS_MSG}    Cập nhật thông tin tài khoản thành công!

E2E login_20260517_213426_2
    [Documentation]    AI generated E2E

    Login To System         ngvanhoan@gmail.com     ngvanhoan
    Select Product From Result     0
    Verify Element Should Be Visible    ${ACCOUNT_PAGE}  
    Update Profile      ${EMPTY}    0123456789    123 Nguyen Trai Street
    Verify Element Text Contains        ${SUCCESS_MSG}    Cập nhật thông tin tài khoản thành công!

E2E login_20260517_213426_3
    [Documentation]    AI generated E2E

    Login To System         ngvanhoan@gmail.com     ngvanhoan
    Select Product From Result     0
    Verify Element Should Be Visible    ${ACCOUNT_PAGE}  
    Update Profile      Nguyen Van Hoan    ${EMPTY}    123 Nguyen Trai Street
    Verify Element Text Contains        ${SUCCESS_MSG}    Cập nhật thông tin tài khoản thành công!

E2E login_20260517_213426_4
    [Documentation]    AI generated E2E

    Login To System         ngvanhoan@gmail.com     ngvanhoan
    Select Product From Result     0
    Verify Element Should Be Visible    ${ACCOUNT_PAGE}  
    Update Profile      Nguyen Van Hoan    0123456789   ${EMPTY}
    Verify Element Text Contains        ${SUCCESS_MSG}    Cập nhật thông tin tài khoản thành công!

E2E login_20260517_213426_5
    [Documentation]    AI generated E2E

    Login To System         ngvanhoan@gmail.com     ngvanhoan
    Select Product From Result     0
    Verify Element Should Be Visible    ${ACCOUNT_PAGE}  
    Update Profile      Nguyen Van Hoan    012345678@    123 Nguyen Trai Street
    Verify Element Text Contains        ${ERROR_MSG}    Vui lòng nhập ít nhất một số điện thoại bạn đang sử dụng

E2E login_20260517_213426_6
    [Documentation]    AI generated E2E

    Login To System         ngvanhoan@gmail.com     ngvanhoan
    Select Product From Result     0
    Verify Element Should Be Visible    ${ACCOUNT_PAGE}  
    Update Profile      Nguyen Van Hoan    01234    123 Nguyen Trai Street
    Verify Element Text Contains        ${ERROR_MSG}    Vui lòng nhập ít nhất một số điện thoại bạn đang sử dụng

E2E login_20260517_213426_7
    [Documentation]    AI generated E2E

    Login To System         ngvanhoan@gmail.com     ngvanhoan
    Select Product From Result     0
    Verify Element Should Be Visible    ${ACCOUNT_PAGE}  
    Update Profile      Nguyen Van Hoan    012345678999    123 Nguyen Trai Street
    Verify Element Text Contains        ${ERROR_MSG}    Vui lòng nhập ít nhất một số điện thoại bạn đang sử dụng

E2E login_20260517_213426_8
    [Documentation]    AI generated E2E

    Login To System         ngvanhoan@gmail.com     ngvanhoan
    Select Product From Result     0
    Verify Element Should Be Visible    ${ACCOUNT_PAGE}  
    Update Profile      Nguyen Van Hoan    012345678aa    123 Nguyen Trai Street
    Verify Element Text Contains        ${ERROR_MSG}    Vui lòng nhập ít nhất một số điện thoại bạn đang sử dụng
