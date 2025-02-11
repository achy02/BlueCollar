import requests

url = "https://api.opencagedata.com/geocode/v1/json"
params = {
    "q": "mum in India",
    "key": "9eeae45f457a47d2accda82162f83462"
}
print("Running")
response = requests.get(url, params=params)

if response.status_code == 200:
    data = response.json()
    for result in data["results"]:
        components = result["components"]
        if "city" in components:
            city = components["city"]
            print(city)
else:
    print("Error: ", response.status_code)
