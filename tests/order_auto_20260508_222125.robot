*** Settings ***
Resource    ../keywords/business/order_business.robot
Resource    ../keywords/ui/common_keywords.robot
Resource    ../keywords/verify/verify.robot

*** Test Cases ***
order Auto Test
    [Documentation]    Auto generated from AI flow

    Open Cart Page      ${data}
    Update Cart
    Verify Element Should Be Visible      "Shopping cart contents"
    Select Payment Method
    Fill Shipping Information      ${data}
    Submit Order
    Verify Current URL Should Be      "${expected}/order-success"
