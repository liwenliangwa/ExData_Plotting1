# load data.table library
library(data.table)

# faster read, set header = TRUE, and "?" is NA
d<-fread("exdata/household_power_consumption.txt",sep="auto",header=TRUE,na.strings=c("?"))

# subsetting to the 2 dates, note that the input file is d/m/y
sd<-d[d$Date=="1/2/2007"|d$Date=="2/2/2007"]

# convert date column + time column into datetime column
sd$DateTime<-as.POSIXct(paste(sd$Date,sd$Time,sep=" "),format="%d/%m/%Y %H:%M:%S")

# convert character value strings into numeric for all the measurement columns
sd$Global_active_power<-as(sd$Global_active_power, "numeric")
sd$Global_reactive_power<-as(sd$Global_reactive_power, "numeric")
sd$Voltage<-as(sd$Voltage, "numeric")
sd$Global_intensity<-as(sd$Global_intensity, "numeric")
sd$Sub_metering_1<-as(sd$Sub_metering_1, "numeric")
sd$Sub_metering_2<-as(sd$Sub_metering_2, "numeric")
sd$Sub_metering_3<-as(sd$Sub_metering_3, "numeric")


# Plot 2
# set margins for the 4 sides of the plot to allow enough space to display labels
par(mar=c(5.1, 4.3, 4.1, 2.1))
# plotting
with(sd, plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
# copy the plot from screen to png device with width 480 pixel and height 480 pixel
dev.copy(png,file="plot2.png",width=480,height=480)
# close the file
dev.off()