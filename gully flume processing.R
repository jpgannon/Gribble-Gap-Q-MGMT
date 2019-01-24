
#this code will take a solinst data file for the GRIBBLE GAP FLUME and convert it to discharge
#import data and call it "gully"
setwd("/Users/jpgannon/Desktop/Gribble Gap Discharge")

gully <- read.csv("gully_12jan18_comp.csv", skip = 11)
outputfile <- "gully_Jan18_disch.csv"

time <- paste(gully$Date, gully$Time)
time <- strptime(time, format = "%Y/%m/%d %H:%M:%S")
#time <- strptime(time, format = "%m/%d/%y %H:%M:%S")


#ADJUST based on field measure
gully$LEVEL <- gully$LEVEL

gullyfls <- function(h){
	#converts head in cm to discharge in L/s
	disch <- -(.00000002*(h^6)) + (.000002*(h^5)) - (.00006*(h^4)) + (.0021*(h^3)) + (.0087 * (h^2)) - (.0088*h) + .0053
	return(disch)
}


disch <- gullyfls(gully$LEVEL)


final <- cbind(gully, disch, time)
final <- final[,-1]
final <- final[,-1]
final <- final[,-1]

write.csv(final, file = outputfile)