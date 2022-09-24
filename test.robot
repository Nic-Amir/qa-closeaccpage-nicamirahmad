*** Settings ***
Library   SeleniumLibrary


*** Variables ***
${nic_email}  nicamirahmad@gmail.com
${nic_pw}    Abcd1234

${long_placeholder}    Lorem Ipsum is simply dummy text of the printing and 
${num100_placeholder}    1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
${num10_placeholder}    1234567890

${email_field}    //input[@type='email']
${pw_field}   //input[@type='password']
${submit_button}   //button[@type='submit']

${sec_link}    //a[contains(string(),'policy')]
${closeacc_button}    //button[span[contains(string(),'Close my account')]]

${cont_button}    //button[span[contains(string(),'Continue')]]
${textfield1}    //textarea[@name='other_trading_platforms']
${textfield2}    //textarea[@name='do_to_improve']

${choice1}    //span[contains(string(),'trading web')]
${choice2}    //span[contains(string(),'user-friend')]
${choice3}    //span[contains(string(),'withdrawals is')]

${popup_window}    //div[span[contains(string(),'Close your account?')]]
${goback_button}    //button[span[contains(string(),'Go Back')]]
${outside_popup}    app_contents
${closeacc_confirm_button}    //button[span[contains(string(),'Close')]]

${startagain_popup}    //div/div[h2[contains(string(),'Want to start trading')]]


*** Keywords ***
Login To Deriv
    Open Browser    https://app.deriv.com/account/closing-account    chrome
    Set Selenium Speed     0.125
    Maximize Browser Window
    Wait Until Page Contains Element   ${email_field}    100
    Input Text   ${email_field}    ${nic_email}
    Input Text    ${pw_field}   ${nic_pw}
    Click Element    //button[@type='submit']


*** Test Cases ***

Login
    Login To Deriv
tc1-verify security and privacy hyperlink clickable
    Wait Until Element Is Visible    ${closeacc_button}
    Click Element    ${sec_link}
tc2-verify if hyperlink open new tabs with pdf
    Sleep    2
    Switch Window    Account Settings | Deriv
    Switch Window    New
    Switch Window    Account Settings | Deriv
tc3-verify 'close my account' redirect to next page
    Click Element    ${closeacc_button}
    Wait Until Page Contains Element    ${cont_button}
tc4-Check 'continue' button is disabled by default
    Page Should Contain Element    //button[span[contains(string(),'Continue')] and @disabled]
tc5a-verify continue button is still disabled with 1 text field is filled
    Press Keys    ${textfield1}    ${long_placeholder}
    Page Should Contain Element    //button[span[contains(string(),'Continue')] and @disabled]
tc5b-verify continue button is still disabled with both text is filled
    Press Keys    ${textfield2}    ${long_placeholder}
    Page Should Contain Element    //button[span[contains(string(),'Continue')] and @disabled]
tc5c-verify user can only type with 110 char in the text field(remaining char = 0)
    Press Keys    ${textfield1}    CTRL+A+DELETE    ${num10_placeholder}
    Press Keys    ${textfield2}    CTRL+A+DELETE    ${num100_placeholder}
    Page Should Contain Element    //div/p[contains(string(),'Remaining characters: 0')]
tc6a-verify continue button enabled with 1 check box checked
    Click Element       ${choice1}
    Page Should Not Contain Element    //button[span[contains(string(),'Continue')] and @disabled]
tc6b-verify continue button enabled with 3 check box checked
    Click Element    ${choice2}
    Click Element    ${choice3}
    Page Should Not Contain Element    //button[span[contains(string(),'Continue')] and @disabled]
tc6c-other checkbox is disabled when 3 check boxes are checked
    Page Should Contain Element    //input[@disabled]/following::span[contains(string(),'financial priorities')]
    Page Should Contain Element    //input[@disabled]/following::span[contains(string(),'stop myself from trading')]
    Page Should Contain Element    //input[@disabled]/following::span[contains(string(),'no longer interested')]
    Page Should Contain Element    //input[@disabled]/following::span[contains(string(),'lack key features')]
    Page Should Contain Element    //input[@disabled]/following::span[contains(string(),'unsatisfactory')]
    Page Should Contain Element    //input[@disabled]/following::span[contains(string(),'other reasons')]
tc7a-verify continue button with valid input popup 'warning:you sure?'
    Click Element    ${cont_button}
    Sleep    1
    Page Should Contain Element    ${popup_window}
tc7b-verify go back button close the popup
    Click Element    ${goback_button}
    Sleep    1
    Page Should Not Contain Element    ${popup_window}
tc8-verify close account clickable, close the account and redirect to sorry to see you leave page 
    Click Element    ${cont_button}
    Sleep    2
    Click Element    ${closeacc_confirm_button}
    Sleep    3 
    Page Should Contain Element    //div/p[contains(string(),'sorry to see you leave')]
tc9-verify logged in with closed account will prompt 'start trading again?' user during login
    Login To Deriv
    Wait Until Page Contains Element    ${startagain_popup}
    Page Should Contain Element    ${startagain_popup}

    

    

















    

    


    