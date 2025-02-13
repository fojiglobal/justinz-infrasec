# num = [1,2,3,4,5,6,7,8,9,10]

# num.append(11)
# num.append(12)
# num.sort()
# print(num)

# numbers = range(1,100)

# multiples_three_five = []

# for num in numbers:
#     if num % 3 == 0 and num % 5 == 0:
#         multiples_three_five.append(num)
# print(multiples_three_five)

################## Dictionary ###########
# names = [
#     { 
#     "first_name": "Barack",
#     "last_name": "Obama",
#     "age": 60
# },
# {
#     "first_name": "Joe",
#     "last_name": "Biden",
#     "age": 82
# }
# ]

# names = { 
#      "first_name": "Barack",
#      "last_name": "Obama",
#     "age": 60
#  }

# #print(names[0]["first_name"])
# for item in names:
#     for key, value in item.items():
#      print(key, str(value))


########################### Temperature Convention ####################
# Write a program that takes a temp from celcuis from a user and convert to fahrenheit

#F = (C * (9/5)) + 32

# temp_c = float(input("Please Enter Temp in Celcius: "))

# temp_f = ((temp_c * 9/5) + 32)

# print("The Temp value of", temp_c, "in Celcius", "is equivalent to", temp_f, "in Fahrenheit")


####################### Functions ###################

def celcius_to_fahrenheit(temp_c):
    temp_f = ((temp_c * 9/5) + 32)
    return temp_f

Weather = float(input("Please Enter Temp in Celcius: "))

temp_value = celcius_to_fahrenheit(Weather)

#### Tell if the weather is too bad ####
if temp_value <= 40:
    print("The Temperature today is", temp_value, "So the Weather is too bad today, hence school is cancelled")
else:
    print("The Temperature today is", temp_value, "so the weather is Ok to go out")