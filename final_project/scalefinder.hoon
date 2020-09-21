:: The outer gate of the generator takes a root note and scale type (styleindex).
:: The root note is converted to a list so that the fand and find commands can
:: be used later.
::
!.
|=  [root=@t styleindex=@tas]
=<
=/  stringguide=(list @t)  `(list @t)`[root ~]
::
::  scalestyle index takes the name of the style passed through the outer gate
::  and calls the getscaletape arm to get a tape  of 0s and xs that represent
::  the note intervals for that scale type.
::
=/  scalestyleindex=tape  (getscaletape styleindex)  
::  limiter is the index of the root note on the standard 12 note scale. It has
::  a seperate function solely for input checking.
::
=/  limiter=@ud  (getlimiter stringguide)
::  scalenoteslist is a list of @t's with each @t in the list representing one note
::  in the scale, i.e. 'F#'. octaveshortner takes the full list of notes and returns
::  the octave starting at the users chosen root note so that the intervals will
::  be calculated from that note. scalelistbuilder is an arm that builds the list.
::
=/  scalenoteslist=(list @t)  `(list @t)`(scalelistbuilder [(octaveshortner limiter) scalestyleindex])
:: the last line of the main arm builds a list to display to the user. Their
:: first item is a list of the notes in the scale in order. The second is the
:: fretboard display which converts the fretboardmap of all notes into a list
:: of @ts for display.
::
[scalenoteslist (fretboardmaptolist [(fretboardmap scalenoteslist) scalenoteslist])]
::
|%
::  getscaletape takes a @tas and switches based on the input to return a tape
::  representing the interval of the scale.
::
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
::  fretboardmaptolist takes the full map of all notes on the fretboard and the list
::  of notes in the user's chosen scale. It starts with the @t for the fretnumbers.
::  Then for each string of teh guitar it calls the stringbuilder function which takes
::  the list of notes for that string from the fretboardmap and the notes in the scale
::  and returns a string for displaying showing only the notes in the scale as they
::  appear on that string.
::
++  fretboardmaptolist
|=  [fretboardmap=(map @ud (list @t)) scalenotelist=(list @t)]
[fretnumber (stringbuilder `(list @t)`(~(got by `(map @ud (list @t))`fretboardmap) 1) scalenotelist) (stringbuilder `(list @t)`(~(got by `(map @ud (list @t))`fretboardmap) 2) scalenotelist) (stringbuilder `(list @t)`(~(got by `(map @ud (list @t))`fretboardmap) 3) scalenotelist) (stringbuilder `(list @t)`(~(got by `(map @ud (list @t))`fretboardmap) 4) scalenotelist) (stringbuilder `(list @t)`(~(got by `(map @ud (list @t))`fretboardmap) 5) scalenotelist) (stringbuilder `(list @t)`(~(got by `(map @ud (list @t))`fretboardmap) 6) scalenotelist)]~
::  stringbuilder is called by the fretboardmaptolist arm to build the @t that
::  represents the string. The string is built by welding tapes produced by
::  the fretbuilder arm.
::
::
++  stringbuilder
|=  [notelist=(list @t) scalenotelist=(list @t)] 
=/  counter=@ud  17
=/  stringstring=@t  ''
|-  ^-  @t
?:  =(counter 0)  (crip (weld (trip stringstring) "|"))
$(stringstring (crip (weld (trip stringstring) (fretbuilder `(list @t)`scalenotelist `@t`(snag 0 notelist)))), counter (dec counter), notelist (oust [0 1] notelist))
::  Fretbuilder builds a tape that represents an individual fret, e.g. "|--1-A--"
::  It adjusts the fret tape slightly to account for two character notes (e.g. G#, F#, etc.).
::
++  fretbuilder
|=  [scalenotelist=(list @t) currentnote=@t]
=/  currentnoteaslist=(list @t)  [currentnote ~]
=/  currentnoteindex=@ud  ?:(=(currentnote 'x') 0 (snag 0 (fand currentnoteaslist scalenotelist)))
=/  fretstring=tape  "|--"
^-  tape
?:  =(currentnote 'x')  "|-------"
  ?:  (gth (lent (trip currentnote)) 1)  (weld (weld (weld (weld fretstring ~(rend co %$ %ud (add currentnoteindex 1))) "-") (trip currentnote)) "-")
(weld (weld (weld (weld fretstring ~(rend co %$ %ud (add currentnoteindex 1))) "-") (trip currentnote)) "--")
::  fretboardmap builds a map of the fretboard containing only the notes in the user's
::  chosen scale. It take a @ud as a key (representing the string number) and the notes
::  are represented with a list of @t i.e. <|A B C D E|>
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
::  notedeleter replaces the notes on a string that do not appear
::  in the chosen scale with x so that they won't be displayed
::  in the final output.
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
::  octaveshortner returns a list of @t representing the notes in the standard
::  12 note octave starting with the user's chosen root note.
::
++  octaveshortner
|=  oustto=@ud
^-  (list @t)
(oust [0 oustto] `(list @t)`twooctaves)
::  scalelistbuilder returns a list of @t, where each @t represents
::  a note in the user's chosen scale
::
++  scalelistbuilder
|=  [shortenedlist=(list @t) styleindex=tape]
=|  returnlist=(list @t)  
|-  ^-  (list @t)
?~  styleindex  returnlist 
  ?~  shortenedlist  ~
  ?:  =((snag 0 `tape`styleindex) '0')  $(returnlist (snoc returnlist `@t`(snag 0 `(list @t)`shortenedlist)), styleindex t.styleindex, shortenedlist t.shortenedlist) 
    $(styleindex t.styleindex, shortenedlist t.shortenedlist)
::  an arm that supplies a list of all 12 standard notes that is used throughout the
::  generator
::
++  twooctaves
  ^-  (list @t)
  `(list @t)`['A' 'A#' 'B' 'C' 'C#' 'D' 'D#' 'E' 'F' 'F#' 'G' 'G#' 'A' 'A#' 'B' 'C' 'C#' 'D' 'D#' 'E' 'F' 'F#' 'G' 'G#' 'A' ~]
::  these arms supply a list of @t representing all of the notes on a guitar string
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
::  a map representing all notes on all strings on the guitar. the key is
::  a @ud which represents the string number and the value is one of
::  the above guitar string lists
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
::  getlimiter is used to shorten the octave for calculating
::  which notes appear in the scale. Its a seperate function
::  only to help determine if the users input is valid.
::
++  getlimiter
|=  stringguide=(list @t)
^-  @ud
?~  (fand stringguide twooctaves)  ~|("Invalid Root Note" !!)
 (snag 0 (fand stringguide twooctaves)) 
::  returns a @t of fretnumbers for the final display. Should be done recursively,
::  we will see if I get to it.
::
++  fretnumber
  ^-  @t
  `@t`'|---0---|---1---|---2---|---3---|---4---|---5---|---6---|---7---|---8---|---9---|---10--|---11--|---12--|---13--|---14--|---15--|---16--|'
--
