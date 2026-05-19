*** Settings ***
Resource    ../keywords/business/profile_business.robot
Resource    ../keywords/ui/common_keywords.robot
Resource    ../keywords/verify/verify.robot

*** Test Cases ***
profile Auto Test
    [Documentation]    Auto generated from AI flow

    Update Profile      ${newName}, ${newEmail}, ${newPhone}
    Update Profile
    Verify Page Contains Text      "Your profile has been updated successfully"
