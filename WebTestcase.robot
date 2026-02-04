*** Settings ***
Library    SeleniumLibrary
Library    Collections
Resource    ../Resource/PageResources.robot
Resource    AT2.robot
Library    DataDriver   D:/papers/login.xlsx
Suite Setup    open browsers
Suite Teardown  close browser
Test Template    Loginvalidation
*** Test Cases ***

Loginwithexcel using   ${email}   ${pass}
    Log To Console    TOTAL PRODUCTS COUNT = ${TOTAL_COUNT}
    set selenium speed    0.5seconds
*** Keywords ***
Loginvalidation
    LoginTC
    [Arguments]    ${email}     ${pass}
    inputemail  ${email}
    inputpass    ${pass}
    LoginButton
    SuccessfullLogin
    SearchProduct
    Count Products On Page
    Process Each Product
    go to    https://automationexercise.com/products
    CartTC
