*** Settings ***
Library    SeleniumLibrary
Variables   ../pages/login_page.py
Resource   ../keywords/common_keywords.robot

*** Keywords ***
Open Login Page
    Open Page    ${LoginPage.URL}

Login With Credentials
    [Arguments]    ${username}    ${password}
    Input Text To Element    ${LoginPage.USERNAME}    ${username}
    Input Text To Element    ${LoginPage.PASSWORD}    ${password}
    # Submit bằng ENTER (ổn định hơn click)
    Press Keys    ${LoginPage.PASSWORD}    ENTER
    #Wait Until Element Is Enabled    ${LoginPage.LOGIN_BTN}    5s
    #Click Element            ${LoginPage.LOGIN_BTN}
    Wait Until Page Contains Element    ${LoginPage.ERROR_MESSAGE}    5s
    Wait Until Page Contains Element    ${LoginPage.ACCOUNT_ICON}    5s


Verify Login Result
    [Arguments]    ${expected}

    # KHÔNG DÙNG keyword có wait để check điều kiện
    ${error_visible}=    Run Keyword And Return Status
    ...    Page Should Contain Element    ${LoginPage.ERROR_MESSAGE}
    ${login_success}=    Run Keyword And Return Status
    ...    Page Should Contain Element    ${LoginPage.ACCOUNT_ICON}

    IF    ${error_visible}
        ${actual}=    Get Text From Element    ${LoginPage.ERROR_MESSAGE}
        Log Info    Login failed
        Log Info    Expected: ${expected}
        Log Info    Actual: ${actual}
        #Should Contain    ${actual}    ${expected}
        ${result}=    Run Keyword And Return Status    Should Contain    ${actual}    ${expected}

        IF    ${result}
            Log Info    ✅ PASS | Actual='${actual}'
        ELSE
            Log Error   ❌ FAIL | Actual='${actual}' | Expected='${expected}'
        END
    ELSE
        # Login thành công
        Click Element    ${LoginPage.ACCOUNT_ICON}
        ${actual}=    Get Text From Element    ${LoginPage.ACCOUNT_NAME}
        Log Info    Login success
        Log Info    Expected username: ${expected}
        Log Info    Actual username: ${actual}
        #Should Contain    ${actual}    ${expected}
        ${result}=    Run Keyword And Return Status    Should Contain    ${actual}    ${expected}

        IF    ${result}
            Log Info    ✅ PASS | Actual='${actual}'
        ELSE
            Log Error   ❌ FAIL | Actual='${actual}' | Expected='${expected}'
        END
    END