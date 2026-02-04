*** Settings ***
Library    SeleniumLibrary
Library    Collections

*** Variables ***
${URL}           https://automationexercise.com/products
${USERNAME}      TestUser
${EMAIL}         testuser@example.com
${REVIEW_TEXT}   automation testing

*** Keywords ***
Write Reviews For All Products
    @{elements}=    Get WebElements    css=a[href*="/product_details/"]
    @{links}=       Create List
    FOR    ${el}    IN    @{elements}
        ${href}=    Get Element Attribute    ${el}    href
        Append To List    ${links}    ${href}
    END
    FOR    ${link}    IN    @{links}
        Go To    ${link}
        Reviewname    ${USERNAME}
        Reviewemail   ${EMAIL}
        ReviewWriting    ${REVIEW_TEXT}
        Sleep    0.5s
    END

Reviewname
    [Arguments]    ${username}
    Wait Until Element Is Visible    id:name    5s
    Clear Element Text    id:name
    Input Text    id:name    ${username}

Reviewemail
    [Arguments]    ${email}
    Wait Until Element Is Visible    id:email    5s
    Clear Element Text    id:email
    Input Text    id:email    ${email}

ReviewWriting
    [Arguments]    ${review_text}=automation testing
    Wait Until Element Is Visible    id:review    5s
    Clear Element Text    id:review
    Input Text    id:review    ${review_text}
    Click Element    id:button-review
    Wait Until Page Contains    Thank you for your review    timeout=5s
