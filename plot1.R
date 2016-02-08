
plot1 <- function(){
        
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
        
        D1 <- D1[(D1$Date >= fromDate & D1$Date <= toDate)]
        D1$Global_active_power <- as.numeric(D1$Global_active_power)
        
        # Plot histogram of "Global_active_power"
        hist(D1$Global_active_power, col="red", 
             xlab = "Global Active Power (kilowatts)",
             main = "Global Active Power",
             cex.main = 0.85, cex.lab=0.75, cex.axis=0.75)
        
        # Copy histogram to PNG file
        dev.copy(png, file="plot1.png",
                 height=480, width=480)
        dev.off()
        
}