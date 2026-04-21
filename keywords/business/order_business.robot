*** Settings ***
Resource   ../keywords/ui/common_keywords.robot
Resource   ../keywords/verify/verify.robot
Resource   ../keywords/business/search_business.robot

*** Keywords ***
Open Cart Page
    Click On Element    ${CART_ICON}

Open Checkout Page
    Click On Element    ${CHECKOUT_BTN}

Fill Shipping Information
    [Arguments]    ${name}    ${phone}    ${address}

    Input Text To Element    ${NAME_INPUT}      ${name}
    Input Text To Element    ${PHONE_INPUT}     ${phone}
    Input Text To Element    ${EMAIL_INPUT_ORDER}   ${email}
    Input Text To Element    ${ADDRESS_INPUT}     ${address}
    Input Text To Element    ${NOTE_INPUT}   ${note}

Select Payment Method
    [Arguments]    ${method}
    ${locator}=    Replace String    ${PAYMENT_METHOD}    {}    ${method}
    Click On Element    ${locator}

Submit Order
    Click On Element    ${SUBMIT_ORDER}

Order Result
    [Arguments]    ${expected}
    IF '${phone}' == '' or '${address}' == '' 
        Verify Required Field Message       ${expected}
    ELSE    
        Verify Message Or Page    ${ORDER_SUCCESS_MSG}    ${ORDER_ERROR_MSG}    ${expected}
    END

Order Flow
    [Arguments]    ${name}    ${phone}    ${email}    ${address}    ${note}    ${method}    ${expected}
    Open Cart Page
    Fill Shipping Information    ${name}    ${phone}    ${address}    ${email}    ${note}
    Select Payment Method    ${method}
    Submit Order
    Order Result    ${expected}

Place Order From Search
    [Arguments]    ${product}    ${name}    ${phone}    ${email}    ${address}    ${note}    ${method}    ${expected}

    Search Flow    ${product}    Has_result
    Select Product From Result      0
    Click On Element    ${ADD_TO_CART_BTN}

    Order Flow    ${name}    ${phone}    ${email}    ${address}    ${note}    ${method}    ${expected}

Add To Cart
    [Documentation]    Add product to cart
    # TODO: Implement

Update Cart
    [Documentation]    Update cart contents
    # TODO: Implement

