using Genie, Genie.Renderer.Json, Genie.Requests
using HTTP, GLM, DataFrames, LinearAlgebra
using BSON, JSON3

BSON.@load "model.bson" model

route("/") do 
  return "MIT ML server API"
end

route("/api_one", method = GET) do
  x_test = params(:data, 0)
   
  # if occursin("[", x_test)
    # tutaj dopisac kod parsujący "[1,2,3]" na [1,2,3]
  # else
    try
      x_test = parse(Int64, x_test)
    catch e
      return "You should have entered a numeric value for data"
    end
  pred = predict(model, DataFrame(size = x_test))
  (:data => ([x_test]), :prediction => (pred)) |> json
  end

route("/api/predict", method = POST) do
    values = jsonpayload()
    try 
    pred  = predict(model, DataFrame(size = values["data"]))
    pred2 = predict(model, DataFrame(size = values["data2"]))
  (:status => "ok", 
  :data => (values["data"]), 
  :prediction => (pred),
  :prediction2 => (pred2)) |> json
    catch e
  (:status => "ERROR", :data => (values["data"])) |> json
    end

end

route("/example") do
  response = HTTP.post("http://localhost:8000/api/predict", 
                      [("Content-Type", "application/json")],
                      JSON3.write(Dict("data2"=> 1250, "data" => [1250,2341,15])))
  response.body |> String |> json
end

#up( async = false)
up(8000, "0.0.0.0", async = false)