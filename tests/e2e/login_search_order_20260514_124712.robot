*** Settings ***
Resource    ../keywords/base_test.robot
Resource    ../keywords/business/login_business.robot
Resource    ../keywords/business/search_business.robot
Resource    ../keywords/business/order_business.robot
Resource    ../keywords/business/register_business.robot
Resource    ../keywords/verify/verify.robot

Variables    ../pages/login_page.py
Variables    ../pages/search_page.py
Variables    ../pages/order_page.py
Variables    ../pages/home_page.py
Test Setup     Open Browser Suite    E2E Login Search Order
Test Teardown    Run Keywords
...    Run Keyword If Test Failed    Handle Test Failure
...    AND    Close Browser Suite

*** Test Cases ***
E2E login_search_order_20260514_124712_1
    [Documentation]    AI generated E2E

    Login To System     tuyetmai99@gmail.com    tuyetmai99
    Select Product From Result     0
    Verify Element Should Be Visible    ${ACCOUNT_PAGE}
    Search Product      ELA811
    Verify Page Contains Text    ELA811
    Add To Cart From Search Result     0
    Verify Page Contains Element          ${CART_CONTENT}
    Place Order     Tuyet Mai    0123456789   tuyetmai99@gmail   123 Main St, City   Giao giờ hành chính
    Verify Element Text Contains    ${ORDER_SUCCESS_MSG}    ĐƠN HÀNG CỦA BẠN ĐÃ ĐƯỢC GỬI ĐI!
    Verify Current URL Should Be     ${URL_ORDER_SUCCESS}

E2E login_search_order_20260514_124712_2
    [Documentation]    AI generated E2E

    Login To System     tuyetmai99@gmail.com    tuyetmai99
    Select Product From Result     0
    Verify Element Should Be Visible    ${ACCOUNT_PAGE}
    Search Product      ELA811
    Verify Page Contains Text    ELA811
    Add To Cart From Search Result     0
    Verify Page Contains Element          ${CART_CONTENT}
    Place Order     Tuyet Mai    01234  tuyetmai99@gmail   123 Main St, City   Giao giờ hành chính
    Verify Element Text Contains    ${ORDER_ERROR_MSG}    Vui lòng nhập ít nhất một số điện thoại bạn đang sử dụng

E2E login_search_order_20260514_124712_3
    [Documentation]    AI generated E2E

    Login To System         tuyetmai99@gmail.com    tuyetmai99
    Select Product From Result     0
    Verify Element Should Be Visible    ${ACCOUNT_PAGE}
    Search Product      ELA811
    Verify Page Contains Text    ELA811
    Add To Cart From Search Result     0
    Verify Page Contains Element          ${CART_CONTENT}
    Place Order     Tuyet Mai    012345678999   tuyetmai99@gmail   123 Main St, City   Giao giờ hành chính
    Verify Element Text Contains    ${ORDER_ERROR_MSG}    Vui lòng nhập ít nhất một số điện thoại bạn đang sử dụng

E2E login_search_order_20260514_124712_4
    [Documentation]    AI generated E2E

    Login To System     tuyetmai99@gmail.com    tuyetmai99
    Select Product From Result     0
    Verify Element Should Be Visible    ${ACCOUNT_PAGE}
    Search Product      ELA811
    Verify Page Contains Text    ELA811
    Add To Cart From Search Result     0
    Verify Page Contains Element          ${CART_CONTENT}
    Place Order     Tuyet Mai    012345679@   tuyetmai99@gmail   123 Main St, City   Giao giờ hành chính
    Verify Element Text Contains    ${ORDER_ERROR_MSG}    Vui lòng nhập ít nhất một số điện thoại bạn đang sử dụng

E2E login_search_order_20260514_124712_5
    [Documentation]    AI generated E2E

    Login To System     tuyetmai99@gmail.com    tuyetmai99
    Select Product From Result     0
    Verify Element Should Be Visible    ${ACCOUNT_PAGE}
    Search Product      ELA811
    Verify Page Contains Text    ELA811
    Add To Cart From Search Result     0
    Verify Page Contains Element          ${CART_CONTENT}
    Place Order     Tuyet Mai    ${EMPTY}   tuyetmai99@gmail   123 Main St, City   Giao giờ hành chính
    Verify Required Field Message     Please fill out this field.

E2E login_search_order_20260514_124712_6
    [Documentation]    AI generated E2E

    Login To System     tuyetmai99@gmail.com    tuyetmai99
    Select Product From Result     0
    Verify Element Should Be Visible    ${ACCOUNT_PAGE}
    Search Product      ELA811
    Verify Page Contains Text    ELA811
    Add To Cart From Search Result     0
    Verify Page Contains Element          ${CART_CONTENT}
    Place Order     Tuyet Mai    0123456789   tuyetmai99@gmail.com   ${EMPTY}   Giao giờ hành chính
    Verify Required Field Message     Please fill out this field.

E2E login_search_order_20260514_124712_7
    [Documentation]    AI generated E2E

    Login To System     tuyetmai99@gmail.com    tuyetmai99
    Select Product From Result     0
    Verify Element Should Be Visible    ${ACCOUNT_PAGE}
    Search Product      ELA811
    Verify Page Contains Text    ELA811
    Add To Cart From Search Result     0
    Verify Page Contains Element          ${CART_CONTENT}
    Place Order     Tuyet Mai    0123456789   tuyetmai99@   123 Main St, City   Giao giờ hành chính
    Verify Required Field Message     Please 

E2E login_search_order_20260514_124712_8
    [Documentation]    AI generated E2E

    Login To System     tuyetmai99@gmail.com    tuyetmai99
    Select Product From Result     0
    Verify Element Should Be Visible    ${ACCOUNT_PAGE}
    Search Product      ELA811
    Verify Page Contains Text    ELA811
    Add To Cart From Search Result     0
    Verify Page Contains Element          ${CART_CONTENT}
    Place Order     Tuyet Mai    0123456789   @gmail.com   123 Main St, City   Giao giờ hành chính
    Verify Required Field Message     Please

E2E login_search_order_20260514_124712_9
    [Documentation]    AI generated E2E

    Login To System     tuyetmai99@gmail.com    tuyetmai99
    Select Product From Result     0
    Verify Element Should Be Visible    ${ACCOUNT_PAGE}
    Search Product      ELA811
    Verify Page Contains Text    ELA811
    Add To Cart From Search Result     0
    Verify Page Contains Element          ${CART_CONTENT}
    Place Order     Tuyet Mai    0123456789   tuyetmaigmail   123 Main St, City   Giao giờ hành chính
    Verify Required Field Message     Please

E2E login_search_order_20260514_124712_10
    [Documentation]    AI generated E2E

    Login To System     tuyetmai99@gmail.com    tuyetmai99
    Select Product From Result     0
    Verify Element Should Be Visible    ${ACCOUNT_PAGE}
    Search Product      ELA811
    Verify Page Contains Text    ELA811
    Add To Cart From Search Result     0
    Verify Page Contains Element          ${CART_CONTENT}
    Place Order     Tuyet Mai    0123456789   tuyetmai@gmail.   123 Main St, City   Giao giờ hành chính
    Verify Required Field Message     wrong position
