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

Select Product From Result
    [Arguments]     ${index}
    ${elements}=    Get WebElements    ${PRODUCT_ITEMS}
    Should Not Be Empty    ${elements}
    Scroll Element Into View    ${elements}[${index}]
    Click Element              ${elements}[${index}]
    Click On Element    ${elements}[0]


Search Product
    [Documentation]    Perform search for a product with given name.
    # TODO: Implement
    Open Search Page
    Input Search Keyword
    Submit Search
