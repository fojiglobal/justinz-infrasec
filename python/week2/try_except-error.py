#error handling

def add(num1, num2):
    # try:
    #     return (num1 + num2)
    # except:
    #     return("Invalid number")
    try:
        return (num1 + num2)
    except TypeError as error:
        return("Please Enter A Valid Number")
    except Exception as error:
        print(error)
    
print(add(10,20))    
print(add(10,'20'))
print(add(11,20))
print(add(40,20))
print(add(130,20))    