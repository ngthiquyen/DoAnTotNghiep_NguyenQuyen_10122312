*** Settings ***
Resource   ../keywords/ui/common_keywords.robot
Resource   ../keywords/verify/verify.robot

*** Keywords ***
Open Login Page
    [Documentation]    Navigate to the login page
    # TODO: Implement
    Open Page    ${URL}
    Click On Element    ${LOGIN_URL}

Fill Login Form
    [Documentation]    Fill in the login form with provided email and password
    # TODO: Implement
    [Arguments]    ${email}    ${password}
    Input Text To Element    ${EMAIL_INPUT}       ${email}
    Input Text To Element    ${PASSWORD_INPUT}    ${password}

Submit Login Form
    [Documentation]    Submit the login form
    # TODO: Implement
    Click On Element    ${LOGIN_BTN}
    Wait Until Page Contains Element    //body    10s
    #Reload Current Page

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

