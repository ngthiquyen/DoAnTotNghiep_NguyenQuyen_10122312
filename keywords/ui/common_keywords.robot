*** Settings ***
Library    SeleniumLibrary
Library    ../utils/logger.py

*** Keywords ***
Open Page
    [Arguments]    ${url}
    Go To    ${url}

Input Text To Element
    [Arguments]    ${locator}    ${text}
    Wait Until Element Is Visible    ${locator}    10s
    Clear Element Text    ${locator}
    Input Text    ${locator}    ${text}

Click Element
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    10s
    Click Element    ${locator}

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

