*** Settings ***
Library    SeleniumLibrary
*** Variables ***
${browser}  chrome
${url1}     https://demo.nopcommerce.com/
${url2}     https://tutorial.techaltum.com/htmlform.html
${url3}
*** Test Cases ***
    LogintoApplication
    Testingradiobutton
    maximize browser window
    close browser
*** Keywords ***
LogintoApplication
    open browser    ${url1}     ${browser}
    click link  xpath://a[normalize-space()='Log in']
    input text    id:Email  hemanathan@gmail.com
    input text    id:Password   Test@1223
    click element    //button[normalize-space()='Log in']
    clear element text    id:Email
    clear element text    id:Password
Testingradiobutton
    open browser    ${url2}     ${browser}
    select checkbox     vehicle
    select checkbox    vehicle
    unselect checkbox    vehicle
