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

png("plot3.png")
time = strptime(paste(two_days_data$Date,' ', two_days_data$Time), 
                "%Y-%m-%d %H:%M:%S")
Sys.setlocale("LC_ALL","English")
plot(time, two_days_data$Sub_metering_1, "l", xlab = "",
     ylab = "Energy sub metering")
lines(time, two_days_data$Sub_metering_2, col = "red")
lines(time, two_days_data$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c('black', 'red', 'blue'), lty = 1)
dev.off()
