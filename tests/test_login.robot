*** Settings ***
Resource    ../keywords/base_test.robot
Resource    ../keywords/login_keywords.robot
Library    ../utils/data_reader.py

Suite Setup     Open Browser Suite    Login
Suite Teardown  Close Browser Suite
Test Teardown   Handle Test Failure

*** Variables ***
${DATA_FILE}    ${CURDIR}/../data/login_data.csv

*** Test Cases ***
Login With Data Driven
    ${data}=    Load Test Data    ${DATA_FILE}
    FOR    ${row}    IN    @{data}
        ${msg}=    Set Variable    Running login with user ${row['username']}
        Log Info    ${msg}
        Open Login Page
        Login With Credentials    ${row['username']}    ${row['password']}
        Verify Login Result      ${row['expected']}
        ${msg}=    Set Variable    Finished case for user ${row['username']}
        Log Info    ${msg}
    END


