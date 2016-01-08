library(data.table)

#Downloading zip archive and reading data from it

zipUrl = "https://d396qusza40orc.cloudfront.net/
exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(zipUrl, temp)
data = fread(unzip(temp, "household_power_consumption.txt"), na.strings = "?")
unlink(temp)


#Transform date column to Date type

data$Date = as.Date(strptime(data$Date, "%d/%m/%Y"))


# Get rows corresponding required dates

two_days_data = data[data$Date == "2007-02-01" | data$Date == "2007-02-02",]


# Draw plot

png("plot4.png")
time = strptime(paste(two_days_data$Date,' ', two_days_data$Time), 
                "%Y-%m-%d %H:%M:%S")
Sys.setlocale("LC_ALL","English")

par(mfrow = c(2, 2))

#(1, 1)
plot(time, two_days_data$Global_active_power, "l", xlab = "",
     ylab = "Global Active Power")

#(1, 2)
plot(time, two_days_data$Voltage, "l", xlab = "datetime",
     ylab = "Voltage")

#(2, 1)
plot(time, two_days_data$Sub_metering_1, "l", xlab = "",
     ylab = "Energy sub metering")
lines(time, two_days_data$Sub_metering_2, col = "red")
lines(time, two_days_data$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c('black', 'red', 'blue'), lty = 1, bty = "n")

#(2, 2)
plot(time, two_days_data$Global_reactive_power, "l", xlab = "datetime",
     ylab = "Global_reactive_power")

dev.off()
