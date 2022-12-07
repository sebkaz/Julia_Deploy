# we want build simple REST API for ML model

using Genie, Genie.Renderer.Json, Genie.Requests
using GLM, DataFrames, LinearAlgebra
using BSON

BSON.@load "mymodel.bson" model

route("/jsonexample") do 
  (:message => "Hello Julia!") |> json
end

route("/get_api", method=GET) do
  #sizeValue = params(:data, 0)
  sizeValue = getpayload(:data)
    try
      sizeValue = parse(Float64, sizeValue)
    catch e
      (:data=>[sizeValue],
       :status=> "ERROR bad value for data") |> json
    end
    # compute prediction 
    pred = predict(model, DataFrame(size = sizeValue))
    # show as json
    (:data => ([sizeValue]),
     :status=> "ok", 
     :prediction => (pred)) |> json
end


# route("/api/predict", method=POST) do
#     values = jsonpayload()
#     try
#       # compute prediction
#       pred  = predict(model, DataFrame(size = values["data"]))
#       (:status => "ok", 
#        :data => (values["data"]), 
#        :prediction => (pred)
#       ) |> json
#     catch e
#       (:status => "ERROR", :data => (values["data"])) |> json
#     end
# end


route("/") do 
  serve_static_file("main.html")
end

route("/", method=POST) do
  # tutaj popros o parsowanie Przemka
  value = postpayload()
  return value
  sizeValue = postpayload(:SizeValue)
  try
    sizeValue = parse(Float64, sizeValue)
  catch e
    return "use just numerical INT values"
  end
  
  pred = predict(model, DataFrame(size = sizeValue))
end



# route("/example") do
#   response = HTTP.post("http://localhost:8000/api/predict", 
#                       [("Content-Type", "application/json")],
#                       JSON3.write(Dict("data" => [1250,2341,15])))
#   response.body |> String |> json

  # formularz POST z targetem i przeslaniem 
# end

up(8000, async = false)
#up(8000, "0.0.0.0", async = false)