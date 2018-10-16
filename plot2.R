plot2<- function(){
        ## This function aims to 
        ## 1) read in the "household_power_consumption.txt" file [needs to be in working directory]
        ## 2) subset the data collected between "2007-02-01" and "2007-02-02"
        ## 3) plot time against global active power (kilowatts)
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
        
        ## 3) plotting specified time against global active power (kilowatts)
        
        # adding combined date & time variable
        dataSubsetDT <-cbind(dataSubset, "DateTime" = as.POSIXct(paste(dataSubset$Date, dataSubset$Time)))
        
        png("plot2.png", width=480, height=480)
        with(dataSubsetDT, plot(Global_active_power~DateTime, type="l", xlab="Day", ylab="Global Active Power (kilowatts)"))
        dev.off()
        
}