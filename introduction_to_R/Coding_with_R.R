# Install a library
install.packages("package_name")
# Call a library
library(package_name)
#############################################
# Simple math operations
# Addition
a <- c (1, 0.1)
b <- c (2.33, 4)
print (a+b)

#Subtraction 
a <- 6
b <- 8.4
print (a-b)

# Multiplication
B= c(4,4) 
C= c(5,5)
print (B*C)

#Division
a <- 10
b <- 5
print (a/b)

# Power
a <- 4
b <- 5
print(a^b)
#############################################
# If operation
x <- 5 

# Check value is less than or greater than 10 
if(x > 10) { 
  print(paste(x, "is greater than 10")) 
} else { 
  print(paste(x, "is less than 10")) 
} 

# while loop
# R program to demonstrate the use of while loop 

val = 1 

# using while loop 
while (val <= 5 ) 
{ 
  # statements 
  print(val) 
  val = val + 1 
} 

# using for loop  
for (val in 1:5)  
{  
  # statement  
  print(val)  
} 

# For + if loop

val <- 6:11 

for (i in val)  
{  
  if (i == 8)  
  {  
    # test expression  
    next
  }  
  print(i)  
} 
#############################################
# dataframes management
#install.packages("readr")
library(readr)

# Read TXT files
myData = read_tsv("file_name.txt", col_names = FALSE)
print(myData)

# read csv files
myData = read.csv("file_name.csv") 
print(myData)

#read excel files
#install.packages("xlsx") 
library(xlsx) 
data <- read.xlsx("file_name.xlsx",  sheetIndex = 1,   header = FALSE) 

#create a csv file
write.csv(dataframe_name, file = "file_name.csv")


# Creating a Data Frame 
df<-data.frame(row1 = 0:2, row2 = 3:5, row3 = 6:8) 
print(df) 

# modify columns order
df <- df[c(2, 1, 3)] 
print(df) 

# Rename one column
names(df)[names(df)=="row3"]<-"three"

# Rename  multiple columns
rename(df, c("row1"="one", "row2"="two", "row3"="three")) 

#delete column
df[["row2"]]<-NULL 
print(df) 