
plot2 <- function(){
        
        # Define input file - assumes that data file has been downloaded
        # and is present in the current working directory
        inputFile <- paste("exdata_data_household_power_consumption/",
                           "household_power_consumption.txt",sep="")
        
        # Read in only relevant columns from .txt file as data table
        library(data.table)
        
        D1 <- fread(inputFile, stringsAsFactors = FALSE, 
                    select = c("Date","Time","Global_active_power"))
        
        # Convert dates from character vectors to date objects 
        D1$Date <- as.Date(D1$Date, "%d/%m/%Y")
        
        # Subset data table to dates between 2007-02-01 and 2007-02-02
        fromDate <- as.Date("2007-02-01")
        toDate   <- as.Date("2007-02-02")
        
        D1 <- D1[(D1$Date >= fromDate & D1$Date <= toDate),]
        
        D1$Global_active_power <- as.numeric(D1$Global_active_power)
        
        # Create DateTime variable for each row in D1 data table
        x <- paste(D1$Date,D1$Time)
        DateTime <- strptime(x, "%Y-%m-%d %H:%M:%S")
        
        # Plot line plot of Global_active_power against DateTime
        plot(DateTime,D1$Global_active_power,type = "l",
             xlab="",
             ylab = "Global Active Power (kilowatts)",
             cex.lab=0.75, cex.axis=0.75)
        
        # Copy plot to PNG file
        dev.copy(png, file="plot2.png",
                 height=480, width=480)
        dev.off()

}