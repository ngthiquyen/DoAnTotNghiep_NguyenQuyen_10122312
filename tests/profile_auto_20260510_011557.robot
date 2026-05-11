*** Settings ***
Resource    ../keywords/business/profile_business.robot
Resource    ../keywords/ui/common_keywords.robot
Resource    ../keywords/verify/verify.robot

*** Test Cases ***
profile Auto Test 1
    [Documentation]    Auto generated from AI flow
    Update Profile      Hoang Nguyen      0123456789      123 Main St, Hanoi
    Verify Element Text Contains      ${SUCCESS_MSG}     Cập nhật thông tin tài khoản thành công!
    Verify Page Contains Text      Cập nhật thông tin tài khoản thành công!

profile Auto Test 2
    [Documentation]    Auto generated from AI flow
    Update Profile      ${EMPTY}      0123456789      123 Main St, Hanoi
    Verify Required Field Message      Please fill out this field.

profile Auto Test 3
    [Documentation]    Auto generated from AI flow
    Update Profile      Hoang Nguyen      ${EMPTY}      123 Main St, Hanoi
    Verify Required Field Message      Please fill out this field.

profile Auto Test 4
    [Documentation]    Auto generated from AI flow
    Update Profile      Hoang Nguyen      0123456789      ${EMPTY}
    Verify Required Field Message      Please fill out this field.

profile Auto Test 5
    [Documentation]    Auto generated from AI flow
    Update Profile      Hoang Nguyen      01234      123 Main St, Hanoi
    Verify Element Text Contains     ${ERROR_MSG}     Vui lòng nhập ít nhất một số điện thoại bạn đang sử dụng

profile Auto Test 6
    [Documentation]    Auto generated from AI flow
    Update Profile      Hoang Nguyen      012345678999      123 Main St, Hanoi
    Verify Element Text Contains     ${ERROR_MSG}     Vui lòng nhập ít nhất một số điện thoại bạn đang sử dụng