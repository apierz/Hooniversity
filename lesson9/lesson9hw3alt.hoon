::  open a gate which takes an encoded tape as a sample
::
|=  [coded-tape=tape]
::  add a second section of code that gets compiled first
::
=<
::  create a new subject with a lowercase coded-tape
::
=.  coded-tape  (cass coded-tape)
::  cast the return as a list of tapes
::
^-  (list tape)
::  if input is null, error
::
?~  coded-tape  !!
::  else, turn through a list of tapes, built by list-builder
::
%+  turn  (list-builder coded-tape 26)
::  open, the turn gate
::
|=  a=tape
::  for each tape in the list, turn through every element of the list
::
%+  turn  a
::  open, the inner turn gate
::
|=  a=@
::  if the element is not [a-z], return a space
::
?:  (lte `@ud`a 96)  ' '
::  else, if a would be incremented to be z or less increment a
::
?:  (lth (add a 1) 123)  (add a 1)
  ::  else, sub 25 to start over at the beginning of [a-z]
  ::
  (sub a 25)

:: start the second section of code
::
|%
::  build, an arm call list-builder that returns a list of inc'd
::  tapes
::
++  list-builder
  ::  open a gate that takes a tape and a number of steps
  ::
  |=  [copy=tape steps=@ud]
  ::  create, a face of copied-list that is a list of tapes
  ::
  =/  copied-list=(list tape)  ~
  ::  create a face of counter
  ::
  =/  counter=@ud  0
  :: open, a trap and cast the return as a list of tapes
  ::
  |-  ^-  (list tape)
  ::  if, counter meets or exceeds steps, return the copied list
  ::
  ?:  (gte counter steps)  copied-list
  ::  else,  run this arm which increments everything in the tape by 1,
  ::  adds the tape to the copied-list, and inc's the counter by 1
  ::
  %=  $
    copy  (turn copy |=(a=@ (add a 1)))
    copied-list  [copy copied-list]
    counter  (add counter 1)
  ==
--
