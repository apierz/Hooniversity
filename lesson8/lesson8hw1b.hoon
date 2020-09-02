:: open a gate that takes a list as a sample
::
|=  a=(list)
:: if, a = flopped a then return true (%.y), if a does not equal flopped a
:: return false (%.n)
=(a (flop a))
