while True:
    print("Thank you for choosing Python Pizza Deliveries ")
    size = input("What size pizza do you want? S, M, or L ").strip().upper() # What size pizza do you want? S, M, or L
    add_pepperoni = input("Do you want pepperoni? Y or N ").strip().upper() # Do you want pepperoni? Y or N
    extra_cheese = input("Do you want extra cheese? Y or N ").strip().upper()# Do you want extra cheese? Y or N
    bill= 0
    if size in ['S','M','L'] and add_pepperoni in ['Y', 'N'] and extra_cheese in ['Y', 'N']:
        break
    else:
        print("Ingrese un valor correcto")
if size == 'S':
    bill += 15
elif size == 'M':
    bill += 20
else:
    bill +=25

if add_pepperoni == "Y":
    if size == "S":
        bill += 2
    else:
        bill += 3

if extra_cheese == "Y":
    bill += 1

print (f" Your final bill is: ${bill}")
break
