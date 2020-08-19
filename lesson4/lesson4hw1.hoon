|=  [ud1=@ud ud2=@ud tas1=@tas]:: open, the gate with 3 arguments
|^  :: create, a new core with arms
    ^-  @ud ::cast, the return as a @ud
  ?+  :: switch, based on tas1
      ::
      tas1
      ::
      ::
      0  ::return, 0 as default if not a correct tas1
    :: if, tas1 is add call the add arm
    ::
    %add  (add-arm ud1 ud2)
    :: if, tas1 is sub call the sub arm
    ::
    %sub  (sub-arm ud1 ud2)
    :: if, tas1 is mul call the mul arm
    ::
    %mul  (mul-arm ud1 ud2)
    :: if, tas1 is div call the div arm
    ::
    %div  (div-arm ud1 ud2)
  ==  :: close, the switching core
  ++  :: create, an arm for adding
      ::
      add-arm
        :: open, the gate for the add-arm
        |=  [a=@ud b=@ud]
        (add a b)
  ++  ::create, an arm for subtracting
      ::
      sub-arm
        :: open, the gate for the sub-arm
        |=  [a=@ud b=@ud]
        ?:  :: if, a is greater than b
            ::
            (gth a b)
          ::return b - a
          ::
          (sub a b)
        :: else, return 0
        ::
        0
  ++  ::create, an arm for multiplying
      ::
      mul-arm
        :: open, the gate for the mul-arm
        |=  [a=@ud b=@ud]
        (mul a b)
  ++  ::create, an arm for dividing
      ::
      div-arm
        :: open, the gate for the add-arm
        |=  [a=@ud b=@ud]
        (div a b)
  --  ::close, the bar-het core
