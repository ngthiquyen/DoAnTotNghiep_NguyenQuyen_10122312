*** Settings ***
Resource    ../keywords/business/order_business.robot
Resource    ../keywords/ui/common_keywords.robot
Resource    ../keywords/verify/verify.robot

*** Test Cases ***
order Auto Test
    [Documentation]    Auto generated from AI flow

    Open Cart Page      ${data}
    Add To Cart      ${product}
    Update Cart
    Open Checkout Page
    Fill Shipping Information      ${shipping_info}
    Select Payment Method      ${payment_method}
    Submit Order
    Verify Order Result      "Order placed successfully"
    Verify Business Result      "Order flow completed"
