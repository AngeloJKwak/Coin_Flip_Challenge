library(data.table)
set.seed(77)

train <- fread('./project/volume/data/raw/train_file.csv')

train_without_id<-train[,.(V1,V2,V3,V4,V5,V6,V7,V8,V9,V10,result)]

fwrite(train_without_id,'./project/volume/data/interim/train.csv')
fwrite(test,'./project/volume/data/interim/test.csv')