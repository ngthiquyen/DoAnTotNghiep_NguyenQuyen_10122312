*** Settings ***
Resource    ../keywords/business/login_business.robot
Resource    ../keywords/business/search_business.robot
Resource    ../keywords/business/order_business.robot
Resource    ../keywords/business/register_business.robot
Resource    ../keywords/verify/verify.robot

*** Test Cases ***
E2E login_search_order_20260504_141309
    [Documentation]    AI generated E2E

    Login To System
    Verify Element Should Be Visible ${LOGIN_URL}
    Fill Login Form ${email} ${password}
    Submit Login Form
    Verify Current URL Should Be ${URL}
    Search Product ${product}
    Verify Page Contains Text ${product}
    Select Product From Result ${index}
    Verify Element Should Not Be Empty ${elements}[${index}]
    Open Cart Page
    Click On Element ${CART_ICON}
    Add To Cart
    Update Cart
    Reload Current Page
    Fill Shipping Information ${name} ${phone} ${address}
    Submit Order
    Verify Required Field Message required
    Verify Element Text Contains ${error_locator} ${success_locator} success
