*** Settings ***
Resource   ../keywords/base_test.robot
Resource   ../keywords/business/order_business.robot
Library    DataDriver    ../data/data_test.xlsx      sheet_name=Order

Variables    ../pages/locators_page.py
Suite Setup     Open Browser Suite    Order Feature
Suite Teardown  Close Browser Suite
Test Teardown    Run Keyword If Test Failed    Handle Test Failure

Test Template    Execute Order Test

*** Test Cases ***
Place Order Test with ${name} and ${phone} and ${email} and ${address} and ${note} and ${method} expecting ${expected}

*** Keywords ***
Execute Order Test
    [Arguments]    ${product}    ${name}    ${phone}    ${email}    ${address}    ${note}    ${method}    ${expected}
    Place Order From Search    ${product}    ${name}    ${phone}    ${email}    ${address}    ${note}    ${method}    ${expected}  