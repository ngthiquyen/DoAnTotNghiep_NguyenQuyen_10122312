*** Settings ***
Resource   ../keywords/base_test.robot
Resource   ../keywords/ui/common_keywords.robot
Resource   ../keywords/verify/verify.robot
Resource   ../keywords/business/business_keywords.robot
Library   DataDriver    ../data/data1.xlsx    sheet_name=Search


Variables  ../pages/locators_page.py

Suite Setup     Open Browser Suite    Search Feature
Suite Teardown  Close Browser Suite
Test Teardown    Run Keyword If Test Failed    Handle Test Failure

Test Template    Search Test

*** Test Cases ***      
Search Test with ${product} and ${expected}
    
*** Keywords ***
Search Test
    [Arguments]    ${product}   ${expected}
    Navigate To Page    ${URL}
    Click On Element    ${SEARCH_INPUT}
    Input Text To Element    ${SEARCH_INPUT}    ${product}
    Click On Element    ${SEARCH_BTN}
    
    IF     '${product}' == '' 
        Verify Required Field Message       ${expected}

    ELSE IF    '${expected}' == 'Has_result'
        Verify Page Contains Element    ${PRODUCTS_NAME}

    ELSE
        Verify Element Text Contains    ${PRODUCTS_NAME}    ${expected}
    END

