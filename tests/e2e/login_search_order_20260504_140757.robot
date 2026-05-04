*** Settings ***
Resource    ../keywords/business/login_business.robot
Resource    ../keywords/business/search_business.robot
Resource    ../keywords/business/order_business.robot
Resource    ../keywords/business/register_business.robot
Resource    ../keywords/verify/verify.robot

*** Test Cases ***
E2E login_search_order_20260504_140757
    [Documentation]    AI generated E2E

    Login To System
    Verify Element Should Be Visible ${LOGIN_URL}
    Search Product
    Verify Page Contains Text ${product}
    Add To Cart
    Update Cart
    Submit Order
    Verify Current URL Should Be ${expected_url}
    Verify Required Field Message required
