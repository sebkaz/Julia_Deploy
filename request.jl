using HTTP
using JSON3

req = HTTP.request("POST", "http://localhost:8000/api/predict", 
 [("Content-Type", "application/json")], """{"data":[1250,1532,2432]}""")


# req = HTTP.post("http://127.0.0.1:8000",
#                 ["Content-Type" => "application/json"],
#                 JSON3.write((status="ok", data=[1250,2341,15]) )
#                 )

print(String(req.body))