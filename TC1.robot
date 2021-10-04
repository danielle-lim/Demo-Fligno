*** Settings ***
Library     SeleniumLibrary
Library     FakerLibrary

*** Variables ***
${browser}  chrome
${url}  https://opensource-demo.orangehrmlive.com/

*** Test Cases ***
Scenario: User Login
    Given user is on the login page
    When user enters credentials
    And user clicks the login button
    Then user is login successfully

Scenario: Create New User
    Given user is logged in the web app
    When user navigates admin page
    And user clicks the add button
    And user fills in the input fields
    And user clicks the save button
    Then new user saved successfully

Scenario: Read Data
    Given user is logged in the web app
    When user navigates admin page
    And user fills username field
    And user selects user role
    And user clicks the search button
    Then searched user is displayed

Scenario: Edit Data
    Given user is logged in the web app
    When user navigates admin page
    And user clicks the username link to edit
    And user clicks the edit button
    And user selects role
    And user fills the employee name field
    And user fills the username field
    And user selects status
    And click option to change password
    And user fills new password and confirm password field
    And user clicks the save button for the edited file
    Then edited information is displayed

Scenario: Delete Data
    Given user is logged in the web app
    When user navigates admin page
    And user selects the checkboxes of the user information to delete
    And user clicks the delete button
    And user confirms the deletion
    Then user successfully deleted


*** Keywords ***
user is on the login page
    open browser        ${url}  ${browser}
    maximize browser window

user enters credentials
    input text  id:txtUsername      Admin
    input text  id:txtPassword      admin123

user clicks the login button
    click element   xpath://*[@id="btnLogin"]

user is login successfully
    page should contain     Dashboard

user is logged in the web app
    user is on the login page
    user enters credentials
    user clicks the login button
    user is login successfully

user navigates admin page
    click link      xpath://*[@id="menu_admin_viewAdminModule"]

user clicks the add button
    click Element       id:btnAdd

user fills in the input fields
    ${username}             FakerLibrary.Username
    select from list by label       systemUser_userType     Admin
    input text      id:systemUser_employeeName_empName      David Morris
    input text      id:systemUser_userName      ${username}
    select from list by label       systemUser_status       Enabled
    input text      systemUser_password     password123
    input text      systemUser_confirmPassword      password123

user clicks the save button
    click button            class:addbutton
    set selenium speed          1second

new user saved successfully
    Wait Until Page Contains Element        xpath://*[@id="frmList_ohrmListComponent"]/div[2]

user fills username field
    input text      id:searchSystemUser_userName        David.Morris

user selects user role
    select from list by label   searchSystemUser_userType   All

user clicks the search button
    click button        id:searchBtn

searched user is displayed
    page should contain         David Morris

user clicks the username link to edit
    click element       xpath://*[@id="resultTable"]/tbody/tr[2]/td[2]/a

user clicks the edit button
    click button        id:btnSave

user selects role
    select from list by label       systemUser_userType     Admin

user fills the employee name field
    input text      systemUser_employeeName_empName     David Morris

user fills the username field
    ${username}         FakerLibrary.Username
    input text      systemUser_userName         ${username}

user selects status
    select from list by label       systemUser_status       Enabled

click option to change password
    select checkbox         systemUser_chkChangePassword

user fills new password and confirm password field
    input text      systemUser_password         password12
    input text      systemUser_confirmPassword      password12

user clicks the save button for the edited file
    click button        class:addbutton
    set selenium speed          1second

edited information is displayed
    page should contain element         xpath://*[@id="frmList_ohrmListComponent"]/div[2]

user selects the checkboxes of the user information to delete
    select checkbox             xpath://*[@id="ohrmList_chkSelectRecord_41"]
    select checkbox             xpath://*[@id="ohrmList_chkSelectRecord_54"]

user clicks the delete button
    click button            id:btnDelete

user confirms the deletion
    click button            id:dialogDeleteBtn
    set selenium speed          1second

user successfully deleted
    page should contain element         xpath://*[@id="frmList_ohrmListComponent"]/div[2]










