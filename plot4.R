
plot4 <- function(){
        
        # Define input file - assumes that data file has been downloaded
        # and is present in the current working directory
        inputFile <- paste("exdata_data_household_power_consumption/",
                           "household_power_consumption.txt",sep="")
        
        # Read in only relevant columns from .txt file as data table
        library(data.table)
        
        D1 <- fread(inputFile, stringsAsFactors = FALSE, 
                    select = c("Date","Time","Global_active_power",
                               "Global_reactive_power","Sub_metering_1",
                               "Sub_metering_2","Sub_metering_3","Voltage"))
        
        # Convert dates from character vectors to date objects 
        D1$Date <- as.Date(D1$Date, "%d/%m/%Y")
        
        # Subset data table to dates between 2007-02-01 and 2007-02-02
        fromDate <- as.Date("2007-02-01")
        toDate   <- as.Date("2007-02-02")
        
        D1 <- D1[(D1$Date >= fromDate & D1$Date <= toDate),]
        
        D1$Global_active_power <- as.numeric(D1$Global_active_power)
        D1$Global_reactive_power <- as.numeric(D1$Global_reactive_power)
        D1$Voltage <- as.numeric(D1$Voltage)
        D1$Sub_metering_1 <- as.numeric(D1$Sub_metering_1)
        D1$Sub_metering_2 <- as.numeric(D1$Sub_metering_2)
        D1$Sub_metering_3 <- as.numeric(D1$Sub_metering_3)
        
        # Create DateTime variable for each row in D1 data table
        x <- paste(D1$Date,D1$Time)
        DateTime <- strptime(x, "%Y-%m-%d %H:%M:%S")
        
        # Print straight to png instead of screen
        png(width = 480, height = 480, filename = "plot4.png")
        
        par(mfrow = c(2,2))
        
        # 1. Plot line plot of Global_active_power against DateTime
        plot(DateTime,D1$Global_active_power,type = "l",
             xlab="",
             ylab = "Global Active Power",
             cex.lab=1, cex.axis=1)
        
        # 2. Plot line plot of Voltage against DateTime
        plot(DateTime,D1$Voltage,type = "l",
             xlab="dateTime",
             ylab = "Voltage",
             cex.lab=1, cex.axis=1)
        
        # 3. Plot line plot of Submeterings against DateTime
        plot(DateTime,D1$Sub_metering_1,type="l",
             xlab="", ylab = "Energy sub metering",
             cex.lab=1, cex.axis=1)
        lines(DateTime,D1$Sub_metering_2,col="red")
        lines(DateTime,D1$Sub_metering_3,col="blue")
        legend('topright',names(D1)[6:8],
               lty = 1, cex=1, bty="n",
               col = c("black","red","blue"))
        
        # 4. Plot line plot of Global_reactive_power against DateTime
        plot(DateTime,D1$Global_reactive_power,type = "l",
             xlab="dateTime",
             ylab = "Global_reactive_power",
             cex.lab=1, cex.axis=1)
        
        dev.off()
}
        