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
    Open Page    ${URL}

    # ===== STEP 2 + STEP 3 =====
    Log   [STEP] Input search query

    IF    '${product}' != ''
        Input Text To Element    ${SEARCH_INPUT}    ${product}
        Submit Form   ${SEARCH_BTN}
        Log   [STEP] Submit search form

    ELSE
        Log   [STEP] Submit empty search    
        Submit Form   ${SEARCH_BTN}
    END

    # ===== STEP 4 =====
    Log   [STEP] Verify search results
    IF     '${product}' == '' 
        Verify Required Field Message    ${SEARCH_INPUT}    ${expected}

    ELSE IF    '${expected}' == 'Has_result'
        Verify Page Contains Element    ${PRODUCTS_NAME}

    ELSE
        Verify Element Text Contains    ${PRODUCTS_NAME}    ${expected}
    END