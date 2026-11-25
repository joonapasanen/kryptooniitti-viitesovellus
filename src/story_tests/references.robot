*** Settings ***
Resource          resource.robot
Suite Setup       Open And Configure Browser
Suite Teardown    Close Browser
Test Setup        Reset Database


*** Test Cases ***
Check Headline, Add Two References, Check References
    Go To Front Page
    Front Page Should Be Open

    Create Book Reference       book1       First book       2024    Author One    Author Two
    Create Article Reference    article1    First article    2025    Article Author

    Get Element Count    ul li    ==    2
    Reference Should Be Listed    book1
    Reference Should Be Listed    Author One
    Reference Should Be Listed    Author Two
    Reference Should Be Listed    article1
    Reference Should Be Listed    Article Author
