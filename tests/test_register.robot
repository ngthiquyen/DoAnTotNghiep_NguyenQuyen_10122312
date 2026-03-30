*** Settings ***
Resource    ../keywords/base_test.robot
Resource   ../keywords/business/register_business.robot
Library    DataDriver    ../data/data_test.xlsx      sheet_name=Register

Variables    ../pages/locators_page.py
Suite Setup     Open Browser Suite    Register Feature
Suite Teardown  Close Browser Suite
Test Teardown    Run Keyword If Test Failed    Handle Test Failure

Test Template    Execute Register Test

*** Test Cases ***
Register Test with ${email} and ${password} and ${re_password} expecting ${expected}

*** Keywords ***
Execute Register Test
    [Arguments]        ${email}    ${password}    ${re_password}    ${expected}
    Register Flow    ${email}    ${password}    ${re_password}    ${expected}