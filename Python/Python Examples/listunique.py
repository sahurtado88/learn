mylist= [ "apple", "banana", "cherry", "apple"]

newset = set(mylist)
newlist = list(newset)

for element in newlist:
    #print(element)
    pass

del mylist

#____________

mylist= [ "apple", "banana", "cherry", "apple"]
unique_values= [ element for element in mylist if mylist.count(element) == 1]
print(unique_values)