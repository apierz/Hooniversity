|=  [mylist=(list @) index=@ud] ::open, a gate that takes a sample of a list of atoms and an index value
?~  mylist  !! ::test, whether mylist is null, if not then move to the next line
?:  =(0 index)  i.mylist ::test, whether index is 0 if it is return the head of mylist
$(index (dec index), mylist t.mylist) ::else, dec index by 1 and set mylist to equal the tail of mylist

