*** Settings ***
Resource    ..//keywords/base_test.robot
Resource    ../keywords/business/search_business.robot
Resource    ../keywords/ui/common_keywords.robot
Resource    ../keywords/verify/verify.robot

Variables    ../pages/search_page.py

Test Setup     Open Browser Suite    Search Feature
Test Teardown    Run Keywords
...    Run Keyword If Test Failed    Handle Test Failure
...    AND    Close Browser Suite

*** Test Cases ***
search Auto Test 1
    [Documentation]    Auto generated from AI flow
    Open Search Page
    Input Search Keyword      cao gót 7cm
    Submit Search
    Verify Element Text Contains      ${PRODUCTS_NAME}     cao gót 7cm

search Auto Test 2
    [Documentation]    Auto generated from AI flow
    Open Search Page
    Input Search Keyword      ELA301
    Submit Search
    Verify Element Text Contains      ${PRODUCTS_NAME}     ELA301

search Auto Test 3
    [Documentation]    Auto generated from AI flow
    Open Search Page
    Input Search Keyword      Giày sandal công sở ELLA 7cm thanh lịch cuốn hút ELA662
    Submit Search
    Verify Element Text Contains       ${PRODUCTS_NAME}    Giày sandal công sở ELLA 7cm thanh lịch cuốn hút ELA662

search Auto Test 4
    [Documentation]    Auto generated from AI flow
    Open Search Page
    Input Search Keyword      !@#$
    Submit Search
    Verify Page Contains Element      ${PRODUCTS_NAME}     

search Auto Test 5
    [Documentation]    Auto generated from AI flow
    Open Search Page
    Input Search Keyword      ${EMPTY}
    Submit Search
    Verify Required Field Message      Please fill out this field.
