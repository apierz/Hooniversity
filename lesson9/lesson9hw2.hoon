:: changes have been noted with comments

!:
|=  [msg=tape steps=@ud]
=<
=.  msg  (cass msg)
:-  (shift msg steps)
(unshift msg steps)

|%
++  alpha  "abcdefghijklmnopqrstuvwxyz"
++  punct  "!@#$%^&*()_+-=<>.,[]" ::TODO figure out how to add {}, |
++  numbe  "0123456789"
++  shift
  |=  [message=tape shift-steps=@ud]
  ^-  tape
  (operate message (encoder shift-steps))
++  unshift
  |=  [message=tape shift-steps=@ud]
  ^-  tape
  (operate message (decoder shift-steps))
++  encoder
  |=  [steps=@ud]
  :: encoder now returns a truple of maps of cords
  ::
  ^-  [(map @t @t) (map @t @t) (map @t @t)]
  ::  rotation is called 3 times to create 3 lists for each type of character
  ::
  =/  alpha-value-tape=tape  (rotation alpha steps)
  =/  punct-value-tape=tape  (rotation punct steps)
  =/  numbe-value-tape=tape  (rotation numbe steps)
  :: create a truple of maps using the map-maker function
  ::
  :+  (map-maker alpha alpha-value-tape)
    (map-maker punct punct-value-tape)
  (map-maker numbe numbe-value-tape)
:: decoder has been modifed similarly to encoder
::
++  decoder
  |=  [steps=@ud]
  ^-  [(map @t @t) (map @t @t) (map @t @t)]
  =/  alpha-value-tape=tape  (rotation alpha steps)
  =/  punct-value-tape=tape  (rotation punct steps)
  =/  numbe-value-tape=tape  (rotation numbe steps)
  :+  (map-maker alpha-value-tape alpha)
    (map-maker punct-value-tape punct)
  (map-maker numbe-value-tape numbe)
++  operate
:: operate now takes a message tape and all 3 value maps
::
  |=  [message=tape [alpha-shift-map=(map @t @t) punct-shift-map=(map @t @t) numbe-shift-map=(map @t @t)]]
  ^-  tape
  %+  turn  message
  |=  a=@t
  :: for each a we check if we can first find it in the alpha list
  :: if not, we look in the punct, then, numbe list. if we can't find
  :: a in any of our lists (e.g. ace) then we just return a unencoded.
  :: trip is used to convert the @t a into a tape so we can use find.
  ::
  ?.  =((find (trip a) alpha) ~)
    (~(got by alpha-shift-map) a)
  ?.  =((find (trip a) punct) ~)
    (~(got by punct-shift-map) a)
  ?.  =((find (trip a) numbe) ~)
    (~(got by numbe-shift-map) a)
  a
:: space-adder arm is no longer necessary and has been removed
:: space-adder's functionality is now handeled by operate
::
::  ++  space-adder was here
++  map-maker
  |=  [key-position=tape value-result=tape]
  ^-  (map @t @t)
  =|  chart=(map @t @t)
  ?.  =((lent key-position) (lent value-result))
  ~|  %uneven-lengths  !!
  |-
  ?:  |(?=(~ key-position) ?=(~ value-result))
  chart
  $(chart (~(put by chart) i.key-position i.value-result), key-position t.key-position, value-result t.value-result)
++  rotation
  |=  [my-alphabet=tape my-steps=@ud]
  =/  length=@ud  (lent my-alphabet)
  =+  (trim (mod my-steps length) my-alphabet)
  (weld q p)
--
