***Settings***
Resource   ../keywords/ui/common_keywords.robot
Resource   ../keywords/verify/verify.robot


*** Keywords ***

Open Search Page
    [Documentation]    Navigate to the search page
    # TODO: Implement
    Open Page    ${URL}

Input Search Keyword
    [Documentation]    Input the search keyword into the search field
    # TODO: Implement
    [Arguments]    ${product}
    Click On Element    ${SEARCH_INPUT}
    Input Text To Element    ${SEARCH_INPUT}    ${product}

Submit Search
    [Documentation]    Submit the search form
    # TODO: Implement
    Click On Element    ${SEARCH_BTN}

Select Product From Result
    [Documentation]    Select a product from the search results based on the given index
    # TODO: Implement
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
