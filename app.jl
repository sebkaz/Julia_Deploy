using Genie, Genie.Renderer.Json, Genie.Requests
using HTTP, GLM, DataFrames, LinearAlgebra
using BSON

BSON.@load "model.bson" model

route("/") do 
  return "MIT ML server API"
end

route("/api_one", method = GET) do
  x_test = params(:data, 0)
  if typeof(x_test) == String
    try
      x_test = parse(Int64, x_test)
    catch e
      return "You should have entered a numeric value for data"
    end
  end
  pred = predict(model, DataFrame(size = x_test))
  (:data => ([x_test]), :prediction => (pred)) |> json
end

route("/api/predict", method = POST) do
    message = jsonpayload()
    size_values = message["data"]
    pred  = predict(model, DataFrame(size = size_values))
  (:data => (value["data"]), :prediction => (pred)) |> json
end

route("/example") do
  response = HTTP.request("POST", "http://localhost:8000/api/predict", 
  [("Content-Type", "application/json")], """{status:"ok","data":[1250,1532,2432]}""")
  response.body |> String |> json
end

#up( async = false)
up(8000, "0.0.0.0", async = false)