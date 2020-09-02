:: My attempt:
::
::  |=  [a=(list @) b=(list @)]
::  =/  add-list=(list @)  b
::  =/  flopped-a=(list @)  (flop a)
::  |-  ^-  (list @)
::  ?~  add-list  (flop flopped-a)
::  %=  $
::  flopped-a  `(list @)`[i.add-list flopped-a]
::  add-list  t.add-list
::  ==
::
:: Example code:
::
::  open, a gate that takes a sample of two lists of atoms in a cell
::
|=  [a=(list @) b=(list @)]
::  open, a trap and cast the return as a list of atoms
::
|-  ^-  (list @)
:: test if a is null, then return b,
::
?~  a  b
:: else, make a list with the head of a and call the trap again with
:: a now being only the tail of a. When a is null it will return b
:: for the last run of the recursion and then continue up adding
:: successive heads of a as each run of the recursion finishes.
::
[i.a $(a t.a)]
