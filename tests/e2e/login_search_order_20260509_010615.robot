*** Settings ***
Resource    ../keywords/business/login_business.robot
Resource    ../keywords/business/search_business.robot
Resource    ../keywords/business/order_business.robot
Resource    ../keywords/business/register_business.robot
Resource    ../keywords/verify/verify.robot

*** Test Cases ***
E2E login_search_order_20260509_010615
    [Documentation]    AI generated E2E

    Verify Element Should Be Visible ${LOGIN_URL}
    Open Login Page
    Fill Login Form ${email} ${password}
    Submit Login Form
    Logout User
    Login To System
    Open Search Page
    Input Search Keyword ${product}
    Submit Search
    Select Product From Result ${index}
    Search Product
    Open Cart Page
    Open Checkout Page
    Fill Shipping Information ${name} ${phone} ${address}
    Select Payment Method ${method}
    Submit Order
    Add To Cart
    Update Cart
    Reload Current Page
