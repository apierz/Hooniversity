!.
|=  [fr-meas=@tas num=@rs to-meas=@tas]
=<
^-  @rs
?.  (check fr-meas to-meas)
  ~|("Invalid Measures" !!)
(output (meters fr-meas num) to-meas)
:: 
|%
+$  allowed  ?(%inch %foot %yard %furlong %chain %link %rod %fathom %shackle %cable %nautical-mile %hand %span %cubit %ell %bolt %league %megalithic-yard %smoot %barleycorn %poppy-seed %atto %femto %pico %nano %micro %milli %centi %deci %meter %deca %hecto %kilo %mega %giga %tera %peta %exa)
:: 
++  check
  |=  [fr-meas=@tas to-meas=@tas]
  &(?=(allowed fr-meas) ?=(allowed to-meas))
:: 
++  meters
  |=  [in=@tas value=@rs]
  =/  factor-one
    (~(got by convert-to-map) in)
  (mul:rs value factor-one)
:: 
++  output
  |=  [in=@rs out=@tas]
  ?:  =(out %meter)
    in
  (div:rs in (~(got by convert-to-map) out))
:: 
++  convert-to-map
  ^-  (map @tas @rs)
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
  --
