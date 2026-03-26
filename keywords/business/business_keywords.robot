*** Settings ***
Resource   ../ui/common_keywords.robot
Resource   ../verify/verify.robot
Library     String

*** Keywords ***

#Dùng cho: login, register, cart, profile, admin…
Navigate To Page
    [Arguments]    ${url}
    Open Page    ${url}
    
#Dùng cho: login, change password, checkout
Input User Credentials
    [Arguments]    ${username_locator}    ${password_locator}    ${username}    ${password}
    Input Text To Element    ${username_locator}    ${username}
    Input Text To Element    ${password_locator}    ${password}

#Dùng cho: register, update profile, checkout
Input User Personal Information
    [Arguments]    ${fullname_locator}    ${email_locator}    ${value_fullname}    ${value_email}
    Input Text To Element    ${fullname_locator}    ${value_fullname}
    Input Text To Element    ${email_locator}    ${value_email}

#Dùng cho mọi form
Input Form Information
    [Arguments]    @{fields}
    FOR    ${field}    IN    @{fields}
        Input Text To Element    ${field}[0]    ${field}[1]
    END

#Dùng cho: login, register, search, checkout, profile update
Submit Form
    [Arguments]    ${submit_button_locator}
    Click On Element    ${submit_button_locator}

Confirm Action
    [Arguments]    ${confirm_button_locator}
    Click On Element    ${confirm_button_locator}

