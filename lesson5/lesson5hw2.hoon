|=  [mylist=tape form=?(%first %second @)]
|^
^-  @tD
?+  form  '!' 
  %first  (first-arm mylist)
  %second   (second-arm mylist)
==
++  first-arm 
  |=  [findin=tape]
  `@tD`+2:findin
++  second-arm
  |=  [findin=tape]
  `@tD`&2:findin
--
