|=  [coded-tape=tape]
=<
=.  coded-tape  (cass coded-tape)
^-  (list tape)
?~  coded-tape  !!
%+  turn  (list-builder coded-tape 26)
|=  a=tape
%+  turn  a
|=  a=@
?:  (lte `@ud`a 96)  ' ' 
?:  (lth (add a 1) 123)  (add a 1)
  (sub a 25)

|%
++  list-builder
  |=  [copy=tape steps=@ud] 
  =/  copied-list=(list tape)  ~
  =/  counter=@ud  0
  |-  ^-  (list tape)
  ?:  (gte counter steps)  copied-list
  %=  $
    copy  (turn copy |=(a=@ (add a 1)))
    copied-list  [copy copied-list]
    counter  (add counter 1)
  ==
--
