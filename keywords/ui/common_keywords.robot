*** Settings ***
Library    ../utils/logger.py
Library    ../utils/allure_helper.py

*** Keywords ***

Open Page
    [Documentation]    Open a web page with the specified URL.
    [Arguments]    ${url}
    Log Info    [STEP]  Opening page: ${url}
    Step log   Opening page: ${url}
    Go To    ${url}
    Wait Until Page Contains Element    //body    10s

Reload Current Page
    [Documentation]    Reload the current page.
    Log Info    [STEP] Reload current page 
    Step log   Reload current page
    Press Keys    None    F5

Input Text To Element
    [Documentation]    Input text into a specified element.
    [Arguments]    ${locator}    ${text}
    Log Info    [STEP]  Input text "${text}" to element ${locator}
    Step log   Input text "${text}" to element ${locator}
    Wait Until Element Visible Custom    ${locator}    10s
    Clear Element Text    ${locator}
    Input Text    ${locator}    ${text}

Click On Element
    [Documentation]    Click on a specified element.
    [Arguments]    ${locator}
    Log Info    [STEP]  Click element ${locator}
    Step log   Click element ${locator}
    Wait Until Element Visible Custom    ${locator}    10s
    Click Element    ${locator}

Press Key On Element
    [Documentation]    Press a key on a specified element.
    [Arguments]    ${locator}    ${key}
    Log Info    [STEP]  Press key ${key} on element ${locator}
    Step log   Press key ${key} on element ${locator}
    Wait Until Element Visible Custom    ${locator}    10s
    Press Keys    ${locator}    ${key}

Select Dropdown By Value
    [Documentation]    Select an option from a dropdown by its value.
    [Arguments]    ${locator}    ${value}
    Log Info    [STEP]    Select dropdown ${locator} by value ${value}
    Step log   Select dropdown ${locator} by value ${value}
    Wait Until Element Visible Custom    ${locator}    10s
    Select From List By Value    ${locator}    ${value}
    
Wait Until Element Visible Custom
    [Documentation]    Wait until the specified element is visible on the page.
    [Arguments]    ${locator}    ${timeout}=10s
    Log Info    [STEP]  Wait until element ${locator} is visible with timeout ${timeout}
    Step log   Wait until element ${locator} is visible with timeout ${timeout}
    Wait Until Element Is Visible    ${locator}    ${timeout}

Close Alert
    [Documentation]    Close any alert
    # TODO: Implement

Reload Until Element Visible
    [Arguments]    ${locator}

    FOR    ${i}    IN RANGE    5
        Step log   Reload attempt ${i}
        Reload Page
        Sleep    2s

        ${ok}=    Run Keyword And Return Status
        ...    Element Should Be Visible    ${locator}

        IF    ${ok}
            Log Info    [STEP] Element found after reload
            Step log   Element found after reload
            BREAK
        END
    END