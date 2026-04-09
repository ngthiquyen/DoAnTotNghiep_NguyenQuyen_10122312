*** Settings ***
Resource   ../keywords/ui/common_keywords.robot
Resource   ../keywords/verify/verify.robot

*** Keywords ***
Open Login Page
    Open Page    ${URL}
    Click On Element    ${LOGIN_URL}

Fill Login Form
    [Arguments]    ${email}    ${password}
    Input Text To Element    ${EMAIL_INPUT}       ${email}
    Input Text To Element    ${PASSWORD_INPUT}    ${password}

Submit Login Form
    Click On Element    ${LOGIN_BTN}

Login Result
    [Arguments]    ${email}    ${password}    ${expected}

    IF    '${email}' == '' or '${password}' == ''
        Verify Required Field Message       ${expected}

    ELSE
        Verify Message Or Page    ${ERROR_MSG}    ${LOGOUT_BTN}    ${expected}
    END

Login Flow
    [Arguments]    ${email}    ${password}    ${expected}
    Open Login Page
    Fill Login Form    ${email}    ${password}
    Submit Login Form
    Login Result    ${email}    ${password}    ${expected}
    
Login To System
    [Documentation]    Perform login action
    # TODO: Implement

Enter Credentials
    [Documentation]    Enter credentials for login
    # TODO: Implement
