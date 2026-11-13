*** Settings ***
Resource          resource.robot
Suite Setup       Open And Configure Browser
Suite Teardown    Close Browser
Test Setup        Reset Todos


*** Test Cases ***
#Check Headline, Add Two References, Check References
    #Go To    ${HOME_URL}
    #Get Text    p    ==    Hello from Kryptoniitti-viitesovellus
    #Click       button >> text="Add new book"
    #Fill Text    input[name="content"]    Test1
    #Click       button >> text="Create"
    #Click       button >> text="Add new book"
    #Fill Text    input[name="content"]    Test2
    #Click       button >> text="Create"
    #Get Element Count    ul li    ==    2
    #Get Element States    ul li:has-text("Test1")    contains    visible
    #Get Element States    ul li:has-text("Test2")    contains    visible


Check Error Visibility For Reference Min Length
    Go To    ${HOME_URL}
    Get Text    p    ==    Hello from Kryptoniitti-viitesovellus
    Click       button >> text="Add new book"
    Fill Text    input[name="content"]    Te1
    Click       button >> text="Create"
    Get Element States    ul li:has-text("Reference content length must be greater than 4")    contains    visible
