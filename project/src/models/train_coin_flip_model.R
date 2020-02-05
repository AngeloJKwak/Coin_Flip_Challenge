library(caret) 
library(data.table)
library(Metrics)

#read in data
train <- fread('./project/volume/data/raw/train_file.csv')
test <- fread('./project/volume/data/raw/test_file.csv')

#Fill in any null values with 0

train_y<-train$result
#test_y<-train$SalePrice

#fit a linear model
glm.fits=glm(result ~ V1 + V2 + V3 + V4 + V5 + V6 + V7 + V8 + V9 + V10 ,data=train , family = binomial )

model<-glm (formula = result ~ V1 + V2 + V3 + V4 + V5 + V6 + V7 + V8 + V9 + V10 , data=train)

#assess model
summary(lm_model)

#save model
saveRDS(lm_model,"./project/volume/models/coin_flip_lm.model")

#use the model with the test dataset 
test$result<-predict(model,newdata = test)

#format the final table for submission
submit<-test[,.(id,model$fitted.values)]

#now we can write out a submission
fwrite(submit,"./project/volume/data/processed/submit_lm.csv")
logLoss(train_y,model$fitted.values)
logLoss(train_y,submit$result)
