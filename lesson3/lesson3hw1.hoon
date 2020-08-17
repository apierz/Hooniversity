|=  testee=@   :: take an atom through the gate
^-  (list @tD) ::  this generator will return a tape
?:  :: if, testee is < 10
    ::
    (lth testee 10)
  :: then, say so
  ::
  "less than 10"
:: else, see if testee is greater than 100
::
?:  :: if, testee is > 100
    ::
    (gth testee 100)
  :: then, say so
  ::
  "greater than 100"
:: else, say that testee is between 10 and 100
::
"at least ten but not more than 100"
