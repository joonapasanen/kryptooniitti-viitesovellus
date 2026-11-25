*** Settings ***
Resource          resource.robot
Suite Setup       Open And Configure Browser
Suite Teardown    Close Browser
Test Setup        Reset Database


*** Test Cases ***
Test All Reference Types
    Go To    ${HOME_URL}

    Click    button >> text="Add new reference"
    Select Options By    select[name="r_type"]    value    inproceedings
    Select Options By    select[name="author_count"]    value    3
    Click    button >> text="Choose"

    Fill Text    input[name="cite_key"]    VPL11
    Fill Text    input[name="author"] >> nth=0    Vihavainen, Arto
    Fill Text    input[name="author"] >> nth=1    Paksula, Matti
    Fill Text    input[name="author"] >> nth=2    Luukkainen, Matti
    Fill Text    input[name="title"]    Extreme Apprenticeship Method in Teaching Programming for Beginners.
    Fill Text    input[name="booktitle"]    SIGCSE '11: Proceedings of the 42nd SIGCSE technical symposium on Computer science education
    Fill Text    input[name="year"]    2011
    Click    button >> text="Create"

    Click    button >> text="Add new reference"
    Select Options By    select[name="r_type"]    value    article
    Click    button >> text="Choose"

    Fill Text    input[name="cite_key"]    CBH91
    Fill Text    input[name="author"]    Allan Collins and John Seely Brown and Ann Holum
    Fill Text    input[name="title"]    Cognitive apprenticeship: making thinking visible
    Fill Text    input[name="journal"]    American Educator
    Fill Text    input[name="volume"]    6
    Fill Text    input[name="pages_start"]    38
    Fill Text    input[name="pages_end"]    46
    Fill Text    input[name="year"]    1991
    Click    button >> text="Create"

    Click    button >> text="Add new reference"
    Select Options By    select[name="r_type"]    value    book
    Click    button >> text="Choose"

    Fill Text    input[name="cite_key"]    Martin09
    Fill Text    input[name="author"]    Martin, Robert
    Fill Text    input[name="title"]    Clean Code: A Handbook of Agile Software Craftsmanship
    Fill Text    input[name="publisher"]    Prentice Hall
    Fill Text    input[name="year"]    2008
    Click    button >> text="Create"

    Get Element Count    ul li    ==    3
    Get Text    ul li:has-text("VPL11")    contains    VPL11
    Get Text    ul li:has-text("VPL11")    contains    Vihavainen, Arto and Paksula, Matti and Luukkainen, Matti
    Get Text    ul li:has-text("VPL11")    contains    Extreme Apprenticeship Method in Teaching Programming for Beginners.
    Get Text    ul li:has-text("VPL11")    contains    2011
    Get Text    ul li:has-text("VPL11")    contains    SIGCSE '11: Proceedings of the 42nd SIGCSE technical symposium on Computer science education

    Get Text    ul li:has-text("CBH91")    contains    CBH91
    Get Text    ul li:has-text("CBH91")    contains    Allan Collins and John Seely Brown and Ann Holum
    Get Text    ul li:has-text("CBH91")    contains    Cognitive apprenticeship: making thinking visible
    Get Text    ul li:has-text("CBH91")    contains    American Educator
    Get Text    ul li:has-text("CBH91")    contains    1991
    Get Text    ul li:has-text("CBH91")    contains    6
    Get Text    ul li:has-text("CBH91")    contains    38--46

    Get Text    ul li:has-text("Martin09")    contains    Martin09
    Get Text    ul li:has-text("Martin09")    contains    Martin, Robert
    Get Text    ul li:has-text("Martin09")    contains    Clean Code: A Handbook of Agile Software Craftsmanship
    Get Text    ul li:has-text("Martin09")    contains    2008
    Get Text    ul li:has-text("Martin09")    contains    Prentice Hall

