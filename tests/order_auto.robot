*** Settings ***
Resource    ../keywords/business/order_business.robot
Resource    ../keywords/ui/common_keywords.robot
Resource    ../keywords/verify/verify.robot

*** Test Cases ***
order Auto Test
    [Documentation]    Auto generated from AI flow

    Open Cart Page      ${cartPageUrl}
    Update Cart      ${productIds}
    Submit Order
    Fill Shipping Information      ${shippingInfo}
    Select Payment Method      ${paymentMethod}
    Submit Order
    Verify Current URL Should Be      ${orderConfirmationUrl}
