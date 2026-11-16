*** Settings ***
Resource  resource.robot
Suite Setup  Open And Configure Browser
Suite Teardown  Close Browser
Test Setup  Open And Reset Counter

*** Test Cases ***
Counter can be set to an arbitrary integer
    [Template]  Set Counter And Check Value
    42
    -7
    0
    1000000

Setting a value replaces the current counter value
    Set Counter And Check Value  42
    Set Counter And Check Value  9

Counter can be set to zero after being incremented
    Click  button >> text=Paina
    Set Counter And Check Value  0

Increment continues from the value that was set
    Set Counter And Check Value  42
    Click  button >> text=Paina
    Get Text  body  *=  nappia painettu 43 kertaa

Reset clears the value that was set
    Set Counter And Check Value  42
    Click  button >> text=Nollaa
    Get Text  body  *=  nappia painettu 0 kertaa

Empty input does not change the counter
    Set Counter And Check Value  42
    Fill Text  \#counter-value  ${EMPTY}
    Click  button >> text=Aseta
    ${valid}=  Evaluate JavaScript  \#counter-value  (element) => element.checkValidity()
    Should Be Equal  ${valid}  ${False}
    Get Text  body  *=  nappia painettu 42 kertaa

Fractional input does not change the counter
    Set Counter And Check Value  42
    Fill Text  \#counter-value  1.5
    Click  button >> text=Aseta
    ${valid}=  Evaluate JavaScript  \#counter-value  (element) => element.checkValidity()
    Should Be Equal  ${valid}  ${False}
    Get Text  body  *=  nappia painettu 42 kertaa

*** Keywords ***
Set Counter And Check Value
    [Arguments]  ${value}
    Fill Text  \#counter-value  ${value}
    Click  button >> text=Aseta
    Get Text  body  *=  nappia painettu ${value} kertaa
