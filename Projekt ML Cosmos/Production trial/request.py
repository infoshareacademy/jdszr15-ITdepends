import requests
url = 'http://localhost:5000/results'
r = requests.post(url, json= {'relative_velocity':1.2,
                              'est_diameter_min': 2.3,
                              'est_diameter_max': 40000,
                              'miss_distance':25,
                              'absolute_magnitude':20
                              })
print(r.json())

