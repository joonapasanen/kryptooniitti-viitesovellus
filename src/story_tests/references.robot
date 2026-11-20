*** Settings ***
Resource          resource.robot
Suite Setup       Open And Configure Browser
Suite Teardown    Close Browser
Test Setup        Reset Todos


*** Test Cases ***
Check Headline, Add Two References, Check References
    Go To    ${HOME_URL}
    Get Text    p    ==    Hello from Kryptoniitti-viitesovellus!

    Click    button >> text="Add new reference"

    Select Options By    select[name="r_type"]    value    book
    Select Options By    select[name="author_count"]    value    2
    Click    button >> text="Choose"

    Fill Text    input[name="cite_key"]    book1
    Fill Text    input[name="author"] >> nth=0    Author One
    Fill Text    input[name="author"] >> nth=1    Author Two
    Fill Text    input[name="title"]    First book
    Fill Text    input[name="publisher"]    Example Publisher
    Fill Text    input[name="year"]    2024
    Click    button >> text="Create"

    Click    button >> text="Add new reference"
    Select Options By    select[name="r_type"]    value    article
    Select Options By    select[name="author_count"]    value    1
    Click    button >> text="Choose"

    Fill Text    input[name="cite_key"]    article1
    Fill Text    input[name="author"]    Article Author
    Fill Text    input[name="title"]    First article
    Fill Text    input[name="journal"]    Example Journal
    Fill Text    input[name="year"]    2025
    Click    button >> text="Create"

    Get Element Count    ul li    ==    2
    Get Element States    ul li:has-text("book1")    contains    visible
    Get Element States    ul li:has-text("Author One")    contains    visible
    Get Element States    ul li:has-text("Author Two")    contains    visible
    Get Element States    ul li:has-text("article1")    contains    visible
    Get Element States    ul li:has-text("Article Author")    contains    visible
