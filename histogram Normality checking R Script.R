# To Conduct Histogram
# it is also used to chk normality

## To open Dataset
library(readxl)

data = read_excel(file.choose(),sheet=1)

## To View the Dataset
View(data)

## To find No. of Rows & Columns in Dataset
dim(data)
## 1st value shows Rows and 2nd shows columns


# Histogram
hist = hist(data$eyevariable,
    	 breaks = 10,
    	 col = "lightblue",
    	 border = "black",
    	 main = "Histogram of Systolic Blood Pressure",
    	 xlab = "Eye variable",
    	 probability = TRUE)

# Add normal curve
curve(dnorm(x, mean = mean(variable), sd = sd(variable)),
      col = "red", lwd = 2, add = TRUE)

