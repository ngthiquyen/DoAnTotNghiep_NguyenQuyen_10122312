*** Settings ***
Resource    ../keywords/business/profile_business.robot
Resource    ../keywords/ui/common_keywords.robot
Resource    ../keywords/verify/verify.robot

*** Test Cases ***
profile Auto Test
    [Documentation]    Auto generated from AI flow
    Update Profile      Hoang Nguyen      0123456789      123 Main St, Hanoi
    Verify Element Text Contains      ${SUCCESS_MSG}     Cập nhật thông tin tài khoản thành công!
    Verify Page Contains Text      Cập nhật thông tin tài khoản thành công!