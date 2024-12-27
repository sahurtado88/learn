class A:
 b = 'b'
 
def __init__(self):
 self.c = 'c'
 d = self.c
 
a = A()
print(a.d)