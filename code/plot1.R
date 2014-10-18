
read1<-function() {
  zipname <- "../data/household_power_consumption.zip"
  file <-unzip(zipfile=zipname,list=TRUE)
  ##unzip(zipname,"household_power_consumption.txt")
  
  message("Reading data from file")
  raw_data <<-read.table("household_power_consumption.txt",header=TRUE,sep=";" , #nrow=5000,
                         colClasses= c(numeric(),numeric(),numeric(),numeric(),numeric(),numeric(),numeric(),numeric(),numeric()))
  ##raw_data <<-rbind(feb1,feb2)
}
plot1 <-function(raw_data){ 
  if(!is.null(raw_data)){
    message("Drawing...")
    bad<-raw_data$Global_active_power=="?"
    good_raw_data<-subset(raw_data,!bad)
    feb1 <-subset(good_raw_data , Date=="1/2/2007") 
    feb2 <-subset(good_raw_data , Date=="2/2/2007") 
    graph_data =rbind(feb1,feb2)
    hist(as.numeric(graph_data$Global_active_power)/1000, col="red", main="Global Active Power", xlab="Global Active Power(killowatts)")
    dev.copy(png,file="plot1.png")
    dev.off()
  }
}
