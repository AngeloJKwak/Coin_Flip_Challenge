library(caret) 
library(data.table)
library(Metrics)

set.seed(77)

#read in data
train <- fread('./project/volume/data/interim/train.csv')
test <- fread('./project/volume/data/raw/test_file.csv')

train_y<-train$result
test_y <- test$result

dummies <- dummyVars(result ~ ., data = train)
train<-predict(dummies, newdata = train)

#reformat after dummyVars and add back response Var
train<-data.table(train)
train$result<-train_y

#train model
glm_model <- glm(result ~ ., family=binomial, data=train)

#assess model
summary(glm_model)
coef(glm_model)

#save models
saveRDS(glm_model,"./project/volume/models/coin_flip_glm.model")
saveRDS(dummies,"./project/volume/models/dummy_glm.model")

#use the model with the test dataset 
test$result<-predict(glm_model,newdata = test, type = "response")

#format the final table for submission
submit<-test[,.(id,result)]

#write out submission file
fwrite(submit,"./project/volume/data/processed/submit_glm.csv")