using HTTP

resp = HTTP.get("http://localhost:8000/jsonexample")
println(resp.status)
println(String(resp.body))

# you can also use: curl http://localhost:8000/jsonexample