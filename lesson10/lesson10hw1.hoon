!:
|=  [fr-meas=@tas num=@rs to-meas=@tas base-quantity=@tas]
=<
^-  @rs
?.  ?=(allowed-base base-quantity)
  ~|("Invalid Base Quantity -use %length or %volume-" !!)
?.  (allowed [fr-meas to-meas base-quantity])
  ~|("Invalid Measures" !!)
(output (units fr-meas num base-quantity) to-meas (convert-to-map base-quantity))
:: 
|%
+$  allowed-len  ?(%inch %foot %yard %furlong %chain %link %rod %fathom %shackle %cable %nautical-mile %hand %span %cubit %ell %bolt %league %megalithic-yard %smoot %barleycorn %poppy-seed %atto %femto %pico %nano %micro %milli %centi %deci %meter %deca %hecto %kilo %mega %giga %tera %peta %exa)
::
+$  allowed-vol  ?(%atto %femto %pico %nano %micro %milli %cubic-milli %centi %cubic-centi %deci %tsp %tbsp %fl-oz %cup %pint %quart %liter)
::
::list versions of the unit types for experimenting
::
::  ++  allowed-len  [%inch %foot %yard %furlong %chain %link %rod %fathom %shackle %cable %nautical-mile %hand %span %cubit %ell %bolt %league %megalithic-yard %smoot %barleycorn %poppy-seed %atto %femto %pico %nano %micro %milli %centi %deci %meter %deca %hecto %kilo %mega %giga %tera %peta %exa]~
::  
::  ++  allowed-vol  [%atto %femto %pico %nano %micro %milli %cubic-milli %centi %cubic-centi %deci %tsp %tbsp %fl-oz %cup %pint %quart %liter]~
::  
::  +$  allowed-units  $:(p=(list @tas) q=(list @tas))
::
::  ++  units-list
::  ^-  (list @)
::  [allowed-len allowed-vol]~
::
+$  allowed-base  ?(%length %volume)
::
++  allowed
|=  [fr-meas=@tas to-meas=@tas base-quantity=allowed-base]
^-  flag
?-  base-quantity
%length  
  &(?=(allowed-len fr-meas) ?=(allowed-len to-meas))
%volume  
  &(?=(allowed-vol fr-meas) ?=(allowed-vol to-meas))
==
:: Attempt to make a recursive search through all the collections of values to make
:: it easier to update this generator later. Having problems with lists of list and
:: lists of unions. Not able to figure it out yet. Might be able to do it with +2:on
:: the list to get the first element of the list.
::  |=  [fr-meas=@tas to-meas=@tas]
::  =/  allowed-flag=flag  %.n
::  =/  units=(list @)  units-list
::  =/  counter=@ud  2
::  |-  ^-  flag
::  ?~  units  allowed-flag
::    ?~  (find [fr-meas]~ [i.units]~)  $(units t.units, counter (dec counter)) 
::      ?~  (find [to-meas]~ [i.units]~)  $(units t.units, counter (dec counter))
::        $(allowed-flag %.y, counter (dec counter))
::
++  units
  |=  [in=@tas value=@rs base-quantity=allowed-base]
  ^-  @rs
  =/  factor-one
    (~(got by (convert-to-map base-quantity)) in) 
  (mul:rs value factor-one)
:: 
++  output
  |=  [in=@rs out=@tas conversion-map=(map @tas @rs)]
  ^-  @rs
  ?:  =(out %meter)
    in
  (div:rs in (~(got by conversion-map) out))
:: 
++  convert-to-map
  |=  base-quantity=allowed-base
  ^-  (map @tas @rs)
  ?-  base-quantity
  %length
  %-  my
  :~  :-  %atto             .1e-18
      :-  %femto            .1e-15
      :-  %pico             .1e-12
      :-  %nano             .1e-8
      :-  %micro            .1e-6
      :-  %milli            .1e-3
      :-  %poppy-seed       .2.212e-2
      :-  %barleycorn       .8.47e-2
      :-  %centi            .1e-2
      :-  %inch             .2.54e-2
      :-  %deci             .1e-1
      :-  %hand             .1.016e-1
      :-  %link             .2.012e-1
      :-  %span             .2.228e-1
      :-  %foot             .3.048e-1
      :-  %cubit            .4.472e-1
      :-  %megalithic-yard  .8.291e-1
      :-  %yard             .9.145e-1
      :-  %ell              .1.143
      :-  %smoot            .1.7
      :-  %fathom           .1.83
      :-  %rod              .5.03
      :-  %deca             .1e1
      :-  %chain            .2.012e1
      :-  %shackle          .2.743e1
      :-  %bolt             .3.658e1
      :-  %hecto            .1e2
      :-  %cable            .1.8532e2
      :-  %furlong          .2.0117e2
      :-  %kilo             .1e3
      :-  %mile             .1.061e3
      :-  %nautical-mile    .1.850e3
      :-  %league           .4.830e3
      :-  %mega             .1e6
      :-  %giga             .1e8
      :-  %tera             .1e12
      :-  %peta             .1e15
      :-  %exa              .1e18
      :-  %meter            .1
    ==
    %volume
    %-  my
    :~  :-  %atto             .1e-18
        :-  %femto            .1e-15
        :-  %pico             .1e-12
        :-  %nano             .1e-8
        :-  %micro            .1e-6
        :-  %milli            .1e-3
        :-  %cubic-milli      .1e-3
        :-  %centi            .1e-2
        :-  %cubic-centi      .1e-2
        :-  %deci             .1e-1
        :-  %tsp              .4.929e-3
        :-  %tbsp             .1.478e-2
        :-  %fl-oz            .2.957e-2
        :-  %cup              .2.365e-1
        :-  %pint             .4.731e-1
        :-  %quart            .9.463e-1
        :-  %liter            .1
    ==
  ==
  --
