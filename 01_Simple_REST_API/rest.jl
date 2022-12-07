# we want build simple REST API for ML model
using Genie, Genie.Renderer.Json

route("/jsonexample") do 
  (:message => "Hello Julia!") |> json
end

up(8000, async = false)