*** Settings ***
Resource   ../keywords/ui/common_keywords.robot
Resource   ../keywords/verify/verify.robot

Variables    ../pages/profile_page.py
Variables    ../pages/home_page.py

*** Keywords ***

Update Profile
    [Documentation]    Update user's personal information.
    # TODO: Implement
    [Arguments]    ${name}    ${phone}    ${address}
    Click On Element         ${ACCOUNT_PAGE}
    Input Text To Element    ${NAME_INPUT}        ${name}
    Input Text To Element    ${PHONE_INPUT}         ${phone}
    Input Text To Element    ${ADDRESS_INPUT}       ${address}
    Click On Element         ${SAVE_BTN}

