using LinearAlgebra, GLM, DataFrames
using BSON: @load

@load "m.bson" m 
@load "s.bson" s 
@load "reg.bson" reg 

# predict(reg, DataFrame(size=1250))

val = (1250-m)/s

pred = predict(reg, DataFrame(size_std=val))
println("prediction for size = 1250 is $(pred[1])")