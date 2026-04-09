*** Settings ***
Resource    ../keywords/business/login_business.robot
Resource    ../keywords/ui/common_keywords.robot
Resource    ../keywords/verify/verify.robot

*** Test Cases ***
login Auto Test
    [Documentation]    Auto generated from AI flow

    **Open Login Page**
    **Fill Login Form** | ${username}
    **Submit Login Form**
    **Verify Business Result** | "Login successful"
    **Verify Current URL Should Be** | "${expected_url}"
    **Verify Page Contains Text** | "Welcome, ${username}"
