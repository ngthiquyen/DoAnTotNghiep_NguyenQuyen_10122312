*** Settings ***
Library    SeleniumLibrary
Library    ../utils/logger.py

*** Keywords ***

Open Page
    [Arguments]    ${url}
    Log    Opening page: ${url}
    Go To    ${url}
    Wait Until Page Contains Element    //body    10s

Reload Page
    Log    Reload current page
    Reload Page

Input Text To Element
    [Arguments]    ${locator}    ${text}
    Log    Input text "${text}" to element ${locator}
    Wait Until Element Is Visible    ${locator}    10s
    Clear Element Text    ${locator}
    Input Text    ${locator}    ${text}

Click On Element
    [Arguments]    ${locator}
    Log    Click element ${locator}
    Wait Until Element Is Visible    ${locator}    10s
    Click Element    ${locator}

Press Key On Element
    [Arguments]    ${locator}    ${key}
    Log    Press key ${key} on element ${locator}
    Wait Until Element Is Visible    ${locator}    10s
    Press Keys    ${locator}    ${key}

Select Dropdown By Value
    [Arguments]    ${locator}    ${value}
    Log    Select dropdown ${locator} by value ${value}
    Wait Until Element Is Visible    ${locator}    10s
    Select From List By Value    ${locator}    ${value}
    




Wait Until Element Is Visible
    [Documentation]    Wait until an element is visible
    # TODO: Implement

Scroll To Element
    [Documentation]    Scroll to an element
    # TODO: Implement
