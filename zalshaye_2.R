UniversalBank = read.csv("C:/Users/Z/Desktop/MachineLearning/UniversalBank.csv")
str(UniversalBank)

head(UniversalBank)

library(caret)
library(dplyr)

m_UniversalBank <- select(UniversalBank, Age, Experience, Income, Family, CCAvg, Education,
                          Mortgage, Personal.Loan, Securities.Account,
                          CD.Account, Online, CreditCard)
set.seed(15)


Test_Index <- caret::createDataPartition(m_UniversalBank$Personal.Loan,p=0.0, list=FALSE) # 20% reserved for Test
Test_Data <- m_UniversalBank[Test_Index,]
TraVal_Data <- m_UniversalBank[-Test_Index,]

Train_Index <- caret::createDataPartition(m_UniversalBank$Personal.Loan,p=0.4, list=FALSE)
Train_Data <- m_UniversalBank[Train_Index,]
Validation_Data <- m_UniversalBank[-Train_Index,] # rest as validation

summary(Train_Data)
summary(Validation_Data)
summary(Test_Data)

library(ggplot2)
ggplot(Train_Data, aes(x=Age,y=Experience, color=Family)) +
  geom_point() 

train.norm.df <- Train_Data
valid.norm.df <- Validation_Data
traval.norm.df <- TraVal_Data

#norm.values <- preProcess(Train_Data[, 1:2], method=c("center", "scale"))

#train.norm.df[, 1:2] <- predict(norm.values, Train_Data[, 1:2]) # Replace first two columns with normalized values
#valid.norm.df[, 1:2] <- predict(norm.values, Validation_Data[, 1:2])


#traval.norm.df[, 1:2] <- predict(norm.values, traval.norm.df[, 1:2])
#test.norm.df <- predict(norm.values, Test_Data[, 1:2])

summary(train.norm.df)
var(train.norm.df[, 1:2])
summary(valid.norm.df)
var(valid.norm.df[, 1:2])

library(FNN)
#nn <- knn(train = train.norm.df[, 1:2], test = test.norm.df, 
 #         cl = train.norm.df[, 3], k = 3, prob=TRUE) # We use k = 3, and Urban is the Y

#row.names(Train_Data)[attr(nn, "nn.index")]

library(caret)
accuracy.df <- data.frame(k = seq(1, 14, 1), accuracy = rep(0, 14))

for(i in 1:14) {
 # knn.pred <- knn(train.norm.df[, 1:2], valid.norm.df[, 1:2], 
              #    cl = train.norm.df[, 3], k = i)
#  accuracy.df[i, 2] <- confusionMatrix(knn.pred, valid.norm.df[, 3])$overall[1] 
}
accuracy.df

#norm.values <- preProcess(TraVal_Data[, 1:2], method=c("center", "scale")) # Use combined set to normalize

#traval.norm.df[, 1:2] <- predict(norm.values, TraVal_Data[, 1:2])
#test.norm.df[, 1:2] <- predict(norm.values, Test_Data[, 1:2])
summary(traval.norm.df)
#summary(test.norm.df)

#knn.pred.new <- knn(traval.norm.df[, 1:2], test.norm.df, 
              #      cl = traval.norm.df[, 3], k = 9)
#row.names(TraVal_Data)[attr(nn, "nn.index")]


levels(m_UniversalBank$ID)
#dummy_model <- dummyVars(~ID,data=m_UniversalBank)
#head(predict(dummy_model,m_UniversalBank))

