*** Settings ***
Resource          resource.robot
Suite Setup       Open And Configure Browser
Suite Teardown    Close Browser
Test Setup        Reset Database


*** Test Cases ***
Create And Modify Reference, Check Reference
    Create Book Reference    book1    First book    2024    Author One    Author Two

    Get Element Count    ul li    ==    1
    Reference Should Be Listed    book1
    Reference Should Be Listed    Author One
    Reference Should Be Listed    Author Two

    Click    xpath=//li[contains(., "book1")]//a
    Fill Text    input[name="author"]    Modified Author
    Click    button[type="submit"]

    Reference Should Be Listed    Modified Author
    Reload
    Reference Should Be Listed    Modified Author
