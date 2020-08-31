|=  mylist=(list @) ::open, a gate and take a sample of a list of atoms
=|  revlist=(list @) ::make, a face in the form of a list of atoms, starts empty
|-  ^-  (list @) ::open, a trap and set our recursion point
?~  mylist  revlist ::test wether mylist is null if so, return revlist because the recursion hit the end of the list 
$(revlist [i.mylist revlist], mylist t.mylist) ::if not null, revlist is set to a cell of the head of the first list and whatever was already there and mylist is set to the tail of mylist
