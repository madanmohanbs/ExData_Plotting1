read1<-function() {
  zipname <- "../data/household_power_consumption.zip"
  file <-unzip(zipfile=zipname,list=TRUE)
  ##unzip(zipname,"household_power_consumption.txt")
  
  message("Reading data from file")
  raw_data <<-read.table("household_power_consumption.txt",header=TRUE,sep=";" , #nrow=5000,
                         colClasses= c(numeric(),numeric(),numeric(),numeric(),numeric(),numeric(),numeric(),numeric(),numeric()))
  ##raw_data <<-rbind(feb1,feb2)
}

plot2 <-function(raw_data){ 
  if(!is.null(raw_data)){
    message("Drawing...")
    bad<-raw_data$Global_active_power=="?"
    good_raw_data<-subset(raw_data,!bad)
    feb1 <-subset(good_raw_data , Date=="1/2/2007") 
    feb2 <-subset(good_raw_data , Date=="2/2/2007") 
    graph_data <<- rbind(feb1,feb2)
    dt<-paste(graph_data$Date,graph_data$Time)
    graph_data2 <<-cbind(graph_data,Time2=strptime(dt,"%d/%m/%Y %H:%M:%S"))
    with (graph_data2, plot(Time2,as.numeric(Global_active_power)/1000, type="n",xlab="", ylab="Global Active Power(killowatts)" ))
    with (graph_data2,lines(Time2,as.numeric(Global_active_power)/1000 ))
    dev.copy(png,file="plot2.png")
    dev.off()
  }
}