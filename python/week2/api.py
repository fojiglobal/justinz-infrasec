# import requests
# #import json

# url = "https://google.com"
# url2 = "http://example.com"

# response = requests.get(url2)

# #result = json.loads(response)

# print(response.status_code)
# print(response.text)

import requests
import json
import os

#token = "Access key" # this need to be keep in the environment variable for not exposing it to the public.

token = os.getenv('weather_api_token')
url = f"https://api.weatherstack.com/current?access_key={token}"

cities = ["Columbus", "London"]
for city in cities:
    querystring = {"query":f"{city}"}
    response = requests.get(url, params=querystring)
    #print(response.json())
    file = json.dumps(response.json(), indent=2)

    with open("Weather.json", "a") as f:
        f.write(file)

# city = "Columbus"
# names = f"My name is Justin and I live in {city}" #using string formating f
# print(names)