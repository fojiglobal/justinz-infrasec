"""
This Python Program will be used to check Current Wweather for our different cities.
Cities must be provided in a file called cities.txt
Weather APIs are available using the public Weatherstack APIs,
There are two functions as follows,
Function to return the list of cities,
Function to use the list of cities and return their current weather.
Weather API Function requires API token which can be obtained from the dashboard,
API key is stored as environemtn variable e.g eport weather_api_key ={PASTE API Key from API dashboard}
"""
import requests
import json
import os

def list_of_cities(file):
    try:
        with open(file) as f:
            content = f.read()
            cities = content.split('\n')
        #print(cities)
        return cities
    except Exception as error:
        return(error)
    
cities_names = list_of_cities("cities.txt")
#print(cities_names)


def city_current_weather(cities_names):
    token = os.getenv('weather_api_token')
    url = f"https://api.weatherstack.com/current?access_key={token}"

    try:
        for city in cities_names:
            querystring = {"query":f"{city}"}
            response = requests.get(url, params=querystring)
            #print(response.status_code)
            file = json.dumps(response.json(), indent=2)

            with open("Weather.json", "a") as f:
                f.write(file)
    except Exception as error:
        return(error)

#cities_names = list_of_cities("cities.txt")    

city_current_weather(cities_names)