|=  testee=*  :: take a noun through the gate
?^  :: if, testee is a cell
    ::
    testee
  :: then return this cell
  ::
  ["cell" testee]
:: else, check if testee is even or odd
::
?:  :: if, testee is even
    ::
    =((mod testee 2) 0)
  :: then return this cell
  ::
  ["even" testee]
:: else, return this cell
::
["odd" testee]
