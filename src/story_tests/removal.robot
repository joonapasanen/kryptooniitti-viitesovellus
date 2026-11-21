*** Settings ***
Resource    resource.robot
Suite Setup    Open And Configure Browser
Suite Teardown    Close Browser
Test Setup    Reset Todos


*** Test Cases ***
Add Reference, Click Remove, Check Removal
    [Documentation]    This test checks that a book reference
    ...                can be removed.
    Go To        ${HOME_URL}
    Get Text     p    ==    Hello from Kryptoniitti-viitesovellus!
    Click        button >> text="Add new reference"

    Select Options By    select[name="r_type"]    value    book
    Select Options By    select[name="author_count"]    value    1
    Click                button >> text="Choose"

    Fill Text    input[name="cite_key"]    testbook
    Fill Text    input[name="author"]      Tester, Book
    Fill Text    input[name="title"]    Testing Book
    Fill Text    input[name="publisher"]    Test Publisher
    Fill Text    input[name="year"]    2026
    Click        button >> text="Create"

    Get Text     p    ==    Hello from Kryptoniitti-viitesovellus!

    Get Text     body    contains    testbook
    Click        button >> text="Remove reference"
    Click        form:has(input[value*="Testing Book"]) button[type="submit"]

    Get Text     p    ==    Hello from Kryptoniitti-viitesovellus!
    Get Text     body    not contains    testbook

Add Book With Ten Authors And Others, Check Removals
    [Documentation]    This test checks that mutiple book
    ...                references can be removed.
    Go To        ${HOME_URL}
    Get Text     p    ==    Hello from Kryptoniitti-viitesovellus!
    Click        button >> text="Add new reference"

    Select Options By    select[name="r_type"]    value    book
    Select Options By    select[name="author_count"]    value    1
    Click                button >> text="Choose"

    Fill Text    input[name="cite_key"]    testbook
    Fill Text    input[name="author"]      Tester, Book
    Fill Text    input[name="title"]    Testing Book
    Fill Text    input[name="publisher"]    Test Publisher
    Fill Text    input[name="year"]    2026
    Click        button >> text="Create"

    Get Text     p    ==    Hello from Kryptoniitti-viitesovellus!

    Get Text     body    contains    testbook
    Click        button >> text="Add new reference"

    Select Options By    select[name="r_type"]    value    book
    Select Options By    select[name="author_count"]    value    10
    Click                button >> text="Choose"

    Fill Text    input[name="cite_key"]    tenauthorsbook
    Fill Text    input[name="author"] >> nth=0    Author, One
    Fill Text    input[name="author"] >> nth=1    Author, Two
    Fill Text    input[name="author"] >> nth=2    Author, Three
    Fill Text    input[name="author"] >> nth=3    Author, Four
    Fill Text    input[name="author"] >> nth=4    Author, Five
    Fill Text    input[name="author"] >> nth=5    Author, Six
    Fill Text    input[name="author"] >> nth=6    Author, Seven
    Fill Text    input[name="author"] >> nth=7    Author, Eight
    Fill Text    input[name="author"] >> nth=8    Author, Nine
    Fill Text    input[name="author"] >> nth=9    others
    Fill Text    input[name="title"]    Book With Ten Authors
    Fill Text    input[name="publisher"]    Test Publisher
    Fill Text    input[name="year"]    2026
    Click        button >> text="Create"

    Get Text    body    contains    tenauthorsbook
    Get Text    body    contains    others

    Click    button >> text="Remove reference"

    Click       form:has(input[value*="Book With Ten Authors"]) button[type="submit"]
    Get Text    body    not contains    Book With Ten Authors
    Get Text    body    not contains    tenauthorsbook

    Click    button >> text="Remove reference"

    Click        form:has(input[value*="Testing Book"]) button[type="submit"]

    Get Text     p    ==    Hello from Kryptoniitti-viitesovellus!
    Get Text     body    not contains    testbook

Add Article With Five Authors, Check Removal
    [Documentation]    This test checks that an article
    ...                can be removed.
    Go To        ${HOME_URL}
    Get Text     p    ==    Hello from Kryptoniitti-viitesovellus!
    Click        button >> text="Add new reference"

    Select Options By    select[name="r_type"]    value    article
    Select Options By    select[name="author_count"]    value    1
    Click                button >> text="Choose"

    Fill Text    input[name="cite_key"]    testbook
    Fill Text    input[name="author"]      Tester, Book
    Fill Text    input[name="title"]    Testing Book
    Fill Text    input[name="journal"]    Test Publisher
    Fill Text    input[name="year"]    2026
    Click        button >> text="Create"

    Get Text     p    ==    Hello from Kryptoniitti-viitesovellus!
    Get Text     body    contains    testbook

    Click        button >> text="Remove reference"
    Click        form:has(input[value*="Testing Book"]) button[type="submit"]

    Get Text     p    ==    Hello from Kryptoniitti-viitesovellus!
    Get Text     body    not contains    testbook