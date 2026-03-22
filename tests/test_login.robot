*** Settings ***
Resource    ../keywords/base_test.robot
Resource   ../keywords/business/business_keywords.robot
Resource   ../keywords/ui/common_keywords.robot
Resource   ../keywords/verify/verify.robot

Library    DataDriver    ../data/data1.xlsx      sheet_name=Login
Library    allure_robotframework
Variables    ../pages/login_page.py

Suite Setup     Open Browser Suite    Login Feature
Suite Teardown  Close Browser Suite
Test Teardown    Run Keyword If Test Failed    Handle Test Failure
Test Template    Execute Login Test

*** Test Cases ***
Login Test

*** Keywords ***
Execute Login Test
    [Arguments]    ${TC}    ${email}    ${password}    ${expected}

    #========= Allure ==================
    Set Test Documentation    ${TC}
    Set Test Documentation    Login with ${email} / ${password}

    Log    ===== START TEST =====
    Log    Email: ${email}
    Log    Password: ${password}
    Log    Expected: ${expected}

    # ===== STEP 1 =====
    Log    [STEP] Navigate to login page
    #Allure Step    Navigate to login page
    Navigate To Page    ${URL}

    # ===== STEP 2 =====
    Log   [STEP] Click login link
    #Allure Step    Click login link
    Click On Element    ${LOGIN_URL}

    # ===== STEP 3 =====
    Log    [STEP] Input credentials
    #Allure Step    Input credentials
    Input User Credentials
    ...    ${EMAIL}
    ...    ${PASSWORD}
    ...    ${email}
    ...    ${password}

    # ===== STEP 4 =====
    Log    [STEP] Submit login form
    #Allure Step    Submit login form
    Submit Form    ${LOGIN_BTN}

    # ===== STEP 5 =====
    Log    [STEP] Verify login result
    #Allure Step    Verify login result

    # ===== 1. CHECK VALIDATION (input trống) =====
    ${email_required}=    Run Keyword And Return Status
    ...    Execute Javascript
    ...    return document.querySelector('[name="t_email"]').validationMessage;

    ${password_required}=    Run Keyword And Return Status
    ...    Execute Javascript
    ...    return document.querySelector('[name="t_matkhau"]').validationMessage;

    IF    '${email}' == '' or '${password}' == ''
        Log     [STEP]    🔴 Validation error (empty field)

        # lấy message thật
        ${msg}=    Execute Javascript
        ...    return document.querySelector('[name="t_email"]').validationMessage || document.querySelector('[name="t_matkhau"]').validationMessage;

        Log    [STEP]    Actual: ${msg}
        Log     [STEP]    Expected: ${expected}

        Should Contain    ${msg}    ${expected}

    # ===== 2. CHECK ALERT =====
    ELSE
        ${alert_present}=    Run Keyword And Return Status
        ...    Alert Should Be Present

        IF    ${alert_present}
            ${alert_text}=    Get Alert Message
            Handle Alert    ACCEPT

            Log     [STEP]    🔴 Login failed (alert)
            Log     [STEP]    Actual: ${alert_text}
            Log     [STEP]    Expected: ${expected}

            Should Contain    ${alert_text}    ${expected}

        # ===== 3. SUCCESS =====
        ELSE
            ${actual}=    Get Text From Element    ${ACCOUNT_NAME}

            Log     [STEP]    🟢 Login success
            Log     [STEP]    Actual: ${actual}
            Log     [STEP]    Expected: ${expected}

            Should Contain    ${actual}    ${expected}
        END
    END

    Log    ===== END TEST =====
    

