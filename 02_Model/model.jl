using CSV, DataFrames, StatsBase, GLM
using BSON: @save

load_data(path) = CSV.File(path) |> DataFrame
# 1. Load data
df = load_data("data/data.csv")
# 2. Transform without pipeline
m, s = mean_and_std(df.size)
df[!,:size_std] .= (df.size .- m)./s
df[!,"target"] = df[!,"price"]/1000
# 3. fit model 
reg_no_std = lm(@formula(target ~ size), df::DataFrame)
reg = lm(@formula(target ~ size_std), df::DataFrame)
# 4. Save model 
@save "reg.bson" reg

# problems !
# beyond model You need m and s value to change raw data for a size feature
@save "reg_no_std.bson" reg_no_std
@save "m.bson" m
@save "s.bson" s
# solution:
# define, use and serialize pipeline 