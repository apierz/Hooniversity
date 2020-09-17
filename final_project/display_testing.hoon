|=  lines=@ud
=<
=/  counter=@ud  6
=|  displaylist=(list @t)
=/  chromatic=(list @ud)  `(list @ud)`[1 1 1 1 1 1 1 1 1 1 1 1 1 ~] 
::  |-  ^-  (list @t)
::  ?:  =(counter 0)  `(list @t)`[fretnumber displaylist] 
::    %=  $
::    displaylist  `(list @t)`[stringbuilder displaylist]
::    counter  (dec counter)
::    ==
fretboard

|%
::
++  stringbuilder
::  |=  [root=@t scaletype=(list @ud)]
=/  counter=@ud  13
=/  stringstring=@t  ''
|-  ^-  @t
?:  =(counter 0)  (crip (weld (trip stringstring) "|"))
  ?.  =((mod counter 2) 0)  $(stringstring (crip (weld (trip stringstring) (trip afret))), counter (dec counter)) 
  $(stringstring (crip (weld (trip stringstring) (trip blankfret))), counter (dec counter))
::
++  fretnumber
  ^-  @t
  `@t`'|---0---|---1---|---2---|---3---|---4---|---5---|---6---|---7---|---8---|---9---|---10--|---11--|---12--|'

++  blankfret
  ^-  @t
  `@t`'|-------'
::
++  afret
  ^-  @t
  `@t`'|---A---'
++  g-string
  ^-  (list @t)
  `(list @t)`['G' 'G#' 'A' 'A#' 'B' 'C' 'C#' 'D' 'D#' 'E' 'F' 'F#' 'G' ~]
++  b-string
  ^-  (list @t)
  `(list @t)`['B' 'C' 'C#' 'D' 'D#' 'E' 'F' 'F#' 'G' 'G#' 'A' 'A#' 'B' ~]
++  d-string
  ^-  (list @t)
  `(list @t)`['D' 'D#' 'E' 'F' 'F#' 'G' 'G#' 'A' 'A#' 'B' 'C' 'C#' 'D' ~]
++  a-string
  ^-  (list @t)
  `(list @t)`['A' 'A#' 'B' 'C' 'C#' 'D' 'D#' 'E' 'F' 'F#' 'G' 'G#' 'A' ~]
++  e-string
  ^-  (list @t)
  `(list @t)`['E' 'F' 'F#' 'G' 'G#' 'A' 'A#' 'B' 'C' 'C#' 'D' 'D#' 'E' ~]
++  fretboard
^-  (map @ud (list @t))
  %-  my
  :~  :-  1             e-string
      :-  2             b-string
      :-  3             g-string
      :-  4             d-string
      :-  5             a-string
      :-  6             e-string
  ==
--
