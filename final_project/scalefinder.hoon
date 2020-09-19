|=  [root=@t styleindex=@tas]
=<
=/  stringguide=(list @t)  `(list @t)`[root ~]
=/  scalestyleindex=tape  (getscaletape styleindex) 
=+  limiter=(snag 0 (fand stringguide twooctaves))
=/  scalenoteslist=(list @t)  `(list @t)`(scalelistbuilder [(octaveshortner limiter) scalestyleindex])
[scalenoteslist (fretboardmaptolist [(fretboardmap scalenoteslist) scalenoteslist])]

|%
++  getscaletape
|=  scaletype=?(%major %pentatonic %minor %ionian %dorian %phrygian %mixolydian %blues @)
^-  tape
?+  scaletype  ~|("Invalid Scale Type" !!)
  %major       "0x0x00x0x0x0"
  %minor       "0x00x0x00x0x"
  %ionian      "0x0x00x0x0x0"
  %dorian      "0x00x0x0x00x"
  %phrygian    "00x0x0x00x0x"
  %aeolian     "0x00x0x00x0x"
  %lydian      "0x0x0x00x0x0"
  %locrian     "00x0x00x0x0x"
  %mixolydian  "0x0x00x0x00x"
  %pentatonic  "0x0x0xx0x0xx"
  %blues       "0x000xx0x0xx"
  %chromatic   "000000000000"
==
::
++  fretboardmaptolist
|=  [fretboardmap=(map @ud (list @t)) scalenotelist=(list @t)]
[fretnumber (stringbuilder `(list @t)`(~(got by `(map @ud (list @t))`fretboardmap) 1) scalenotelist) (stringbuilder `(list @t)`(~(got by `(map @ud (list @t))`fretboardmap) 2) scalenotelist) (stringbuilder `(list @t)`(~(got by `(map @ud (list @t))`fretboardmap) 3) scalenotelist) (stringbuilder `(list @t)`(~(got by `(map @ud (list @t))`fretboardmap) 4) scalenotelist) (stringbuilder `(list @t)`(~(got by `(map @ud (list @t))`fretboardmap) 5) scalenotelist) (stringbuilder `(list @t)`(~(got by `(map @ud (list @t))`fretboardmap) 6) scalenotelist)]~
::
++  stringbuilder
|=  [notelist=(list @t) scalenotelist=(list @t)] 
=/  counter=@ud  17
=/  stringstring=@t  ''
|-  ^-  @t
?:  =(counter 0)  (crip (weld (trip stringstring) "|"))
$(stringstring (crip (weld (trip stringstring) (fretbuilder `(list @t)`scalenotelist `@t`(snag 0 notelist)))), counter (dec counter), notelist (oust [0 1] notelist))
::
++  fretbuilder
|=  [scalenotelist=(list @t) currentnote=@t]
=/  currentnoteaslist=(list @t)  [currentnote ~]
=/  currentnoteindex=@ud  ?:(=(currentnote 'x') 0 (snag 0 (fand currentnoteaslist scalenotelist)))
=/  fretstring=tape  "|--"
^-  tape
:: NOTE TO SELF, need to add fix for chromatic scale and other double digit indexes
?:  =(currentnote 'x')  "|-------"
  ?:  (gth (lent (trip currentnote)) 1)  (weld (weld (weld (weld fretstring ~(rend co %$ %ud (add currentnoteindex 1))) "-") (trip currentnote)) "-")
(weld (weld (weld (weld fretstring ~(rend co %$ %ud (add currentnoteindex 1))) "-") (trip currentnote)) "--")
::
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
::
++  notedeleter
|=  [stringnum=@ud scalenoteslist=(list @t)]
=/  string=(list @t)  (limo `(list @t)`(~(got by `(map @ud (list @t))`fretboard) `@ud`stringnum))
=|  editedstring=(list @t)
|-  ^-  (list @t)
?~  string  editedstring
  ~|  string
  ?~  (fand [(snag 0 `(list @t)`string) ~] scalenoteslist)  $(editedstring (snoc editedstring 'x'), string t.string)   
    $(editedstring (snoc `(list @t)`editedstring (snag 0 `(list @t)`string)), string t.string)
::
++  twooctaves
  ^-  (list @t)
  `(list @t)`['A' 'A#' 'B' 'C' 'C#' 'D' 'D#' 'E' 'F' 'F#' 'G' 'G#' 'A' 'A#' 'B' 'C' 'C#' 'D' 'D#' 'E' 'F' 'F#' 'G' 'G#' 'A' ~]
::
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
::
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
  `@t`'|---0---|---1---|---2---|---3---|---4---|---5---|---6---|---7---|---8---|---9---|---10--|---11--|---12--|---13--|---14--|---15--|---16--|'
  ::  `@t`'|--0--|--1--|--2--|--3--|--4--|--5--|--6--|--7--|--8--|--9--|-10--|-11--|-12--|-13--|-14--|-15--|-16--|-17--|-18--|-19--|-20--|'
--
