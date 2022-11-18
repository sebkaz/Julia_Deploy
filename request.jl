using HTTP

response = HTTP.request("POST", "http://localhost:8000/api/predict", 
  [("Content-Type", "application/json")], """{"data":[1250,1532,2432]}""")

print(String(response.body))