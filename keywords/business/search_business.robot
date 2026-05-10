***Settings***
Resource   ../keywords/ui/common_keywords.robot
Resource   ../keywords/verify/verify.robot


*** Keywords ***

Select Product From Result
    [Documentation]    Select a product from the search results based on the given index
    # TODO: Implement
    [Arguments]     ${index}
    ${elements}=    Get WebElements    ${PRODUCT_ITEMS}
    Should Not Be Empty    ${elements}
    Scroll Element Into View    ${elements}[${index}]
    Click On Element              ${elements}[${index}]

Search Product
    [Documentation]    Perform search for a product with given name.
    # TODO: Implement
    [Arguments]    ${product}
    Open Page    ${URL}
    Click On Element    ${SEARCH_INPUT}
    Input Text To Element    ${SEARCH_INPUT}    ${product}
    Click On Element    ${SEARCH_BTN}
