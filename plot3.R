
plot2 <- function(){
        
        # Define input file - assumes that data file has been downloaded
        # and is present in the current working directory
        inputFile <- paste("exdata_data_household_power_consumption/",
                           "household_power_consumption.txt",sep="")
        
        # Read in only relevant columns from .txt file as data table
        library(data.table)
        
        D1 <- fread(inputFile, stringsAsFactors = FALSE, 
                    select = c("Date","Time","Sub_metering_1",
                               "Sub_metering_2","Sub_metering_3"))
        
        # Convert dates from character vectors to date objects 
        D1$Date <- as.Date(D1$Date, "%d/%m/%Y")
        
        # Subset data table to dates between 2007-02-01 and 2007-02-02
        fromDate <- as.Date("2007-02-01")
        toDate   <- as.Date("2007-02-02")
        
        D1 <- D1[(D1$Date >= fromDate & D1$Date <= toDate),]
        
        D1$Sub_metering_1 <- as.numeric(D1$Sub_metering_1)
        D1$Sub_metering_2 <- as.numeric(D1$Sub_metering_2)
        D1$Sub_metering_3 <- as.numeric(D1$Sub_metering_3)
        
        # Create DateTime variable for each row in D1 data table
        x <- paste(D1$Date,D1$Time)
        DateTime <- strptime(x, "%Y-%m-%d %H:%M:%S")
        
        # Print straight to png instead of screen
        png(width = 480, height = 480, filename = "plot3.png")
        
        # Generate plot
        plot(DateTime,D1$Sub_metering_1,type="l",
             xlab="", ylab = "Energy sub metering",
             cex.lab=0.75, cex.axis=0.75)
        lines(DateTime,D1$Sub_metering_2,col="red")
        lines(DateTime,D1$Sub_metering_3,col="blue")
        legend('topright',names(D1)[3:5],
               lty = 1, cex=0.75,
               col = c("black","red","blue"))
        
        # Close device
        dev.off()
        
}