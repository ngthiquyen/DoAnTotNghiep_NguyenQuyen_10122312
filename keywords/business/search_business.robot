***Settings***
Resource   ../keywords/ui/common_keywords.robot
Resource   ../keywords/verify/verify.robot


*** Keywords ***

Open Search Page
    Open Page    ${URL}

Input Search Keyword
    [Arguments]    ${product}
    Click On Element    ${SEARCH_INPUT}
    Input Text To Element    ${SEARCH_INPUT}    ${product}

Submit Search
    Click On Element    ${SEARCH_BTN}

Search Result
    [Arguments]    ${product}    ${expected}

    IF    '${product}' == ''
        Verify Required Field Message    ${expected}

    ELSE IF    '${expected}' == 'Has_result'
        Verify Page Contains Element    ${PRODUCTS_NAME}

    ELSE
        Verify Element Text Contains    ${PRODUCTS_NAME}    ${expected}
    END

Select Product From Result
    [Arguments]     ${index}
    ${elements}=    Get WebElements    ${PRODUCT_ITEMS}
    Should Not Be Empty    ${elements}
    Scroll Element Into View    ${elements}[${index}]
    Click Element              ${elements}[${index}]
    Click On Element    ${elements}[0]

Search Flow
    [Arguments]    ${product}    ${expected}

    Open Search Page
    Input Search Keyword    ${product}
    Submit Search
    Search Result    ${product}    ${expected}
    
Search Product
    [Documentation]    Perform search for a product
    # TODO: Implement
