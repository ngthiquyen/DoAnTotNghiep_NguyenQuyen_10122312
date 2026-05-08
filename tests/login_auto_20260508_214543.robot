*** Settings ***
Resource    ../keywords/business/login_business.robot
Resource    ../keywords/ui/common_keywords.robot
Resource    ../keywords/verify/verify.robot

*** Test Cases ***
login Auto Test
    [Documentation]    Auto generated from AI flow

    Login To System      ${username}
    Fill Login Form
    Verify Current URL Should Be      "login"
    Submit Login Form
    Verify Element Text Contains      "Welcome, ${username}"
    Verify Page Contains Element      "dashboard"
