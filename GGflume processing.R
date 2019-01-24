
#this code will take a solinst data file for the GRIBBLE GAP FLUME and convert it to discharge
#import data and call it "gg"
setwd("~/OneDrive - Western Carolina University/Gribble Gap Discharge")

###INPUTS###
outputfile <- "gg_jan19_disch.csv"
ggf <- read.csv("ggflume jan19.csv", skip = 10)
#############


time <- paste(ggf$Date, ggf$Time)
#time <- strptime(time, format = "%m/%d/%Y %I:%M:%S %p")
time <- strptime(time, format = "%m/%d/%y %H:%M:%S")
#time <- strptime(time, format = "%Y/%m/%d %H:%M:%S")

#correct level based on field reading 
ggf$LEVEL <- ggf$LEVEL - 0.5

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