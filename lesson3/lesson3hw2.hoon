|=  testee=*        :: take a noun through the gate
^-  [(list @tD) *]  :: this generator returns a cell of tape and noun
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
