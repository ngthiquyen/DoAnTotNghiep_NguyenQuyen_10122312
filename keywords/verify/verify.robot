*** Settings ***
Library    SeleniumLibrary
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

#Xác minh phần tử không hiển thị (có thể tồn tại trong DOM nhưng ẩn)
Element Should Not Be Visible
    [Arguments]    ${locator}
    Wait Until Element Is Not Visible    ${locator}    10s

#Xác minh URL hiện tại
Current URL Should Be
    [Arguments]    ${expected_url}
    ${current}=    Get Location
    Should Be Equal    ${current}    ${expected_url}

#Xác minh trang chứa văn bản
Verify Page Contains Text
    [Arguments]    ${message}
    Page Should Contain    ${message}

#Xác minh trang chứa phần tử
Verify Page Contains Element
    [Arguments]    ${locator}
    Page Should Contain Element    ${locator}

#Xác minh văn bản phần tử có chứa một chuỗi con
Verify Element Text Contains
    [Arguments]    ${locator}    ${expected_text}
    ${actual_text}=    Get Text From Element    ${locator}
    Should Not Be Empty    ${actual_text}
    Log     [STEP]    Actual text: ${actual_text}
    Log     [STEP]    Expected text: ${expected_text}
    Should Contain    ${actual_text}    ${expected_text}

#Xác minh thông báo trường bắt buộc (validation message)
Verify Required Field Message
    [Arguments]    ${locator}    ${expected}

    ${message}=    Execute Javascript
    ...    var el = document.evaluate("${locator}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
    ...    return el ? el.validationMessage : "";

    Log     [STEP]    Actual validation message: ${message}
    Log     [STEP]    Expected validation message: ${expected}
    Log    ${message}    

    Should Contain    ${message}    ${expected}

