:: open, a gate that takes a sample of an atom, n
::
|=  n=@
:: create, a face named number-list which is cast as a list of atoms
::
=|  number-list=(list @)
::  create a face named k as a @ud with a value of 1
::  
=/  k=@ud  1
::  open, a trap that will return a list of atoms, we will recurse
::  here with an incremented value of k
::
|-  ^-  (list @)
:: if, n = 1, then return a list of atoms with 1 as the only value
::
?:  =(n 1)  `(list @)`[1 ~]
:: else, if k equals n, return the flopped number-list. The list is
:: built backwards by adding a new value as the head and the existing
:: list as the tail of a cell. This keeps the null at the end of the list,
:: thereby keeping it as a list. We flop it at the end to put it in order.
::
?:  =(k n)  (flop number-list) 
:: else, run the wing started by %=, which will preserve the changes it
:: makes
::
%=  $
::  set number-list equal to a cell of k^2-k+n and number-list and
::  cast it as a list of atoms
::
number-list  `(list @)`[(add (sub (mul k k) k) n) number-list]
::  set k = to the increment of k
::
k  +(k)
::  close, the centis wing and return to our trap rune starting it
::  over again with an incremented value of k
::
==
