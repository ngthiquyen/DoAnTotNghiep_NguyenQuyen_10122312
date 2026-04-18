*** Settings ***
Resource    ../keywords/business/order_business.robot
Resource    ../keywords/ui/common_keywords.robot
Resource    ../keywords/verify/verify.robot

*** Test Cases ***
order Auto Test
    [Documentation]    Auto generated from AI flow

    Open Cart Page | ${data}
    Place Order
    Verify Current URL Should Be | "cart"
    Verify Page Contains Text | "Your cart is empty."
    Add To Cart Button
    View Cart Link
    Fill Shipping Information | ${data}
    Select Payment Method
    Submit Order
    Order Result
    Verify Business Result | "Order placed successfully."
