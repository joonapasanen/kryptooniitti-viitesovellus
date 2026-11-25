*** Settings ***
Library    Browser
Library    OperatingSystem


*** Variables ***
${SERVER}         localhost:5001
${DELAY}          500ms
${HOME_URL}       http://${SERVER}
${RESET_URL}      http://${SERVER}/reset_db
${BROWSER}        chromium
${HEADLESS}       false
${FRONT_PAGE_GREETING}    Hello from Kryptoniitti-viitesovellus!


*** Keywords ***
Open And Configure Browser
    IF  $HEADLESS == 'true'
        New Browser  browser=${BROWSER}  headless=True
    ELSE
        New Browser  browser=${BROWSER}  headless=False  slowMo=${DELAY}
    END
    New Context
    New Page  about:blank

Reset Database
    Go To  ${RESET_URL}

Go To Front Page
    Go To    ${HOME_URL}

Front Page Should Be Open
    Get Text    p    ==    ${FRONT_PAGE_GREETING}

Create Reference
    [Documentation]    Creates a reference through the UI. Fills one author
    ...                field per given author and the type-specific venue
    ...                field (publisher for books, journal for articles).
    [Arguments]    ${r_type}    ${cite_key}    ${title}    ${year}    ${venue}    @{authors}
    ${author_count}=    Get Length    ${authors}
    ${author_count}=    Convert To String    ${author_count}
    Go To Front Page
    Click    button >> text="Add new reference"
    Select Options By    select[name="r_type"]    value    ${r_type}
    Select Options By    select[name="author_count"]    value    ${author_count}
    Click    button >> text="Choose"

    Fill Text    input[name="cite_key"]    ${cite_key}
    FOR    ${index}    ${author}    IN ENUMERATE    @{authors}
        Fill Text    input[name="author"] >> nth=${index}    ${author}
    END
    Fill Text    input[name="title"]    ${title}
    ${venue_field}=    Set Variable If    $r_type == 'book'    publisher    journal
    Fill Text    input[name="${venue_field}"]    ${venue}
    Fill Text    input[name="year"]    ${year}
    Click    button >> text="Create"

Create Book Reference
    [Arguments]    ${cite_key}    ${title}    ${year}    @{authors}    ${publisher}=Example Publisher
    Create Reference    book    ${cite_key}    ${title}    ${year}    ${publisher}    @{authors}

Create Article Reference
    [Arguments]    ${cite_key}    ${title}    ${year}    @{authors}    ${journal}=Example Journal
    Create Reference    article    ${cite_key}    ${title}    ${year}    ${journal}    @{authors}

Remove Reference
    [Arguments]    ${title}
    Go To Front Page
    Click    button >> text="Remove reference"
    Click    form:has(input[value*="${title}"]) button[type="submit"]

Reference Should Be Listed
    [Arguments]    ${text}
    Get Element States    ul li:has-text("${text}")    contains    visible

Page Should Contain
    [Arguments]    ${text}
    Get Text    body    contains    ${text}

Page Should Not Contain
    [Arguments]    ${text}
    Get Text    body    not contains    ${text}

Download BibTeX
    [Documentation]    Clicks the Download BibTeX button on the current page
    ...                and returns the downloaded file's contents.
    [Arguments]    ${filename}=references.bib
    ${download}=    Promise To Wait For Download    ${OUTPUT DIR}${/}${filename}
    Click    button >> text="Download BibTeX"
    ${file}=    Wait For    ${download}
    ${bibtex}=    Get File    ${file.saveAs}
    RETURN    ${bibtex}
