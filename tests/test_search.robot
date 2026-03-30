*** Settings ***
Resource   ../keywords/base_test.robot
Resource   ../keywords/business/search_business.robot
Library   DataDriver    ../data/data_test.xlsx    sheet_name=Search

Variables  ../pages/locators_page.py
Suite Setup     Open Browser Suite    Search Feature
Suite Teardown  Close Browser Suite
Test Teardown    Run Keyword If Test Failed    Handle Test Failure

Test Template    Execute Search Test

*** Test Cases ***      
Search Test with ${product} and ${expected}
    
*** Keywords ***
Execute Search Test
    [Arguments]    ${product}   ${expected}
    Search Flow    ${product}   ${expected}

