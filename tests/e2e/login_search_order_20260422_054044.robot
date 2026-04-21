*** Settings ***
Resource    ../keywords/business/login_business.robot
Resource    ../keywords/business/search_business.robot
Resource    ../keywords/business/order_business.robot
Resource    ../keywords/business/register_business.robot
Resource    ../keywords/verify/verify.robot

*** Test Cases ***
E2E login_search_order_20260422_054044
    [Documentation]    AI generated E2E

    Open Login Page
    Fill Login Form ${email} ${password}
    Submit Login Form
    Login Result ${email} ${password} Has_result
    Verify Current URL Should Be ${URL}
    Verify Page Contains Text Login successful
    Open Search Page
    Input Search Keyword ${product}
    Submit Search
    Search Result ${product} Has_result
    Select Product From Result 0
    Click On Element ${ADD_TO_CART_BTN}
    Add To Cart
    Update Cart
    Open Cart Page
    Fill Shipping Information ${name} ${phone} ${address} ${email} ${note}
    Select Payment Method ${method}
    Submit Order
    Order Result Has_result
    Verify Current URL Should Be ${ORDER_SUCCESS_URL}
    Verify Page Contains Text Order successful
