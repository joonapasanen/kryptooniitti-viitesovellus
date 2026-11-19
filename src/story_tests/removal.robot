*** Settings ***
Resource    resource.robot
Suite Setup    Open And Configure Browser
Suite Teardown    Close Browser
Test Setup    Reset Todos


*** Test Cases ***
#   Add Reference, Click Remove, Check Removal
 #   [Documentation]    This test checks that references can be removed.
  #  Go To    ${HOME_URL}
    