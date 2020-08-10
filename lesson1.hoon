:: Naked Generators
:: Goal: write a program that takes your planet name and creates a cell fo your planet's number and planet's name

:: |= is a bartis which makes a gate
:: bartis takes a =sample= and has only one =arm=
|= a=@ud
a

:: ^- is ket-hep, returns some hoon code or value, expressed in an explicitly declared type if possible

::@ud = unsigned decimal @p=planet name
::can use ^- to cast data into types
^- [@ud @p] [0 ~zod]

:: :- col hep takes two nouns  to produce a cell
:: a hoon is the idoimatic naming convetion for a series of expressions that terminate back to a value
