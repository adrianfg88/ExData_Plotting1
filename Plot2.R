library(lubridate) 
library(dplyr)


#Memory Needed
# Memory required = no. of column (9) * no. of rows (2.1 Mill) * 8 bytes/numeric 

#Import data, make all "?" an NA.
Week1_df<- read.table(file("household_power_consumption.txt"),na.strings = "?",header = T, sep = ";",stringsAsFactors = F)

#Add an extra column in which I Convert Date and Time into their format together (the formate part is how your data is setup, not the output) 
Week1_df$DateTime<-as.POSIXct(paste(Week1_df$Date, Week1_df$Time), format="%d/%m/%Y %H:%M:%S")

#Create Cleaned Data Frame in which only dates of Feb 01 and 02 of 2007 are cosidered
Cleaned_df <-  filter( Week1_df, year(DateTime)==2007,month(DateTime)==02,(day(DateTime)==01|day(DateTime)==02))

#Plot first graph 2D line plot
with(Cleaned_df, plot(x=DateTime,y= Global_active_power, type= "l", ylab="Global active power (killowatts)", xlab="" ))


#Copies the last plot u had into a specific format. Afterwards, it closes the device.
dev.print(png, file = "Plot2.png", width = 480, height = 480)
dev.off()
