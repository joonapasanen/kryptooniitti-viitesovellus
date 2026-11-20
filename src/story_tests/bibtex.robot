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

Download Empty BibTeX File Without References
    Go To    ${HOME_URL}
    ${download}=    Promise To Wait For Download    ${OUTPUT DIR}${/}empty.bib
    Click    button >> text="Download BibTeX"
    ${file}=    Wait For    ${download}
    ${bibtex}=    Get File    ${file.saveAs}

    Should Be Empty    ${bibtex}
