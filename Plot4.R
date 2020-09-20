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

#Configure the plotting space to have 4 graphs.
par(mfrow=c(2,2))

#Add the 2 upper graphs
with(Cleaned_df, plot(x=DateTime,y= Global_active_power, type= "l", ylab="Global active power (killowatts)", xlab="", ylim=c(0,7) ))
with(Cleaned_df, plot(x=DateTime,y= Voltage , type= "l", ylab="Voltage", xlab="datetime" ))

#Plot first an empty space for the 3rd graph
with(Cleaned_df, plot(x=DateTime, y= Sub_metering_3 ,type = "n" , ylab="Energy sub metering", xlab="" , ylim = c(0, max(c(Sub_metering_1,Sub_metering_2,Sub_metering_3)))))

#Add the lines for each variable
lines(x=Cleaned_df$DateTime, y= Cleaned_df$Sub_metering_1, type = "l", col="black")
lines(x=Cleaned_df$DateTime, y= Cleaned_df$Sub_metering_2, type = "l", col="red")
lines(x=Cleaned_df$DateTime, y= Cleaned_df$Sub_metering_3, type = "l", col="blue")

#Add the legend with colors and types
legend("toprigh", legend = c("Sub metering 1","Sub metering 2","Sub metering 3"), lty= 1, col = c("black","red","blue"),cex = .3 )

#Add the 4th, last graph
with(Cleaned_df, plot(x=DateTime,y= Global_reactive_power , type= "l", ylab="Global_reactive_power", xlab="datetime" ))


#Copies the last plot u had into a specific format. Afterwards, it closes the device.
dev.print(png, file = "Plot4.png", width = 480, height = 480)
dev.off()
