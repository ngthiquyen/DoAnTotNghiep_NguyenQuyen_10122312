*** Settings ***
Resource    ../keywords/base_test.robot
Resource   ../keywords/business/business_keywords.robot
Resource   ../keywords/ui/common_keywords.robot
Resource   ../keywords/verify/verify.robot

Library    allure_robotframework
Variables    ../pages/search_page.py
Library     String 

Suite Setup     Open Browser Suite    Search Feature
Suite Teardown  Close Browser Suite
Test Teardown    Run Keyword If Test Failed    Handle Test Failure
#Test Template    Execute Search Test

*** Test Cases ***
Placeholder
    No Operation

*** Keywords ***
Execute Search Test
    [Arguments]       ${product}    ${expected}
    Log    product=${product} | expected=${expected}

    ${product}=    Strip String    ${product}

    #========= Allure ==================
    #Set Test Documentation    ${TC}
    Set Test Documentation    Search with query: ${product}

    Log    ===== START TEST =====
    Log    Search Query: ${product}
    Log    Expected: ${expected}

    # ===== STEP 1 =====
    Log    [STEP] Navigate to search page
    #Allure Step    Navigate to search page
    Navigate To Page    ${URL}

    # ===== STEP 2 =====
    Log   [STEP] Input search query
    Run Keyword If    '${product}' != ''    Input Text To Element    ${SEARCH_INPUT}    ${product}

    # ===== STEP 3 =====
    Log   [STEP] Submit search form
    Submit Form   ${SEARCH_BTN}

    # ===== STEP 4 =====
    Log   [STEP] Verify search results
    IF    '${product}' == '' or '${product}' == 'None'
        Verify Required Field Message    ${SEARCH_INPUT}    ${expected}

    ELSE IF    '${expected}' == 'Has_result'
        Verify Page Contains Element    ${PRODUCT_NAME}

    ELSE
        Verify Element Text Contains    ${PRODUCT_NAME}    ${expected}
    END
    

    