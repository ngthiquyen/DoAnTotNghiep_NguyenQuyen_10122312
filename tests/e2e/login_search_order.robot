*** Settings ***
Resource    ../keywords/business/login_business.robot
Resource    ../keywords/business/search_business.robot
Resource    ../keywords/business/order_business.robot
Resource    ../keywords/business/register_business.robot
Resource    ../keywords/verify/verify.robot

*** Test Cases ***
E2E login_search_order
    [Documentation]    AI generated E2E

    Here is the end-to-end test using only available keywords:
    Open Login Page",
    Fill Login Form ${email} ${password}",
    Submit Login Form",
    Login Result ${email} ${password} ${expected}",
    Verify Required Field Message ${expected}",
    Verify Message Or Page ${ERROR_MSG} ${LOGOUT_BTN} ${expected}",
    Open Search Page",
    Input Search Keyword ${product}",
    Submit Search",
    Search Result ${product} ${expected}",
    Verify Required Field Message ${expected}",
    Verify Element Text Contains ${PRODUCTS_NAME} ${expected}",
    Select Product From Result 0",
    Open Cart Page",
    Select Payment Method ${method}",
    Submit Order",
    Order Result ${expected}",
    Verify Business Result ${expected_result}",
    Verify Current URL Should Be ${expected_url}",
    Verify Page Contains Text ${message}",
    Verify Element Should Be Visible ${locator}",
    Verify Element Should Not Be Visible ${locator}",
    Verify Product List Is Present
