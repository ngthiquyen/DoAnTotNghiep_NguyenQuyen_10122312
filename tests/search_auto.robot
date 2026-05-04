*** Settings ***
Resource    ../keywords/business/search_business.robot
Resource    ../keywords/ui/common_keywords.robot
Resource    ../keywords/verify/verify.robot

*** Test Cases ***
search Auto Test
    [Documentation]    Auto generated from AI flow

    Open Search Page
    Input Search Keyword      ${searchKeyword}
    Submit Search
    Verify Current URL Should Be      "search-results"
    Verify Page Contains Element      "product-list"
