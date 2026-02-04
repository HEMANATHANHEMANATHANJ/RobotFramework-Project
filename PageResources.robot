*** Settings ***
Library    SeleniumLibrary
Library    Collections
*** Variables ***
${url}  https://automationexercise.com/
${brw}  chrome
${TOTAL_COUNT}      0
${USERNAME}      TestUser
${EMAIL}         testuser@example.com
${REVIEW_TEXT}   automation testing
*** Keywords ***
open browsers
    Set Suite Variable    ${TOTAL_COUNT}    0
    open browser    ${url}  ${brw}
    maximize browser window
close browser
    close all browsers
inputemail
    [Arguments]    ${email}
    input text    xpath://input[@data-qa='login-email']     ${email}
inputpass
    [Arguments]    ${pass}
    input text    xpath://input[@placeholder='Password']    ${pass}
LoginTC

    click element    xpath://a[normalize-space()='Signup / Login']
    page should contain    Login to your account
LoginButton
    click element    xpath://button[normalize-space()='Login']
LogoutButton
    click element    xpath://a[normalize-space()='Logout']
    wait until element contains    xpath://a[normalize-space()='Logout']   5seconds
SuccessfullLogin
    go to    https://automationexercise.com/
UnsuccesfullLogin
    page should contain    Your email or password is incorrect!
SearchProduct
    go to    https://automationexercise.com/products
    input text    id:search_product    women
    element should be visible    xpath://div[@class='col-sm-9 padding-right']//div[2]//div[1]//div[2]//ul[1]//li[1]//a[1]
CartTC
    click element    xpath://a[normalize-space()='Cart']
    element should be visible    xpath://a[normalize-space()='Proceed To Checkout']
*** Keywords ***
Close Cart Modal
    # If cart modal is visible try to close it, then fallback to JS hide
    ${visible}=    Run Keyword And Return Status    Element Should Be Visible    id:cartModal
    Run Keyword If    ${visible}    Run Keyword And Ignore Error    Click Element    xpath=//div[@id='cartModal']//button[@data-dismiss='modal' or contains(@class,'close')]
    Run Keyword If    ${visible}    Sleep    0.5s
    ${still}=    Run Keyword And Return Status    Element Should Be Visible    id:cartModal
    Run Keyword If    ${still}    Execute JavaScript    document.getElementById('cartModal').classList.remove('show'); document.getElementById('cartModal').style.display='none';

ReviewWriting
    [Arguments]    ${review_text}=automation testing
    Wait Until Element Is Visible    id:review    5s
    Clear Element Text    id:review
    Input Text    id:review    ${review_text}
    Close Cart Modal
    Wait Until Element Is Visible    id:button-review    5s
    # Use JS click to avoid interception if any overlay remains
    Execute JavaScript    document.getElementById('button-review').click();
    Wait Until Page Contains    Thank you for your review    timeout=5s


Reviewname
    [Arguments]    ${name}
    input text    id:name   ${name}
Reviewemail
    [Arguments]    ${email}
    input text    id:email  ${email}
Reviewcmt
    input text    id:review     Text for testing the website
Count Products On Page
    @{products}=    Get WebElements
    ...    xpath=//div[@class='product-image-wrapper']
    ${count}=    Get Length    ${products}
    Set Suite Variable    ${TOTAL_COUNT}    ${count}
Process Each Product
    @{elements}=    Get WebElements    css=a[href*="/product_details/"]
    @{links}=       Create List
    FOR    ${el}    IN    @{elements}
        ${href}=    Get Element Attribute    ${el}    href
        Append To List    ${links}    ${href}
    END
    FOR    ${link}    IN    @{links}
        Go To    ${link}
        Add Product To Cart
        Reviewname    ${USERNAME}
        Reviewemail   ${EMAIL}
        ReviewWriting    ${REVIEW_TEXT}
    END

Add Product To Cart
    Click Element    xpath://button[normalize-space()='Add to cart']
    Wait Until Page Contains    Your product has been added to cart.    timeout=5s
SubscriptionTC
    scroll element into view    xpath://h2[normalize-space()='Subscription']
    input text    id:susbscribe_email   ${EMAIL}
    click element    id:subscribe_button
    wait until page contains    You have been successfully subscribed!    timeout=5s