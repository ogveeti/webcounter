*** Settings ***
Resource  resource.robot
Suite Setup  Open And Configure Browser
Suite Teardown  Close Browser

*** Test Cases ***
Reset button resets the counter to zero
    Go To  ${HOME_URL}
    Click  button >> text=Nollaa
    Click  button >> text=Paina
    Click  button >> text=Paina
    Get Text  body  *=  nappia painettu 2 kertaa
    Click  button >> text=Nollaa
    Get Text  body  *=  nappia painettu 0 kertaa
