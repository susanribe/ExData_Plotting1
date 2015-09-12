
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

##Plot 1
png("Exploratory Data Analysis\\plot1.png") ## Save to a PNG file
hist(dat$Global_active_power, col = "Red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off() ## Close PNG device
