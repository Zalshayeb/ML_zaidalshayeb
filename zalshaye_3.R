library(tidyverse)
library(ggplot2)
library(caret)
library(caretEnsemble)
library(psych)
library(Amelia)
library(mice)
library(GGally)
library(rpart)
library(randomForest)

data<- read.csv("C:/Users/Z/Desktop/MachineLearning/FlightDelays.csv")

data$Outcome <- factor(data$Outcome, levels = c(0,1))

str(data)

head(data)

describe(data)

indxTrain <- createDataPartition(y = data$Outcome,p = 0.75, list = FALSE)
training <- data[indxTrain,]
testing <- data[-indxTrain,]

x = training[,-9]
y = training$Outcome
 
library(e1071)

model = train(x,y,'nb',trControl =trainControl(method='cv',number=10))

Predict <- predict(model,newdata = testing )