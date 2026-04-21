*** Settings ***
Resource    ../keywords/business/register_business.robot
Resource    ../keywords/ui/common_keywords.robot
Resource    ../keywords/verify/verify.robot

*** Test Cases ***
register Auto Test
    [Documentation]    Auto generated from AI flow

    Open Register Page      ${data}
    Fill Register Form
    Verify Element Should Be Visible      ${expected} (Registration form is visible)
    Submit Register Form
    Verify Business Result      ${expected} (Registration successful)
