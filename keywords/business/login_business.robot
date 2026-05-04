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

Logout User
    [Documentation]    Perform logout action
    # TODO: Implement
    Click On Element    ${LOGOUT_BTN}

Login To System
    [Documentation]    Perform login action
    # TODO: Implement
    Open Login Page
    Fill Login Form
    Submit Login Form
    
