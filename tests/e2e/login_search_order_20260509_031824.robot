*** Settings ***
Resource    ../keywords/business/login_business.robot
Resource    ../keywords/business/search_business.robot
Resource    ../keywords/business/order_business.robot
Resource    ../keywords/business/register_business.robot
Resource    ../keywords/verify/verify.robot

*** Test Cases ***
E2E login_search_order_20260509_031824
    [Documentation]    AI generated E2E

    Open Login Page
    Fill Login Form ${email} ${password}
    Submit Login Form
    Verify Current URL Should Be ${URL}
    Logout User
    Login To System
    Open Search Page
    Input Search Keyword ${product}
    Submit Search
    Select Product From Result ${index}
    Add To Cart
    Open Cart Page
    Open Checkout Page
    Fill Shipping Information ${name} ${phone} ${address}
    Select Payment Method ${method}
    Submit Order
    Verify Current URL Should Be ${URL}
