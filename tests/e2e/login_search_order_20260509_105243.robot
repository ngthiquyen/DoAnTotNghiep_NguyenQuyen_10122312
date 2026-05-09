*** Settings ***
Resource    ../keywords/business/login_business.robot
Resource    ../keywords/business/search_business.robot
Resource    ../keywords/business/order_business.robot
Resource    ../keywords/business/register_business.robot
Resource    ../keywords/verify/verify.robot

*** Test Cases ***
E2E login_search_order_20260509_105243
    [Documentation]    AI generated E2E

    Open Login Page
    Fill Login Form ${email} ${password}
    Submit Login Form
    Verify Element Should Be Visible //body
    Search Product
    Input Search Keyword ${product}
    Submit Search
    Select Product From Result ${index}
    Add To Cart
    Update Cart
    Open Cart Page
    Open Checkout Page
    Fill Shipping Information ${name} ${phone} ${address}
    Select Payment Method ${method}
    Submit Order
    Verify Element Should Be Visible //body
