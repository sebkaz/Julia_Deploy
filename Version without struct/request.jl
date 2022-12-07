using HTTP
using JSON3

req = HTTP.post("http://127.0.0.1:8000/api/predict",
                ["Content-Type" => "application/json"],
                JSON3.write(Dict("data" => [1250,2341,15]))
                )

print(String(req.body))