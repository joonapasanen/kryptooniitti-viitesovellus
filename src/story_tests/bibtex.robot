*** Settings ***
Resource          resource.robot
Library           OperatingSystem
Suite Setup       Open And Configure Browser
Suite Teardown    Close Browser
Test Setup        Reset Todos


*** Test Cases ***
Download BibTeX File From Front Page
    Go To    ${HOME_URL}
    Click    button >> text="Add new reference"
    Select Options By    select[name="r_type"]    value    book
    Select Options By    select[name="author_count"]    value    1
    Click    button >> text="Choose"
    Fill Text    input[name="cite_key"]    book1
    Fill Text    input[name="author"]    Doe, Jane
    Fill Text    input[name="title"]    Clean Code
    Fill Text    input[name="publisher"]    Example Publisher
    Fill Text    input[name="year"]    2009
    Click    button >> text="Create"

    ${download}=    Promise To Wait For Download    ${OUTPUT DIR}${/}references.bib
    Click    button >> text="Download BibTeX"
    ${file}=    Wait For    ${download}
    ${bibtex}=    Get File    ${file.saveAs}

    Should Contain    ${bibtex}    @book{book1,
    Should Contain    ${bibtex}    title = {Clean Code},

Download Filtered BibTeX File From Filter Page
    Create Book Reference    book1    Doe, Jane    Clean Code    2009
    Create Book Reference    book2    Smith, John    Refactoring    1999

    Go To    ${HOME_URL}/filter
    Fill Text    input[name="author"]    Doe
    Click    button >> text="Filter"

    ${download}=    Promise To Wait For Download    ${OUTPUT DIR}${/}filtered.bib
    Click    button >> text="Download BibTeX"
    ${file}=    Wait For    ${download}
    ${bibtex}=    Get File    ${file.saveAs}

    Should Contain    ${bibtex}    @book{book1,
    Should Not Contain    ${bibtex}    @book{book2,

Download Empty BibTeX File Without References
    Go To    ${HOME_URL}
    ${download}=    Promise To Wait For Download    ${OUTPUT DIR}${/}empty.bib
    Click    button >> text="Download BibTeX"
    ${file}=    Wait For    ${download}
    ${bibtex}=    Get File    ${file.saveAs}

    Should Be Empty    ${bibtex}


*** Keywords ***
Create Book Reference
    [Arguments]    ${cite_key}    ${author}    ${title}    ${year}
    Go To    ${HOME_URL}
    Click    button >> text="Add new reference"
    Select Options By    select[name="r_type"]    value    book
    Select Options By    select[name="author_count"]    value    1
    Click    button >> text="Choose"
    Fill Text    input[name="cite_key"]    ${cite_key}
    Fill Text    input[name="author"]    ${author}
    Fill Text    input[name="title"]    ${title}
    Fill Text    input[name="publisher"]    Example Publisher
    Fill Text    input[name="year"]    ${year}
    Click    button >> text="Create"
