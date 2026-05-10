*** Settings ***
Resource   ../keywords/ui/common_keywords.robot
Resource   ../keywords/verify/verify.robot
Resource   ../keywords/business/search_business.robot

*** Keywords ***

Add To Cart
    [Documentation]    Add product to cart
    # TODO: Implement
    [Arguments]    ${index}
    Open Page    ${URL}
    Select Product From Result    ${index}
    Wait Until Element Is Visible    ${ADD_TO_CART_BTN}    timeout=10s
    Scroll Element Into View    ${ADD_TO_CART_BTN}

    Wait Until Keyword Succeeds
    ...    10s
    ...    1s
    ...    Click On Element
    ...    ${ADD_TO_CART_BTN}

    Sleep    2s

Place Order
    [Documentation]    Start checkout process
    # TODO: Implement
    [Arguments]    ${name}    ${phone}    ${email}    ${address}    ${note}    
    Open Page   ${CART_ICON}
    Input Text To Element    ${NAME_INPUT}      ${name}
    Input Text To Element    ${PHONE_INPUT}     ${phone}
    Input Text To Element    ${EMAIL_INPUT_ORDER}   ${email}
    Input Text To Element    ${ADDRESS_INPUT}     ${address}
    Input Text To Element    ${NOTE_INPUT}   ${note}
    Click On Element    ${SUBMIT_ORDER}
    

