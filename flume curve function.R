

#import data and call it "ggf"

time <- paste(ggf$Date, ggf$Time)
time <- strptime(time, format = "%m/%d/%y %H:%M:%S")


ggfls <- function(h){
	#converts head in cm to discharge in L/s
	disch <- (.00000001*(h^6)) - (.000001*(h^5)) + (.00002*(h^4)) + (.0017*(h^3)) + (.0481 * (h^2)) + (.0716*h + .1199)
	return(disch)
}


disch <- ggfls(ggf$LEVEL)
colnames(disch) <- "Q"
colnames(time) <- "Date"

final <- cbind(ggf, disch, time)
final <- final[,-1]
final <- final[,-1]
final <- final[,-1]