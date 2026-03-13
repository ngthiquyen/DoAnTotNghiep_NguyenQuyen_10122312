*** Settings ***
Library    SeleniumLibrary
Library    ../utils/logger.py

*** Keywords ***
Element Should Be Visible
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    10s

Element Should Not Be Visible
    [Arguments]    ${locator}
    Wait Until Element Is Not Visible    ${locator}    10s

Get Text From Element
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    10s
    ${text}=    Get Text    ${locator}
    Return From Keyword    ${text}

Current URL Should Be
    [Arguments]    ${expected_url}
    ${current}=    Get Location
    Should Be Equal    ${current}    ${expected_url}

Verify Page Contains Text
    [Arguments]    ${message}
    Page Should Contain    ${message}



Verify Element Is Visible
    [Documentation]    Verifies an element is visible
    # TODO: Implement

Verify Text Is Present
    [Documentation]    Verifies text is present
    # TODO: Implement

Verify Page Loaded
    [Documentation]    Verifies the page is loaded
    # TODO: Implement

