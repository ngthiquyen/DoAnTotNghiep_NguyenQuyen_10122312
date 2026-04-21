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
    Verify Business Result      "Search Result"
    Select Product From Result
    Verify Business Result      "Product List Is Present"
