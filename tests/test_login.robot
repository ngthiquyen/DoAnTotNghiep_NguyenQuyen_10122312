*** Settings ***
Resource    ../keywords/base_test.robot
Resource   ../keywords/business/login_business.robot
Library    DataDriver    ../data/data_test.xlsx      sheet_name=Login

Variables    ../pages/locators_page.py
Suite Setup     Open Browser Suite    Login Feature
Suite Teardown  Close Browser Suite
Test Teardown    Run Keyword If Test Failed    Handle Test Failure

Test Template    Execute Login Test

*** Test Cases ***
Login Test with ${email} and ${password} expecting ${expected}

*** Keywords ***
Execute Login Test
    [Arguments]        ${email}    ${password}    ${expected}
    Login Flow    ${email}    ${password}    ${expected}

