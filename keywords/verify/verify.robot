*** Settings ***
Library    ../utils/logger.py
Library   allure_robotframework

*** Keywords ***

#Dùng cho mọi case, không phụ thuộc thành công hay thất bại
Verify Business Result
    [Arguments]    ${expected_result}
    Verify Page Contains Text    ${expected_result}

#Xác minh phần tử hiển thị
Element Should Be Visible
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    10s
    Log Info    [STEP]    Element located by: ${locator} is visible on the page.

#Xác minh phần tử không hiển thị (có thể tồn tại trong DOM nhưng ẩn)
Element Should Not Be Visible
    [Arguments]    ${locator}
    Wait Until Element Is Not Visible    ${locator}    10s
    Log Info    [STEP]    Element located by: ${locator} is not visible on the page.

#Xác minh URL hiện tại
Current URL Should Be
    [Arguments]    ${expected_url}
    ${current}=    Get Location
    Should Be Equal    ${current}    ${expected_url}
    Log Info    [STEP]    Current URL: ${current}

#Xác minh trang chứa văn bản
Verify Page Contains Text
    [Arguments]    ${message}
    Wait Until Page Contains   ${message}    10s
    Log Info    [STEP]    Page contains text: ${message}
    Log Info    =====================================

#Xác minh trang chứa phần tử
Verify Page Contains Element
    [Arguments]    ${locator}
    Wait Until Page Contains Element    ${locator}    10s
    Log Info    [STEP]    Element located by: ${locator} is present on the page.
    Log Info  =====================================

#Xác minh văn bản phần tử có chứa một chuỗi con
Verify Element Text Contains
    [Arguments]    ${locator}    ${expected_text}
    Wait Until Element Is Visible    ${locator}    10s
    Wait Until Element Contains    ${locator}    ${expected_text}    10s
    ${actual_text}=    Get Text    ${locator}
    Should Not Be Empty    ${actual_text}
    Log Info    [STEP]    Actual text: ${actual_text}
    Log Info    [STEP]    Expected text: ${expected_text}
    Log Info     =====================================
    Should Contain    ${actual_text}    ${expected_text}

#Xác minh thông báo trường bắt buộc (validation message)
Verify Required Field Message
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
    IF    '${expected}' == 'required'
        Should Not Be Empty    ${message}
    ELSE
        Should Contain    ${message}    ${expected}
    END    
    Log Info    =====================================
    

