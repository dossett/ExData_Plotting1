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

#Plot 1
hist(power$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power(kilowatts)")
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()
