plot4<- function(){
        ## This function aims to 
        ## 1) read in the "household_power_consumption.txt" file [needs to be in working directory]
        ## 2) subset the data collected between "2007-02-01" and "2007-02-02"
        ## 3) generate plane of 2x2 plots (GAP vs. time, Vol vs. time, submetering vs. time & GRP vs. time)
        ## [ 1) & 2) are only necessary if this function is run independently of "plot1.R"]
        
        ## 1) reading the data 
        data <- read.table("./household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep =";"  )
        
        ## converting the Date and Time variables to Date/Time classes
        data$Date <- as.Date(data$Date, format="%d/%m/%Y")
        data$Time <- format(data$Time, format="%H:%M:%S")
        
        ## converting the remaining variables to numberic classes
        data$Global_active_power <- as.numeric(data$Global_active_power)
        data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
        data$Voltage <- as.numeric(data$Voltage)
        data$Global_intensity <- as.numeric(data$Global_intensity)
        data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
        data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
        data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)
        
        ## 2) subsetting the data (2007-02-01 & 2007-02-02 only)
        dataSubset <- subset(data, Date == "2007-02-01" | Date =="2007-02-02")
        
        ## 3) plotting the four graphs in one plane
        
        # adding combined date & time variable
        dataSubsetDT <-cbind(dataSubset, "DateTime" = as.POSIXct(paste(dataSubset$Date, dataSubset$Time)))
        
        png("plot4.png", width=480, height=480)
        par(mfrow=c(2,2))
        with(dataSubsetDT, plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power"))
        with(dataSubsetDT, plot(DateTime, Voltage, type = "l", xlab="datetime", ylab="Voltage"))
        with(dataSubsetDT, plot(DateTime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
        lines(dataSubsetDT$DateTime, dataSubsetDT$Sub_metering_2,type="l", col= "red")
        lines(dataSubsetDT$DateTime, dataSubsetDT$Sub_metering_3,type="l", col= "blue")
        legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))
        with(dataSubsetDT, plot(DateTime, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power"))
        dev.off()
        
}