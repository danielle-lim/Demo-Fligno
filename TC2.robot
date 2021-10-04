*** Settings ***
Library     SeleniumLibrary
Library     FakerLibrary

*** Variables ***
${browser}  chrome
${EMPTY}
${url}  https://opensource-demo.orangehrmlive.com/

*** Test Cases ***
Scenario: User Login - User enters the wrong credentials
    Given user is on the login page
    When user did not fill the correct credentials
    And user clicks the login button
    Then a message "invalid credentials" will appear

Scenario: Create New User - User enters the wrong employee credentials
    Given user is on the login page
    When user enters credentials
    And user clicks the login button
    And user is login successfully
    And user navigates admin page
    And user clicks the add button
    And user filled the wrong employee name credential
    Then "Employee does not exist" message will appear

Scenario: Create New User - One empty field
    Given user is logged in the web app
    When user missed to fill one required field
    And user clicks the save button
    Then "Required" texts will appear

Scenario: Create New User - Did not meet the password requirements
    Given user is logged in the web app
    When user provided a very weak password
    Then "Should have at least 8 characters" message will appear

Scenario: Create New User - Passwords do not match
    Given user is logged in the web app
    When user did not confirm the password correctly
    Then "Passwords do not match" message will appear

Scenario: Search User - Username is not on the list
    Given another user is logged in the web app
    When put the incorrect username details
    And user clicks the search button
    Then "No Records Found" message will appear on the table list

*** Keywords ***
user is on the login page
    open browser        ${url}  ${browser}
    maximize browser window

user did not fill the correct credentials
    ${password}             FakerLibrary.Password
    input text  id:txtUsername      Admin
    input text  id:txtPassword      ${password}

user clicks the login button
    click element   xpath://*[@id="btnLogin"]

a message "invalid credentials" will appear
    page should contain element             id:spanMessage

user enters credentials
    input text  id:txtUsername      Admin
    input text  id:txtPassword      admin123

user is login successfully
    page should contain     Dashboard

user navigates admin page
    click link      xpath://*[@id="menu_admin_viewAdminModule"]

user clicks the add button
    click Element       id:btnAdd

user filled the wrong employee name credential
    ${username}             FakerLibrary.Username
    ${name}                 FakerLibrary.Name
    select from list by label       systemUser_userType     Admin
    input text      id:systemUser_employeeName_empName      ${name}
    input text      id:systemUser_userName      ${username}
    select from list by label       systemUser_status       Enabled
    input text      systemUser_password     password123
    input text      systemUser_confirmPassword      password123

"Employee does not exist" message will appear
    page should contain element         class:validation-error

user is logged in the web app
    user is on the login page
    user enters credentials
    user clicks the login button
    user is login successfully
    user navigates admin page
    user clicks the add button

user missed to fill one required field
    select from list by label       systemUser_userType     Admin
    input text      id:systemUser_employeeName_empName      David Morris
    input text      id:systemUser_userName      ${EMPTY}
    select from list by label       systemUser_status       Enabled
    input text      systemUser_password     password123
    input text      systemUser_confirmPassword      password123

user clicks the save button
    click button            class:addbutton
    set selenium speed          1second

"Required" texts will appear
    page should contain element         class:validation-error


user provided a very weak password
    ${username}             FakerLibrary.Username
    select from list by label       systemUser_userType     Admin
    input text      id:systemUser_employeeName_empName      David Morris
    input text      id:systemUser_userName      ${username}
    select from list by label       systemUser_status       Enabled
    input text      systemUser_password     pass

"Should have at least 8 characters" message will appear
    page should contain element         class:validation-error

user did not confirm the password correctly
    ${username}             FakerLibrary.Username
    ${password}             FakerLibrary.Password
    select from list by label       systemUser_userType     Admin
    input text      id:systemUser_employeeName_empName      David Morris
    input text      id:systemUser_userName      ${username}
    select from list by label       systemUser_status       Enabled
    input text      systemUser_password     password123
    input text      systemUser_confirmPassword      ${password}

"Passwords do not match" message will appear
    page should contain element         class:validation-error

another user is logged in the web app
    user is on the login page
    user enters credentials
    user clicks the login button
    user is login successfully
    user navigates admin page

put the incorrect username details
    ${username}             FakerLibrary.Username
    input text          id:searchSystemUser_userName          ${username}

user clicks the search button
    click button            id:searchBtn

"No Records Found" message will appear on the table list
    page should contain element             xpath://*[@id="resultTable"]/tbody/tr/td
