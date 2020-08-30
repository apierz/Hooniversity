|=  input=@ud
|^
^-  [@ud tape]
:-  (your-arm-one input)
(your-arm-two input)
++  your-arm-one
  |=  factor=@ud 
(add (mul factor 7) (add factor 7))
++  your-arm-two
  |=  factor=@ud
  ?:  =(factor 107)
    "You guessed the magic number"
  "Not the magic number"
--


