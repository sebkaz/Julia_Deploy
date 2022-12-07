using DataFrames, StatsBase, CSV, GLM
using Serialization
load_data(path) = CSV.File(path) |> DataFrame

# check what all of this mean ? 
Base.@kwdef mutable struct Pipeline
    preprocessing!::Function
    model::Any
    runmodel::Function
end

df = load_data("data/data.csv")

function preproc!(df)
    m, s = mean_and_std(df.size)
    df[!,:size_std] .= (df.size .- m)./s
    #df[!, :target] = df[!,:price]/1000
    return df 
end

df = preproc!(df)

model = lm(@formula(target ~ size_std), df::DataFrame)

pipeline = Pipeline(preproc!, model, ()->nothing)

serialize("pipline.ser",pipeline)