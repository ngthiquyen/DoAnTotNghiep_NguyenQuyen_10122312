*** Settings ***
Resource    ../keywords/business/login_business.robot
Resource    ../keywords/business/search_business.robot
Resource    ../keywords/business/order_business.robot
Resource    ../keywords/business/register_business.robot
Resource    ../keywords/verify/verify.robot

*** Test Cases ***
E2E login_search_order_20260510_021556
    [Documentation]    AI generated E2E

    Open Login Page
    Fill Login Form ${email} ${password}
    Submit Login Form
    Verify Element Should Be Visible ${LOGIN_SUCCESS_MSG}
    Search Product ${product}
    Submit Search
    Select Product From Result ${index}
    Add To Cart
    Update Cart
    Open Checkout Page
    Fill Shipping Information ${name} ${phone} ${email} ${address} ${note}
    Select Payment Method ${method}
    Submit Order
    Verify Element Should Be Visible ${ORDER_SUCCESS_MSG}
