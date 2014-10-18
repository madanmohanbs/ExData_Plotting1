
read1<-function() {
  zipname <- "../data/household_power_consumption.zip"
  file <-unzip(zipfile=zipname,list=TRUE)
  unzip(zipname,"household_power_consumption.txt")
  
  message("Reading data from file")
  raw_data <<-read.table("household_power_consumption.txt",header=TRUE,sep=";" , #nrow=5000,
                         colClasses= c(numeric(),numeric(),numeric(),numeric(),numeric(),numeric(),numeric(),numeric(),numeric()))
  
}


plot4 <-function(raw_data){ 
  par(mfcol = c(2,2), mar=c(4,5,2,2))
  if(!is.null(raw_data)){
    message("Drawing...")
    bad<-raw_data$Voltage=="?" 
    good_raw_data<-subset(raw_data,!bad)
    feb1 <-subset(good_raw_data , Date=="1/2/2007") 
    feb2 <-subset(good_raw_data , Date=="2/2/2007") 
    graph_data <<- rbind(feb1,feb2)
    dt<-paste(graph_data$Date,graph_data$Time)
    graph_data4 <<-cbind(graph_data,datetime=strptime(dt,"%d/%m/%Y %H:%M:%S"))
    
    #1
    with (graph_data4, plot(datetime,as.numeric(Global_active_power)/1000, type="n",xlab="", ylab="Global Active Power" ))
    with (graph_data4,lines(datetime,as.numeric(Global_active_power)/1000 ))
    #2
    with (graph_data4, plot(datetime,as.numeric(Sub_metering_1),type="n",xlab="", ylab="Energy sub metering" ))
    with (graph_data4,lines(datetime,as.numeric(Sub_metering_1))  )
    with (graph_data4,lines(datetime,as.numeric(Sub_metering_2), col="red" ))
    with (graph_data4,lines(datetime,as.numeric(Sub_metering_3), col="blue"  ))
    legend("topright",col=c("black","red","blue"), pch="__", bty = "n",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
    #3
    with(graph_data4, plot(datetime,Voltage,type="n" ))
    with(graph_data4, lines(datetime,Voltage))
    #4
    with(graph_data4, plot(datetime,Global_reactive_power,type="n",xlab=))
    with(graph_data4, lines(datetime,Global_reactive_power))
    
    dev.copy(png,file="plot4.png")
    dev.off()
  }
}
