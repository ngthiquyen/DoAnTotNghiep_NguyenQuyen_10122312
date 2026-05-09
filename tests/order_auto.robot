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
    Open Home Page
    Select Product From Result     1
    Add To Cart
    Open Cart Page      
    Update Cart      
    Fill Shipping Information      Hoang Nguyen      0123456789      nghoan@gmail.com      123 Main St, Hanoi      Gửi hàng trong giờ hành chính
    Select Payment Method      cod
    Submit Order
    Verify Element Text Contains      ${ORDER_SUCCESS_MSG}     ĐƠN HÀNG CỦA BẠN ĐÃ ĐƯỢC GỬI ĐI!
    
order Auto Test 2
    [Documentation]    Auto generated from AI flow
    Open Home Page
    Select Product From Result     0
    Add To Cart
    Open Cart Page      
    Update Cart 
    Submit Order
    Fill Shipping Information      Hoang Nguyen      ${EMPTY}     nghoan@gmail.com     123 Main St, Hanoi      Gửi hàng trong giờ hành chính
    Select Payment Method      cod
    Submit Order
    Verify Required Field Message     Please fill out this field.

order Auto Test 3
    [Documentation]    Auto generated from AI flow
    Open Home Page
    Select Product From Result     0
    Add To Cart
    Open Cart Page      
    Update Cart 
    Submit Order
    Fill Shipping Information      Hoang Nguyen      0123456789      nghoan@gmail.com      ${EMPTY}      Gửi hàng trong giờ hành chính
    Select Payment Method      cod
    Submit Order
    Verify Required Field Message     Please fill out this field.

order Auto Test 4
    [Documentation]    Auto generated from AI flow
    Open Home Page
    Select Product From Result     2
    Add To Cart
    Open Cart Page      
    Update Cart 
    Submit Order
    Fill Shipping Information      Hoang Nguyen      012345678999      nghoan@gmail.com      123 Main St, Hanoi      Gửi hàng trong giờ hành chính
    Select Payment Method      cod
    Submit Order
    Verify Element Text Contains      ${ORDER_ERROR_MSG}     Vui lòng nhập ít nhất một số điện thoại bạn đang sử dụng

order Auto Test 5
    [Documentation]    Auto generated from AI flow
    Open Home Page
    Select Product From Result     1
    Add To Cart
    Open Cart Page      
    Update Cart 
    Submit Order
    Fill Shipping Information      Hoang Nguyen      01234      nghoan@gmail.com     123 Main St, Hanoi      Gửi hàng trong giờ hành chính
    Select Payment Method      cod
    Submit Order
    Verify Element Text Contains      ${ORDER_ERROR_MSG}     Vui lòng nhập ít nhất một số điện thoại bạn đang sử dụng

order Auto Test 6
    [Documentation]    Auto generated from AI flow
    Open Home Page
    Select Product From Result     1
    Add To Cart
    Open Cart Page      
    Update Cart 
    Submit Order
    Fill Shipping Information      Hoang Nguyen      0123456789      nghoan@gmail.com     123      Gửi hàng trong giờ hành chính
    Select Payment Method      cod
    Submit Order
    Verify Element Text Contains      ${ORDER_ERROR_MSG}     Vui lòng nhập chính xác!



