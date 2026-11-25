*** Settings ***
Resource          resource.robot
Suite Setup       Open And Configure Browser
Suite Teardown    Close Browser
Test Setup        Reset Database


*** Test Cases ***
Add Reference, Click Remove, Check Removal
    [Documentation]    This test checks that a book reference
    ...                can be removed.
    Create Book Reference    testbook    Testing Book    2026    Tester, Book
    Front Page Should Be Open
    Page Should Contain    testbook

    Remove Reference    Testing Book

    Front Page Should Be Open
    Page Should Not Contain    testbook

Add Book With Ten Authors And Others, Check Removals
    [Documentation]    This test checks that mutiple book
    ...                references can be removed.
    Create Book Reference    testbook    Testing Book    2026    Tester, Book
    Page Should Contain    testbook

    Create Book Reference    tenauthorsbook    Book With Ten Authors    2026
    ...    Author, One    Author, Two    Author, Three    Author, Four    Author, Five
    ...    Author, Six    Author, Seven    Author, Eight    Author, Nine    others
    Page Should Contain    tenauthorsbook
    Page Should Contain    others

    Remove Reference    Book With Ten Authors
    Page Should Not Contain    Book With Ten Authors
    Page Should Not Contain    tenauthorsbook

    Remove Reference    Testing Book
    Front Page Should Be Open
    Page Should Not Contain    testbook

Add Article With Five Authors, Check Removal
    [Documentation]    This test checks that an article
    ...                can be removed.
    Create Article Reference    testbook    Testing Book    2026    Tester, Book
    Front Page Should Be Open
    Page Should Contain    testbook

    Remove Reference    Testing Book

    Front Page Should Be Open
    Page Should Not Contain    testbook
