#Read the file in, and drop all but the two days we care about
power <- read.table("household_power_consumption.txt", sep=";", 
                    na.strings="?", header=T)
power <- subset(power, Date %in% c("1/2/2007", "2/2/2007"))

#Convert date/time string to a single DateTime object and
#drop the origina Date and Time columns
DateTime = paste(power$Date, power$Time)
DateTime <- strptime(DateTime, "%d/%m/%Y %H:%M:%S")
lv = names(power) != "Date" & names(power) != "Time"
power = cbind(DateTime, power[,lv])

#Plot 3
plot(power$DateTime, power$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
points(power$DateTime, power$Sub_metering_2, type="l", col="red")
points(power$DateTime, power$Sub_metering_3, type="l", col="blue")
legend(x="topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red", "blue"), 
       lty=2, lwd=2, cex=.5, bty="n")
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()
