|=  [root=@t styleindex=tape]
=<
=/  stringguide=(list @t)  `(list @t)`[root ~]
=+  limiter=(snag 0 (fand stringguide twooctaves))
=/  scalenoteslist=(list @t)  `(list @t)`(scalelistbuilder [(octaveshortner limiter) pentatonic])
::  (fretboardmaptolist (fretboardmap scalenoteslist) scalenoteslist)
(fretboardmaptolist (fretboardmap scalenoteslist))

|%
++  fretboardmaptolist
::  |=  [fretboardmap=(map @ud (list @t)) scalenoteslist=(list (@t))]
|=  fretboardmap=(map @ud (list @t))
=/  counter=@ud  6
=|  displaylist=(list @t)
[fretnumber (stringbuilder `(list @t)`(~(got by `(map @ud (list @t))`fretboardmap) 1)) (stringbuilder `(list @t)`(~(got by `(map @ud (list @t))`fretboardmap) 2)) (stringbuilder `(list @t)`(~(got by `(map @ud (list @t))`fretboardmap) 3)) (stringbuilder `(list @t)`(~(got by `(map @ud (list @t))`fretboardmap) 4)) (stringbuilder `(list @t)`(~(got by `(map @ud (list @t))`fretboardmap) 5)) (stringbuilder `(list @t)`(~(got by `(map @ud (list @t))`fretboardmap) 6))]~

++  stringbuilder
|=  notelist=(list @t) 
=/  counter=@ud  21 
=/  stringstring=@t  ''
|-  ^-  @t
?:  =(counter 0)  (crip (weld (trip stringstring) "|"))
  ?:  =((snag 0 notelist) 'A')  $(stringstring (crip (weld (trip stringstring) (trip afret))), counter (dec counter), notelist (oust [0 1] notelist))
  ?:  =((snag 0 notelist) 'A#')  $(stringstring (crip (weld (trip stringstring) (trip asfret))), counter (dec counter), notelist (oust [0 1] notelist))
  ?:  =((snag 0 notelist) 'B')  $(stringstring (crip (weld (trip stringstring) (trip bfret))), counter (dec counter), notelist (oust [0 1] notelist))
  ?:  =((snag 0 notelist) 'C')  $(stringstring (crip (weld (trip stringstring) (trip cfret))), counter (dec counter), notelist (oust [0 1] notelist))
  ?:  =((snag 0 notelist) 'C#')  $(stringstring (crip (weld (trip stringstring) (trip csfret))), counter (dec counter), notelist (oust [0 1] notelist))
  ?:  =((snag 0 notelist) 'D')  $(stringstring (crip (weld (trip stringstring) (trip dfret))), counter (dec counter), notelist (oust [0 1] notelist))
  ?:  =((snag 0 notelist) 'D#')  $(stringstring (crip (weld (trip stringstring) (trip dsfret))), counter (dec counter), notelist (oust [0 1] notelist))
  ?:  =((snag 0 notelist) 'E')  $(stringstring (crip (weld (trip stringstring) (trip efret))), counter (dec counter), notelist (oust [0 1] notelist))
  ?:  =((snag 0 notelist) 'F')  $(stringstring (crip (weld (trip stringstring) (trip ffret))), counter (dec counter), notelist (oust [0 1] notelist))
  ?:  =((snag 0 notelist) 'F#')  $(stringstring (crip (weld (trip stringstring) (trip fsfret))), counter (dec counter), notelist (oust [0 1] notelist))
  ?:  =((snag 0 notelist) 'G')  $(stringstring (crip (weld (trip stringstring) (trip gfret))), counter (dec counter), notelist (oust [0 1] notelist))
  ?:  =((snag 0 notelist) 'G#')  $(stringstring (crip (weld (trip stringstring) (trip gsfret))), counter (dec counter), notelist (oust [0 1] notelist))
    $(stringstring (crip (weld (trip stringstring) (trip blankfret))), counter (dec counter), notelist (oust [0 1] notelist))
::
::  ++  fretbuilder
::  |=  scalenotelist=(list @t) currentnote=@t
::  =/  currentnoteaslist=`(list @ud)  [currentnote ~]
::  =/  currentnoteindex=@ud `@ud`(fand currentnoteaslist scalenotelist)
::  =/  fretstring=tape  "|-"
::  ^-  tape
::  (weld (fretstring 


++  fretboardmap
|=  scalenoteslist=(list @t)
^-  (map @ud (list @t))
%-  my
  :~  :-  1             (notedeleter [1 scalenoteslist])
      :-  2             (notedeleter [2 scalenoteslist])
      :-  3             (notedeleter [3 scalenoteslist])
      :-  4             (notedeleter [4 scalenoteslist])
      :-  5             (notedeleter [5 scalenoteslist])
      :-  6             (notedeleter [6 scalenoteslist])
  ==
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
  `@t`'|--0--|--1--|--2--|--3--|--4--|--5--|--6--|--7--|--8--|--9--|-10--|-11--|-12--|-13--|-14--|-15--|-16--|-17--|-18--|-19--|-20--|'
++  blankfret
  ^-  @t
  `@t`'|-----'
::
++  afret
  ^-  @t
  `@t`'|--A--'
++  asfret
  ^-  @t
  `@t`'|--A#-'
++  bfret
  ^-  @t
  `@t`'|--B--'
++  cfret
  ^-  @t
  `@t`'|--C--'
++  csfret
  ^-  @t
  `@t`'|--C#-'
++  dfret
  ^-  @t
  `@t`'|--D--'
++  dsfret
  ^-  @t
  `@t`'|--D#-'
++  efret
  ^-  @t
  `@t`'|--E--'
++  ffret
  ^-  @t
  `@t`'|--F--'
++  fsfret
  ^-  @t
  `@t`'|--F#-'
++  gfret
  ^-  @t
  `@t`'|--G--'
++  gsfret
  ^-  @t
  `@t`'|--G#-'
--
