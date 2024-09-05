height = input("ingresa tu altura en metros ")
weight= input(" ingresa tu peso en kilogramos ")
bmi= int(weight)/(float(height)**2)

if bmi < 18.5:
    print(f"your BMI is {bmi} you are underweight")
elif bmi <25:
    print(f"your BMI is {bmi} you are normal weight")
elif bmi <30:
    print(f"your BMI is {bmi} you are slightly overweight")
elif bmi <35:
    print(f"your BMI is {bmi} you are obese")
else:
    print(f"your BMI is {bmi} you are clinically obese")

a=7 %-3
print(a)
b=-7%3
print(b)