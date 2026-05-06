***Settings***
Resource   ../keywords/ui/common_keywords.robot
Resource   ../keywords/verify/verify.robot

*** Keywords ***

Open Register Page
    [Documentation]    Navigate to the registration page
    # TODO: Implement
    Navigate To Page    ${URL}
    Click On Element    ${REGISTER_URL}

Fill Register Form
    [Documentation]    Fill in the registration form with provided email, password, and re-entered password
    # TODO: Implement
    [Arguments]    ${email}    ${password}    ${re_password}
    Input Text To Element    ${EMAIL_INPUT}    ${email}
    Input Text To Element    ${PASSWORD_INPUT}    ${password}
    Input Text To Element    ${RE_PASSWORD_INPUT}    ${re_password}

Submit Register Form
    [Documentation]    Submit the registration form
    # TODO: Implement
    Click On Element    ${REGISTER_BTN}

Register User
    [Documentation]    Create a new user account.
    # TODO: Implement
    Open Register Page
    Fill Register Form
    Submit Register Form
