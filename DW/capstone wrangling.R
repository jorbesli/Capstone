sasdf<- read.csv("S_A_Styles.csv")
#install.packages("tidyr")
#library(tidyr)
str(sasdf)
#Following codes used for converting names to the actual style names
#names(sasdf) <- gsub("^.*How.Many.", "", names(sasdf))
#names(sasdf) <- gsub(".Style.*$", "", names(sasdf))
#names(sasdf) <- gsub(".Architectural$", "", names(sasdf))
#names(sasdf) <- gsub("\\.$", "", names(sasdf))
#names(sasdf) <- gsub("\\.$", "", names(sasdf))
#names(sasdf) <- gsub("^\\.", "", names(sasdf))
#names(sasdf) <- gsub("\\.", " ", names(sasdf))

#Renaming column/variable names
names(sasdf) <- gsub(".How.*$", "", names(sasdf))
names(sasdf) <- gsub("^X", "Style #", names(sasdf))
names(sasdf) <- gsub(".*Name.*", "Name", names(sasdf))
names(sasdf) <- gsub(".*Experience.*", "Industry", names(sasdf))
names(sasdf) <- gsub(".*Degree.*", "Education", names(sasdf))
names(sasdf)

#Separating variable Industry
sasdf <- separate_rows(sasdf, Industry, sep = ";")

#Shortening variable Education
sasdf$Education <- gsub(" \\(CS or SE)$", "", sasdf$Education)
sasdf$Education <- gsub("\\(CS or SE)$", "", sasdf$Education)

#Checking the unique values of variables
unique(sasdf$Education)
unique(sasdf$Industry)

#Checking duplicates
if(anyDuplicated(sasdf)!=FALSE)
  sasdf <- unique(sasdf)

#Checking missing values
if(anyNA(sasdf)!=FALSE)
  sasdf <- na.omit(sasdf)

View(sasdf)
saveRDS(sasdf, file = "Cleaned_S_A_Styles.rds")
write.csv(sasdf, file = "Cleaned_S_A_Styles.csv")
