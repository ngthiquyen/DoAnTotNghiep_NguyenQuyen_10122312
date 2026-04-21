*** Settings ***
Resource    ../keywords/business/login_business.robot
Resource    ../keywords/business/search_business.robot
Resource    ../keywords/business/order_business.robot
Resource    ../keywords/business/register_business.robot
Resource    ../keywords/verify/verify.robot

*** Test Cases ***
E2E login_search_register_order
    [Documentation]    AI generated E2E

    Open Login Page
    Fill Login Form    ${email}    ${password}
    Submit Login Form
    Login Result    ${email}    ${password}    ${expected}
    IF    '${email}' == '' or '${password}' == ''
    Verify Required Field Message       ${expected}
    ELSE
    Verify Message Or Page    ${ERROR_MSG}    ${LOGOUT_BTN}    ${expected}
    END
    IF    '${expected}' == 'success'
    Open Search Page
    Input Search Keyword    ${product}
    Submit Search
    Click On Element    ${SEARCH_BTN}
    Search Result    ${product}    ${expected}
    ELSE
    Register Flow    ${email}    ${password}    ${re_password}    ${expected}
    END
    IF    '${expected}' == 'Has_result'
    Select Product From Result      0
    Click On Element    ${ADD_TO_CART_BTN}
    Order Flow    ${name}    ${phone}    ${email}    ${address}    ${note}    ${method}    ${expected}
    ELSE
    Open Cart Page
    Fill Shipping Information    ${name}    ${phone}    ${email}    ${address}    ${note}
    Select Payment Method    ${method}
    Submit Order
    Order Result    ${expected}
    END
    Verify Business Result    ${expected_result}
