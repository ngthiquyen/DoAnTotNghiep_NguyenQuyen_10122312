***Settings***
Resource   ../keywords/ui/common_keywords.robot
Resource   ../keywords/verify/verify.robot

*** Keywords ***

Open Register Page
    Navigate To Page    ${URL}
    Click On Element    ${REGISTER_URL}

Fill Register Form
    [Arguments]    ${email}    ${password}    ${re_password}
    Input Text To Element    ${EMAIL_INPUT}    ${email}
    Input Text To Element    ${PASSWORD_INPUT}    ${password}
    Input Text To Element    ${RE_PASSWORD_INPUT}    ${re_password}

Submit Register Form
    Click On Element    ${REGISTER_BTN}

Register User
    [Documentation]    Create a new user account.
    # TODO: Implement
    Open Register Page
    Fill Register Form
    Submit Register Form
