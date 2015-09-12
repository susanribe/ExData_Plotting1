
##read source data
library(data.table)
DT <- fread("Exploratory Data Analysis\\household_power_consumption.txt", na.strings = "?")

##subset dates and convert from data.table to data.frame
dat <- as.data.frame(DT[Date == "1/2/2007" | Date == "2/2/2007",  ])
##format numeric columns
dat[, c(3:9)] <- sapply(dat[, c(3:9)], as.numeric)
##create new DateTime column
dat$DateTime <- paste(dat$Date, dat$Time)
##convert DateTime to POSIXlt
dat$DateTime <- strptime(dat$DateTime,format = "%d/%m/%Y %H:%M:%S")

##Plot 4
png("Exploratory Data Analysis\\plot4.png") ## Save to a PNG file
par(mfrow= c(2,2), mar = c(4,3,2,2))
with(dat, {
        with(dat, plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))
        plot(DateTime, Voltage, type = "l")
        with(dat, plot(DateTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
        lines(dat$DateTime, dat$Sub_metering_2, col = "Red")
        lines(dat$DateTime, dat$Sub_metering_3, col = "Blue")
        legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = c(1,1,1), col = c("Black", "Red", "Blue"))
        plot(DateTime, Global_reactive_power, type = "l")
})
dev.off() ## Close PNG device