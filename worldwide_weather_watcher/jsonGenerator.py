import json
import datetime
from datetime import timedelta
import numpy as np

fileName ="assets\data.json"
values = []

nbrOfValue = int(input('How many values do you want generate ?'))
interval = int(input('What is the interval between values ?'))

luminosity = np.random.normal(loc=500, scale=80, size=nbrOfValue)
temperature = np.random.normal(loc=25, scale=2.5, size=nbrOfValue)
humidity = np.random.normal(loc=40, scale=5, size=nbrOfValue)
atmo_pression = np.random.normal(loc=1013, scale=1, size=nbrOfValue)

for i in range(0,nbrOfValue):
    value = {
    "date" : str(datetime.datetime.now() - timedelta(minutes = interval * (nbrOfValue-i))),
    "luminosity": round(np.take(luminosity,i),2),
    "temperature": round(np.take(temperature,i),2),
    "humidity": round(np.take(humidity,i),2),
    "atmo_pression": round(np.take(atmo_pression,i),2)
    }
    values.append(value)


y = json.dumps(values)

f = open(fileName, "w")
f.write(y)
f.close()

#open and read the file after the appending:
f = open(fileName, "r")
print(f.read())