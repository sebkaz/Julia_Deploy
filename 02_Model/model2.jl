using Serialization

pipeline = deserialize("pipline.ser")

using DataFrames

df_test = DataFrame(("size" => [5323,1250,1232]))
display(df_test)

pipeline.model(df_test)