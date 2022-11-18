using Genie, Genie.Renderer.Json, Genie.Requests
using HTTP, GLM, DataFrames, LinearAlgebra
using BSON

BSON.@load "model.bson" model

route("/echo", method = POST) do
    value = jsonpayload()
    test  = predict(model, DataFrame(size = value["data"]))
  (:prediction => (test)) |> json
end

route("/send") do
  response = HTTP.request("POST", "http://localhost:8000/echo", [("Content-Type", "application/json")], """{"data":[1250,1532,2432]}""")

  response.body |> String |> json
end

up(async = false)