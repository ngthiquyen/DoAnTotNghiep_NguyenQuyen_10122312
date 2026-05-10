*** Settings ***
Resource   ../keywords/ui/common_keywords.robot
Resource   ../keywords/verify/verify.robot

*** Keywords ***

Logout User
    [Documentation]    Perform logout action
    # TODO: Implement
    Click On Element    ${LOGOUT_BTN}

Login To System
    [Documentation]    Perform login action
    # TODO: Implement
    [Arguments]    ${email}    ${password}
    Open Page    ${URL}
    Click On Element    ${LOGIN_URL}
    Input Text To Element    ${EMAIL_INPUT}       ${email}
    Input Text To Element    ${PASSWORD_INPUT}    ${password}
    Click On Element    ${LOGIN_BTN}
    Sleep   2s

