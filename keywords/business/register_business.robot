***Settings***
Resource   ../keywords/ui/common_keywords.robot
Resource   ../keywords/verify/verify.robot
Variables   ../pages/register_page.py

*** Keywords ***

Fill Register Form
    [Documentation]    Fill in the registration form with provided email, password, and re-entered password
    # TODO: Implement
    [Arguments]    ${email}    ${password}    ${re_password}
    Input Text To Element    ${EMAIL_INPUT}    ${email}
    Input Text To Element    ${PASSWORD_INPUT}    ${password}
    Input Text To Element    ${RE_PASSWORD_INPUT}    ${re_password}
    
Register User
    [Documentation]    Create a new user account.
    # TODO: Implement
    [Arguments]    ${email}    ${password}    ${re_password}
    Open Page    ${URL}
    Click On Element    ${REGISTER_URL}
    Fill Register Form    ${email}    ${password}    ${re_password}
    Click On Element    ${REGISTER_BTN}
