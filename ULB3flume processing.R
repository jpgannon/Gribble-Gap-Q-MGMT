
#this code will take a solinst data file for the GRIBBLE GAP FLUME and convert it to discharge
#import data and call it "gg"
setwd("/Users/jpgannon/Desktop/Gribble Gap Discharge")
outputfile <- "ulb_Winter17_disch.csv"


ggf <- read.csv("ulb_stream_winter 2017_2.csv")
#[1] "Date"                 "Abs.Pres..kPa"        "Temp"                
#[4] "Abs.Pres.Barom...kPa" "Sensor.Depth..meters" "FixedDepth"          
#[7] "X" 

#time <- paste(ggf$Date, ggf$Time)
#time <- strptime(time, format = "%m/%d/%y %H:%M:%S")
time <- ggf$Date
time <- strptime(time, format = "%m/%d/%y %H:%M")

ggf$LEVEL <- ggf$FixedDepth

#correct level based on field reading 
ggf$LEVEL <- ggf$LEVEL - 0.013712 #this is in m
#convert to cm
ggf$LEVEL <- ggf$LEVEL * 100

ggfls <- function(h){
	#converts head in cm to discharge in L/s
	disch <- (.00000001*(h^6)) - (.000001*(h^5)) + (.00002*(h^4)) + (.0017*(h^3)) + (.0481 * (h^2)) + (.0716*h + .1199)
	return(disch)
}


disch <- ggfls(ggf$LEVEL)
#colnames(disch) <- "Q"
#colnames(time) <- "Date"

final <- cbind(ggf, disch, time)
final <- final[,-1]
final <- final[,-1]
final <- final[,-1]

#write.csv(final, file = "ggf_27Aug15_disch")
write.csv(final, file = outputfile)