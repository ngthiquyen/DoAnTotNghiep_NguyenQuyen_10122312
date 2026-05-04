*** Settings ***
Resource    ../keywords/business/register_business.robot
Resource    ../keywords/ui/common_keywords.robot
Resource    ../keywords/verify/verify.robot

*** Test Cases ***
register Auto Test
    [Documentation]    Auto generated from AI flow

    Open Register Page
    Fill Register Form
    Verify Element Should Be Visible      "Register Form"
    Submit Register Form
    Verify Current URL Should Be      "/register-success"
    Verify Page Contains Text      "Account created successfully"
