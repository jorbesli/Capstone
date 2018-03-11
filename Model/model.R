
setwd("/Users/jakeli/Documents/Springboard/Intro to DS/Projects/Capstone/Model")
sasdf <- readRDS("Cleaned_S_A_Styles.rds")
# More data wrangling steps have been identified to be necessary since.
# 1. Removed any unnecessary columns
sasdf[1:3] <- list(NULL)
# 2. Code Education variable
#levels(sasdf$Education) <- c("BSC", "MS", "Phd")
sasdf$Education <- gsub("BSC", "1", sasdf$Education)
sasdf$Education <- gsub("MS", "2", sasdf$Education)
sasdf$Education <- gsub("Phd", "3", sasdf$Education)
# 3. Code Industry variable 
#levels(sasdf$Industry) <- c("Is in software industry", "Is not in")
sasdf$Industry <- gsub("Software Industry", "1", sasdf$Industry)
sasdf$Industry <- gsub("Education", "0", sasdf$Industry)
sasdf$Industry <- gsub("Other", "0", sasdf$Industry)

#saveRDS(sasdf, file = "styles.rds")
#saveRDS(sasdf, file = "styles.rds")

str(sasdf)

sasdf$Education <- as.integer(c(sasdf$Education))
sasdf$Industry <- as.integer(c(sasdf$Industry))
sasdf[3:20] <- as.numeric(unlist(sasdf[3:20]))

str(sasdf)

#install.packages("caTools")
library(caTools)
#set.seed(1000)
split = sample.split(sasdf$Industry, SplitRatio = 0.7)
train = subset(sasdf, split == TRUE)
test = subset(sasdf, split == FALSE)
sasdfLog = glm(Industry ~ ., data = train, family = binomial)
summary(sasdfLog)

predictTest = predict(sasdfLog, type = "response", newdata = test)
table(test$Industry, predictTest > 0.5)

#install.package("ROCR")
library(ROCR)
ROCRpred = prediction(predictTest, test$Industry)
as.numeric(performance(ROCRpred, "auc")@y.values)
plot(performance(ROCRpred, "tpr", "fpr", colorize = TRUE))



