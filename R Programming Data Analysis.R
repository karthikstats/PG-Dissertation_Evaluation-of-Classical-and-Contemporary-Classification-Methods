## To open Dataset
library(readxl)

data = read_excel(file.choose(),sheet=1)

## To View the Dataset
View(data)

## To find No. of Rows & Columns in Dataset
dim(data)
## 1st value shows Rows and 2nd shows columns

## To get Numerical Variables

nvar = c("Age","BMI","Cholesterol","S_BP","MaxHR")
nvar

## To get Categorical Variables

cvar = c("gender","active","ExerciseAngina","ST_Slope", "HeartDisease")
cvar

## Summary of Numerical Variables

summary(data[nvar])

## Summary of Categorical Variables by Table

lapply(data[cvar], table)

lapply(data[cvar], function(x) {
  freq <- table(x)
  perc <- prop.table(freq) * 100
  cbind(Frequency = freq,
        Percentage = round(perc, 2))
})

####Correlations Among Numerical Variables

cor_mat = cor(data[nvar], use = "complete.obs", method = "pearson")
round(cor(data[nvar], use = "complete.obs"), 2)

##### Correlation Heatmap

install.packages("corrplot")
library(corrplot)

corrplot(cor_mat,
         method = "color",
         type = "upper",
         tl.cex = 0.8,
         addCoef.col = "black",
         number.cex = 0.7)

#### same data which is transformed as numerical or binary values

ndata = read_excel(file.choose(),sheet=1)
View(ndata)

###Logistic Regression

model <- glm(HeartDisease ~ gender + active + ExerciseAngina + Age + BMI + Cholesterol + S_BP + MaxHR,
             data = ndata,
             family = binomial(link = "logit"))
model

summary(model)


####   #######

# Install packages if not already installed
install.packages(c("dplyr", "car", "ResourceSelection", "pROC"))

# Load packages
library(dplyr)
library(car)
library(ResourceSelection)
library(pROC)

################
hoslem.test(ndata$HeartDisease, fitted(model))

#####
# Predicted probabilities
ndata$prob <- predict(model, type = "response")

# Predicted class (cutoff = 0.5)
ndata$pred <- ifelse(ndata$prob >= 0.5, 1, 0)

# Confusion matrix
table(Actual = ndata$HeartDisease, Predicted = ndata$pred)
table(ndata$HeartDisease)
table(ndata$pred)

ac=sum(diag(table(Actual = ndata$HeartDisease, Predicted = ndata$pred)))/735


##### ROC AUC ####
roc_obj <- roc(data$HeartDisease, data$prob)

plot(roc_obj)
auc(roc_obj)
