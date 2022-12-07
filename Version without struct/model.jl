using CSV
using DataFrames
using GLM
using BSON: @save

load_data(path) = CSV.File(path) |> DataFrame

df = load_data("data.csv")

df[!,"target"] = df[!,"price"]/1000

model = lm(@formula(target ~ size), df::DataFrame)

@save "mymodel.bson" model