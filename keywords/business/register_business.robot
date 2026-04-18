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

Register Result
    [Arguments]    ${email}    ${password}    ${re_password}    ${expected}

    IF    '${email}' == '' or '${password}' == '' or '${re_password}' == ''
        Verify Required Field Message    ${expected}

    ELSE IF    '${expected}' == 'invalid'
        Verify Required Field Message    ${expected}

    ELSE
        Verify Message Or Page    ${ERROR_MSG_REGISTER}    ${ACCOUNT_NAME}    ${expected}
    END


Register Flow
    [Arguments]    ${email}    ${password}    ${re_password}    ${expected}
    Open Register Page
    Fill Register Form    ${email}    ${password}    ${re_password}
    Submit Register Form
    Register Result    ${email}    ${password}    ${re_password}    ${expected}
Register User
    [Documentation]    Create a new user account.
    # TODO: Implement

Fill Out Registration Form
    [Documentation]    Enter required information for registration.
    # TODO: Implement
