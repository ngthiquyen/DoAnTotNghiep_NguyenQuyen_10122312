*** Settings ***
Resource    ..//keywords/base_test.robot
Resource    ../keywords/business/order_business.robot
Resource    ../keywords/business/search_business.robot
Resource    ../keywords/ui/common_keywords.robot
Resource    ../keywords/verify/verify.robot

Variables    ../pages/order_page.py
Variables    ../pages/search_page.py

Test Setup     Open Browser Suite    Order Feature
Test Teardown    Run Keywords
...    Run Keyword If Test Failed    Handle Test Failure
...    AND    Close Browser Suite


*** Test Cases ***
order Auto Test 1
    [Documentation]    Auto generated from AI flow

    Add To Cart      1
    Place Order     Linh    0123456789   linhnguyen@gmail   123 Main St, City   Giao giờ hành chính
    Verify Element Text Contains    ${ORDER_SUCCESS_MSG}    ĐƠN HÀNG CỦA BẠN ĐÃ ĐƯỢC GỬI ĐI!
    Verify Current URL Should Be      ${URL_ORDER_SUCCESS}

order Auto Test 2
    [Documentation]    Auto generated from AI flow

    Add To Cart      0
    Place Order     Linh    ${EMPTY}   linhnguyen@gmail   123 Main St, City   Giao giờ hành chính
    Verify Required Field Message    Please fill out this field.    

order Auto Test 3
    [Documentation]    Auto generated from AI flow

    Add To Cart      0
    Place Order     Linh    0123456789  linhnguyen@gmail   ${EMPTY}   Giao giờ hành chính
    Verify Required Field Message    Please fill out this field.  

order Auto Test 4
    [Documentation]    Auto generated from AI flow

    Add To Cart      0
    Place Order     Linh    012345678999  linhnguyen@gmail   123 Main St, City   Giao giờ hành chính  
    Verify Element Text Contains    ${ORDER_ERROR_MSG}    Vui lòng nhập ít nhất một số điện thoại bạn đang sử dụng

order Auto Test 5
    [Documentation]    Auto generated from AI flow

    Add To Cart      0
    Place Order     Linh    01234  linhnguyen@gmail   123 Main St, City   Giao giờ hành chính  
    Verify Element Text Contains    ${ORDER_ERROR_MSG}    Vui lòng nhập ít nhất một số điện thoại bạn đang sử dụng