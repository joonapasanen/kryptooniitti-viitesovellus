*** Settings ***
Resource          resource.robot
Suite Setup       Open And Configure Browser
Suite Teardown    Close Browser
Test Setup        Create Test References


*** Test Cases ***
Filter Page Shows All References Without Filters
    Go To Filter Page
    Get Element Count    ul li    ==    3
    Reference Should Be Listed    book1
    Reference Should Be Listed    book2
    Reference Should Be Listed    article1

Filter By Reference Type
    Go To Filter Page
    Select Options By    select[name="r_type"]    value    article
    Click    button >> text="Filter"
    Get Element Count    ul li    ==    1
    Reference Should Be Listed    article1

Filter By Author With Partial Match
    Go To Filter Page
    Fill Text    input[name="author"]    Doe
    Click    button >> text="Filter"
    Get Element Count    ul li    ==    2
    Reference Should Be Listed    book1
    Reference Should Be Listed    article1

Filter By Title With Partial Match
    Go To Filter Page
    Fill Text    input[name="title"]    Refactor
    Click    button >> text="Filter"
    Get Element Count    ul li    ==    1
    Reference Should Be Listed    book2

Filter By Year
    Go To Filter Page
    Fill Text    input[name="year"]    2009
    Click    button >> text="Filter"
    Get Element Count    ul li    ==    1
    Reference Should Be Listed    book1

Combine Multiple Filters
    Go To Filter Page
    Select Options By    select[name="r_type"]    value    book
    Fill Text    input[name="author"]    Doe
    Click    button >> text="Filter"
    Get Element Count    ul li    ==    1
    Reference Should Be Listed    book1

Filters Stay Filled In After Filtering
    Go To Filter Page
    Select Options By    select[name="r_type"]    value    book
    Fill Text    input[name="author"]    Doe
    Click    button >> text="Filter"
    Get Selected Options    select[name="r_type"]    value    ==    book
    Get Property    form[action="/filter"] input[name="author"]    value    ==    Doe

Show Message When Nothing Matches
    Go To Filter Page
    Fill Text    input[name="author"]    Nobody
    Click    button >> text="Filter"
    Get Text    ul li    ==    No references match the filters.

Clear Filters Shows All References Again
    Go To Filter Page
    Fill Text    input[name="author"]    Smith
    Click    button >> text="Filter"
    Get Element Count    ul li    ==    1
    Click    button >> text="Clear filters"
    Get Element Count    ul li    ==    3
    Get Property    input[name="author"]    value    ==    ${EMPTY}

Back To Front Page From Filter Page
    Go To Filter Page
    Click    button >> text="Back to front page"
    Front Page Should Be Open


*** Keywords ***
Create Test References
    Reset Database
    Create Book Reference       book1       Clean Code        2009    Doe, Jane
    Create Book Reference       book2       Refactoring       1999    Smith, John
    Create Article Reference    article1    Testing Things    2020    Doe, John

Go To Filter Page
    Go To Front Page
    Click    button >> text="Filter references"
