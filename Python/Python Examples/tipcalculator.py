print("Hola bienvenido al calculador de cuentas")
bill = float(input("Cuanto fue la cuenta? $"))
tip = int(input("Que porcentaje de propina dara? 10,12 ó 15? "))
people = int(input("cuantas personas se dividira la cuenta? "))

tip_as_percent = tip / 100
total_tip_amount= bill * tip_as_percent
total_bill = bill + total_tip_amount
bill_per_person= total_bill / people
final_amount = round (bill_per_person, 2)

print(f"Each person should pay {final_amount}")