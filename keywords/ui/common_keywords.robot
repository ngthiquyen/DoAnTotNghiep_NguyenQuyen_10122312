*** Settings ***
Library    ../utils/logger.py

*** Keywords ***

Open Page
    [Arguments]    ${url}
    Log Info    [STEP]  Opening page: ${url}
    Go To    ${url}
    Wait Until Page Contains Element    //body    10s

Reload Current Page
    Log Info    [STEP]  Reload current page
    Reload Page

Input Text To Element
    [Arguments]    ${locator}    ${text}
    Log Info    [STEP]  Input text "${text}" to element ${locator}
    Wait Until Element Is Visible    ${locator}    10s
    Clear Element Text    ${locator}
    Input Text    ${locator}    ${text}

Click On Element
    [Arguments]    ${locator}
    Log Info    [STEP]  Click element ${locator}
    Wait Until Element Is Visible    ${locator}    10s
    Click Element    ${locator}

Press Key On Element
    [Arguments]    ${locator}    ${key}
    Log Info    [STEP]  Press key ${key} on element ${locator}
    Wait Until Element Is Visible    ${locator}    10s
    Press Keys    ${locator}    ${key}

Select Dropdown By Value
    [Arguments]    ${locator}    ${value}
    Log Info    [STEP]    Select dropdown ${locator} by value ${value}
    Wait Until Element Is Visible    ${locator}    10s
    Select From List By Value    ${locator}    ${value}
    


Wait Until Search Results Are Available
    [Documentation]    Wait until search results are available
    # TODO: Implement

Fill Out Required Fields
    [Documentation]    Enter required information for registration.
    # TODO: Implement

Add To Cart Button
    [Documentation]    Add product to cart
    # TODO: Implement

View Cart Link
    [Documentation]    Display cart contents
    # TODO: Implement
