# # Writing content in a file

# with open('cities2.txt', 'a') as file:
#     content = file.write(cities)
#     print(content)
# content = open('cities2.txt', 'r')
# #print(file.read())
# new_content= content.read()
# print(new_content)

cities = ["Maryland","New Jersey","Berlin","Japan","Yaounde"]
with open('cities3.txt', 'w') as file:
    #file.write(cities)
    for city in cities:
        file.write(city + "\n")