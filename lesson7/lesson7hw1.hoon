:: open, a gate that takes a sample of a cell of two atoms, m and n 
::
|=  [m=@ n=@]
:: if, m = 0, then, increment n by 1  and return that value
:: else, proceed to the next line
::
?:  =(m 0)  +(n)
:: if, n = 0, then, run the following buc which has two operations
:: 1. decrement m by 1
:: 2. set n = 1
:: else, run the code on the next line
::
?:  =(n 0)  $(m (dec m), n 1)
:: this is a buc with 2 operations
:: 1. decrement m by 1
:: 2. set n = to the value of the next buc which calls the function
:: recursively with n and the decrement of n as values until n = 0
::
$(m (dec m), n $(n (dec n)))
