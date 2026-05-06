*** Settings ***
Library    ../utils/logger.py
Library    ../utils/allure_helper.py

*** Keywords ***

#Xác minh phần tử hiển thị
Verify Element Should Be Visible
    [Documentation]    Verify that the element is visible on the page.
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    10s
    Step log   Element located by: ${locator} is visible on the page.
    Log Info    [STEP]    Element located by: ${locator} is visible on the page.

#Xác minh phần tử không hiển thị (có thể tồn tại trong DOM nhưng ẩn)
Verify Element Should Not Be Visible
    [Documentation]    Verify that the element is not visible on the page (it may exist in the DOM but is hidden).
    [Arguments]    ${locator}
    Wait Until Element Is Not Visible    ${locator}    10s
    Step log   Element located by: ${locator} is not visible on the page.
    Log Info    [STEP]    Element located by: ${locator} is not visible on the page.

#Xác minh URL hiện tại
Verify Current URL Should Be
    [Documentation]    Verify that the current URL matches the expected URL.
    [Arguments]    ${expected_url}
    ${current}=    Get Location
    Should Be Equal    ${current}    ${expected_url}
    Log Info    [STEP]    Current URL: ${current}
    Step log   Current URL: ${current}

#Xác minh trang chứa văn bản
Verify Page Contains Text
    [Documentation]    Verify that the page contains the specified text.
    [Arguments]    ${message}
    Wait Until Page Contains   ${message}    10s
    Log Info    [STEP]    Page contains text: ${message}
    Step log   Page contains text: ${message}
    Log Info    =====================================

#Xác minh trang chứa phần tử
Verify Page Contains Element
    [Documentation]    Verify that the page contains the specified element.
    [Arguments]    ${locator}
    Wait Until Page Contains Element    ${locator}    10s
    Log Info    [STEP]    Element located by: ${locator} is present on the page.
    Step log   Element located by: ${locator} is present on the page.
    Log Info  =====================================

#Xác minh thông báo trường bắt buộc (validation message)
Verify Required Field Message
    [Documentation]    Verify the validation message for required fields or invalid input.
    [Arguments]        ${expected}
    ${message}=    Execute Javascript
    ...    var el = document.activeElement;
    ...    if (el) {
    ...        el.reportValidity();
    ...        return el.validationMessage;
    ...    }
    ...    return "";

    Log Info    [STEP]    Actual validation message: ${message}
    Log Info    [STEP]    Expected validation message: ${expected}
    IF    '${expected}' == 'required' or '${expected}' == 'invalid'
        Should Not Be Empty    ${message}
    ELSE
        Should Contain    ${message}    ${expected}
    END    
    Step log   Validation message verified.
    Log Info    =====================================

#Xác minh thông báo(có thể là message hoặc text trên page)
Verify Element Text Contains
    [Documentation]    Verify that the text of the element located by the given locator contains the expected text.
    [Arguments]       ${locator}     ${expected}
        Wait Until Element Is Visible    ${locator}    10s
        Wait Until Element Contains    
        ...    ${locator}    
        ...    ${expected}    
        ...    10s
        ${text}=    Get Text    ${locator}

        Log Info    [STEP] Text: ${text}
        Log Info    [STEP]    Expected: ${expected}
        Should Contain    ${text}    ${expected}
        Step log   Element text verified.
        Log Info    =====================================

Verify Element Is Present
    [Documentation]    Verify that element is present on the page.
    # TODO: Implement
    [Arguments]    ${locator}
    Wait Until Page Contains Element    ${locator}    10s
    Log Info    [STEP]    Element located by: ${locator} is present on the page.
    Step log   Element located by: ${locator} is present on the page.
    
