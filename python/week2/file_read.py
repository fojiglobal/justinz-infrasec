#reading content in a file

with open('cities2.txt') as file:
    content = file.read()
    print(content)
    cities = content.split('\n')
    #print(type(file))
    print(type(content))
    print(cities)
