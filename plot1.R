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

png("plot1.png")
hist(two_days_data$Global_active_power, col = "red", 
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
