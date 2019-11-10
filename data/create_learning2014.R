#Suvi Järvinen
#8.11.2019
#IODS course exercise 2

install.packages("dplyr")

#TASK 2
#Reading the data into R:
mydata <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE) #header is TRUE by default
mydata  #test print

#Exploring the structure and the dimensions of the data:
str(mydata)
dim(mydata)
#Data has 184 cases/rows and 60 variables/columns. 


#TASK 3
#Creating the analysis dataset:

#Combining questions:
library(dplyr)

attitude_q <- c("Da", "Db", "Dc", "Dd", "De", "Df", "Dg", "Dh", "Di", "Dj")
deep_q <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
stra_q <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
surf_q <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")

#Selecting the aforementioned columns, taking their means and saving them into new variables:
mydata$attitude <- rowMeans(select(mydata, one_of(attitude_q)))
mydata$deep <- rowMeans(select(mydata, one_of(deep_q)))
mydata$stra <- rowMeans(select(mydata, one_of(stra_q)))
mydata$surf <- rowMeans(select(mydata, one_of(surf_q)))

#Checking that the new variables were added to mydata:
str(mydata)


#Keeping the variables of interest:
keep <- c("Age", "Points", "gender", "attitude", "deep", "stra", "surf")
analysisdata <- select(mydata, one_of(keep))

#Creating a new dataset, excluding observations with exam points = 0:
new_dataset <- subset(analysisdata, (Points != 0))

#Checking the structure of the new dataset:
str(new_dataset)


#TASK 4
#Changing the working directory to the IODS project folder:
setwd("C:\\Users\\Susku\\OneDrive - University of Eastern Finland\\Väikkäri\\Jatko-opinnot ja HOPS\\MOOC Data Science 2019\\IODS-project")

#Saving the analysis dataset to the data folder:
write.table(new_dataset, file = "data/learning2014.txt")

#Reading the data and checking the structure:
learning2014 <- read.table("data/learning2014.txt")
str(learning2014)
head(learning2014)
