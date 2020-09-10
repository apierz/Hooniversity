!: ::error logging
|=  [msg=tape steps=@ud] :: open a gate take a cell sample
=< :: compose two expressions, inverted so second set is executed first
=.  msg  (cass msg) :: creates a new subject with a changed value for msg, cass = lowercase
:-  (shift msg steps) :: combines two expressions into a tuple
(unshift msg steps)

|% :: creates a core, second child of =<
++  alpha  "abcdefghijklmnopqrstuvwxyz" :: first arm, a tape of lower case letters
++  shift :: second arm, shifts the message forward by calling other arms
  |=  [message=tape shift-steps=@ud] :: opens a gate, takes a cell as sample
  ^-  tape :: casts return as a tape
  (operate message (encoder shift-steps)) :: calls operate arm on message
++  unshift
  |=  [message=tape shift-steps=@ud]
  ^-  tape
  (operate message (decoder shift-steps))
++  encoder
  |=  [steps=@ud]
  ^-  (map @t @t)
  =/  value-tape=tape  (rotation alpha steps)
  (space-adder alpha value-tape)
++  decoder
  |=  [steps=@ud]
  ^-  (map @t @t)
  =/  value-tape=tape  (rotation alpha steps)
  (space-adder value-tape alpha)
++  operate
  |=  [message=tape shift-map=(map @t @t)]
  ^-  tape
  %+  turn  message
  |=  a=@t
  (~(got by shift-map) a)
++  space-adder
  |=  [key-position=tape value-result=tape]
  ^-  (map @t @t)
  (~(put by (map-maker key-position value-result)) ' ' ' ')
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
++  rotation :: shifts the alphabet tape by moving some characters to the end
  |=  [my-alphabet=tape my-steps=@ud]
  =/  length=@ud  (lent my-alphabet)
  =+  (trim (mod my-steps length) my-alphabet)
  (weld q p) :: trim gives you the p and q, weld is putting them back in reverse order
--
