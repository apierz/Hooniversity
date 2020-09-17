|=  [root=@t styleindex=tape]
=<
=/  stringguide=(list @t)  `(list @t)`[root ~]
=+  limiter=(snag 0 (fand stringguide twooctaves))
=/  scalenoteslist=(list @t)  `(list @t)`(scalelistbuilder [(octaveshortner limiter) pentatonic])
(fretboardmaptolist (fretboardmap scalenoteslist))

|%
++  fretboardmaptolist
|=  fretboardmap=(map @ud (list @t))
=/  counter=@ud  6
=/  currentstring=(list @t)  (list @t)`(~(got by `(map @ud (list @t))`fretboardmap) 6)
currentstring
::  |-  ^-  (list @t)

++  fretboardmap
|=  scalenoteslist=(list @t)
^-  (map @ud (list @t))
::  =/  counter=@ud  6 
::  =|  fretmap=(map @ud (list @t))
%-  my
  :~  :-  1             (notedeleter [1 scalenoteslist])
      :-  2             (notedeleter [2 scalenoteslist])
      :-  3             (notedeleter [3 scalenoteslist])
      :-  4             (notedeleter [4 scalenoteslist])
      :-  5             (notedeleter [5 scalenoteslist])
      :-  6             (notedeleter [6 scalenoteslist])
  ==
::  |-  ^-  (map @ud (list @t))
::  ?:  =(counter 0)  fretmap
::    $(counter (dec counter), (~(put by fretmap) counter (notedeleter [counter scalenoteslist])))
++  major
^-  tape
"0x0x00x0x0x0"
++  pentatonic
^-  tape
"0x0x0xx0x0xx"

++  notedeleter
|=  [stringnum=@ud scalenoteslist=(list @t)]
=/  string=(list @t)  (limo `(list @t)`(~(got by `(map @ud (list @t))`fretboard) `@ud`stringnum))
=|  editedstring=(list @t)
|-  ^-  (list @t)
?~  string  editedstring
  ~|  string
  ?~  (fand [(snag 0 `(list @t)`string) ~] scalenoteslist)  $(editedstring (snoc editedstring 'x'), string t.string)   
    $(editedstring (snoc `(list @t)`editedstring (snag 0 `(list @t)`string)), string t.string)

++  twooctaves
  ^-  (list @t)
  `(list @t)`['A' 'A#' 'B' 'C' 'C#' 'D' 'D#' 'E' 'F' 'F#' 'G' 'G#' 'A' 'A#' 'B' 'C' 'C#' 'D' 'D#' 'E' 'F' 'F#' 'G' 'G#' 'A' ~]
++  octaveshortner
|=  oustto=@ud
^-  (list @t)
(oust [0 oustto] `(list @t)`twooctaves)
::
++  scalelistbuilder
|=  [shortenedlist=(list @t) styleindex=tape]
=|  returnlist=(list @t)  
|-  ^-  (list @t)
?~  styleindex  returnlist 
  ?~  shortenedlist  ~
  ?:  =((snag 0 `tape`styleindex) '0')  $(returnlist (snoc returnlist `@t`(snag 0 `(list @t)`shortenedlist)), styleindex t.styleindex, shortenedlist t.shortenedlist) 
    $(styleindex t.styleindex, shortenedlist t.shortenedlist)
::
++  g-string
  ^-  (list @t)
  `(list @t)`['G' 'G#' 'A' 'A#' 'B' 'C' 'C#' 'D' 'D#' 'E' 'F' 'F#' 'G' 'G#' 'A' 'A#' 'B' 'C' 'C#' 'D' 'D#' 'E' 'F' 'F#' 'G' ~]
++  b-string
  ^-  (list @t)
  `(list @t)`['B' 'C' 'C#' 'D' 'D#' 'E' 'F' 'F#' 'G' 'G#' 'A' 'A#' 'B' 'C' 'C#' 'D' 'D#' 'E' 'F' 'F#' 'G' 'G#' 'A' 'A#' 'B' ~]
++  d-string
  ^-  (list @t)
  `(list @t)`['D' 'D#' 'E' 'F' 'F#' 'G' 'G#' 'A' 'A#' 'B' 'C' 'C#' 'D' 'D#' 'E' 'F' 'F#' 'G' 'G#' 'A' 'A#' 'B' 'C' 'C#' 'D' ~]
++  a-string
  ^-  (list @t)
  `(list @t)`['A' 'A#' 'B' 'C' 'C#' 'D' 'D#' 'E' 'F' 'F#' 'G' 'G#' 'A' 'A#' 'B' 'C' 'C#' 'D' 'D#' 'E' 'F' 'F#' 'G' 'G#' 'A' ~]
++  e-string
  ^-  (list @t)
  `(list @t)`['E' 'F' 'F#' 'G' 'G#' 'A' 'A#' 'B' 'C' 'C#' 'D' 'D#' 'E' 'F' 'F#' 'G' 'G#' 'A' 'A#' 'B' 'C' 'C#' 'D' 'D#' 'E' ~]
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
++  fretnumber
  ^-  @t
  `@t`'|---0---|---1---|---2---|---3---|---4---|---5---|---6---|---7---|---8---|---9---|---10--|---11--|---12--|'

--
