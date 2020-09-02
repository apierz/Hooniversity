:: open, a gate that takes a tape and a @ud as a sample
:: the long-tape will have every n value ousted
::
|=  [long-tape=tape n=@ud]
::  declare a value with the face of remover. Here it equals the length
::  of long-tape, divided by n (which gives us the number of items to
::  oust) multiplied by n which sets remover equal to the position of the
::  first item to be removed (though it will have to be dec'd to account
::  for 0 index of the tape).
::
=/  remover=@ud  (mul (div (lent long-tape) n) n)
::  declare, a value with the face of remov-t equal to n. We will use this
::  to adjust remover as the generator proceeds.
::
=/  remov-t=@ud  n
:: open, a trap and cast the return as a tape
::
|-  ^-  tape
:: if, remover = 0 then, return long-tape because everything that needs to be
:: removed from long-tape has been removed
::
?:  =(remover 0)  long-tape
:: else, use %= to adjust the values of long-tape and remover and call
:: the trap again with the new values. This arm makes the following changes:
:: 1. long-tape has the atom at the (remover - 1) position ousted
:: 2. remover is reduced by the value of remov-t. If it is reduced to 0
::    the if statment above will be true and long-tape will be returned.
%=  $
long-tape  (oust [(dec remover) 1] long-tape)
remover  (sub remover remov-t) 
==
