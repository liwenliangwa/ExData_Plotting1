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

# plot 3
par(mar=c(4.1, 4.3, 3.1, 1.5))
# plotting, set title, & labels
plot(sd$DateTime, sd$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
# plot additional line with red color
lines(sd$DateTime, sd$Sub_metering_2, col="red")
# plot the 3rd line with blud color
lines(sd$DateTime, sd$Sub_metering_3, col="blue")
# print legend
legend("topright", legend=c("Sub_metering_1     ","Sub_metering_2     ","Sub_metering_3     "),lty=1, 
       seg.len=1,x.intersp=0.5 ,col=c("black", "red", "blue"), cex=0.8)
# copy the plot from screen to png device with width 480 pixel and height 480 pixel
dev.copy(png,file="plot3.png",width=480,height=480)
# close the file
dev.off()