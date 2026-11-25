*** Settings ***
Resource          resource.robot
Suite Setup       Open And Configure Browser
Suite Teardown    Close Browser
Test Setup        Reset Database


*** Test Cases ***
Download BibTeX File From Front Page
    Create Book Reference    book1    Clean Code    2009    Doe, Jane

    Go To Front Page
    ${bibtex}=    Download BibTeX

    Should Contain    ${bibtex}    @book{book1,
    Should Contain    ${bibtex}    title = {Clean Code},

Download Filtered BibTeX File From Filter Page
    Create Book Reference    book1    Clean Code     2009    Doe, Jane
    Create Book Reference    book2    Refactoring    1999    Smith, John

    Go To    ${HOME_URL}/filter
    Fill Text    input[name="author"]    Doe
    Click    button >> text="Filter"
    ${bibtex}=    Download BibTeX    filtered.bib

    Should Contain        ${bibtex}    @book{book1,
    Should Not Contain    ${bibtex}    @book{book2,

Download Empty BibTeX File Without References
    Go To Front Page
    ${bibtex}=    Download BibTeX    empty.bib

    Should Be Empty    ${bibtex}
