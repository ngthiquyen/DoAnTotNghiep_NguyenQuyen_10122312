*** Settings ***
Resource   ../keywords/ui/common_keywords.robot
Resource   ../keywords/verify/verify.robot
Resource   ../keywords/business/search_business.robot

*** Keywords ***
Open Cart Page
    [Documentation]    Navigate to the cart page
    # TODO: Implement
    Click On Element    ${CART_ICON}

Open Checkout Page
    [Documentation]    Navigate to the checkout page
    # TODO: Implement
    Click On Element    ${CHECKOUT_BTN}

Fill Shipping Information
    [Documentation]    Fill in the shipping information form
    # TODO: Implement
    [Arguments]    ${name}    ${phone}    ${address}

    Input Text To Element    ${NAME_INPUT}      ${name}
    Input Text To Element    ${PHONE_INPUT}     ${phone}
    Input Text To Element    ${EMAIL_INPUT_ORDER}   ${email}
    Input Text To Element    ${ADDRESS_INPUT}     ${address}
    Input Text To Element    ${NOTE_INPUT}   ${note}

Select Payment Method
    [Documentation]    Select a payment method
    # TODO: Implement
    [Arguments]    ${method}
    ${locator}=    Replace String    ${PAYMENT_METHOD}    {}    ${method}
    Click On Element    ${locator}

Submit Order
    [Documentation]    Submit the order
    # TODO: Implement
    Click On Element    ${SUBMIT_ORDER}

Add To Cart
    [Documentation]    Add product to cart
    # TODO: Implement
    Click On Element    ${ADD_TO_CART_BTN}

Update Cart
    [Documentation]    Update cart contents
    # TODO: Implement
    Reload Current Page

