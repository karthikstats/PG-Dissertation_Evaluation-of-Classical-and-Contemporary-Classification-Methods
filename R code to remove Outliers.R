# R Code to remove Outliers

remove_outliers_full <- function(df) {
  num_cols <- sapply(df, is.numeric)
  
  for (col in names(df)[num_cols]) {
    Q1 <- quantile(df[[col]], 0.25, na.rm = TRUE)
    Q3 <- quantile(df[[col]], 0.75, na.rm = TRUE)
    IQR <- Q3 - Q1
    
    lower <- Q1 - 1.5 * IQR
    upper <- Q3 + 1.5 * IQR
    
    df <- df[df[[col]] >= lower & df[[col]] <= upper, ]
  }
  return(df)
}

clean_data <- remove_outliers_full(data)
str(clean_data)
View(data)
View(clean_data)
######################################################

#comparison

boxplot(data$Cholesterol,
        main = "Boxplot of Cholesterol",
        ylab = "Cholesterol",
        col = "lightblue",
        outcol = "red")

boxplot(clean_data$Cholesterol,
        main = "Boxplot of Cholesterol",
        ylab = "Cholesterol",
        col = "lightblue",
        outcol = "red")


#########################################################


#Counts of Outliers

# Function to count outliers
count_outliers <- function(x) {
  q1 <- quantile(x, 0.25, na.rm = TRUE)
  q3 <- quantile(x, 0.75, na.rm = TRUE)
  iqr <- q3 - q1
  lower_bound <- q1 - 1.5 * iqr
  upper_bound <- q3 + 1.5 * iqr
  
  outliers <- x[x < lower_bound | x > upper_bound]
  return(list(
    count = length(outliers),
    values = outliers,
    percentage = round(length(outliers)/length(x) * 100, 2),
    bounds = c(lower = lower_bound, upper = upper_bound)
  ))
}

# Apply to age data
outlier_info <- count_outliers(data$Cholesterol)
print(outlier_info)



# Function to count outliers
count_outliers <- function(x) {
  q1 <- quantile(x, 0.25, na.rm = TRUE)
  q3 <- quantile(x, 0.75, na.rm = TRUE)
  iqr <- q3 - q1
  lower_bound <- q1 - 1.5 * iqr
  upper_bound <- q3 + 1.5 * iqr
  
  outliers <- x[x < lower_bound | x > upper_bound]
  return(list(
    count = length(outliers),
    values = outliers,
    percentage = round(length(outliers)/length(x) * 100, 2),
    bounds = c(lower = lower_bound, upper = upper_bound)
  ))
}

# Apply to age data
outlier_info <- count_outliers(clean_data$Cholesterol)
print(outlier_info)