*** Settings ***
Resource    ../keywords/business/register_business.robot
Resource    ../keywords/ui/common_keywords.robot
Resource    ../keywords/verify/verify.robot

*** Test Cases ***
register Auto Test
    [Documentation]    Auto generated from AI flow

    **Open Register Page** | ${url}
    **Fill Out Registration Form**
    **Submit Register Form**
    **Verify Business Result** | "Register Result" contains "Register User"
    **Verify Current URL Should Be** | "${url}/register-success"
