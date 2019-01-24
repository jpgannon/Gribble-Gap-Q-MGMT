##YOU MUST CHECK TIME FORMAT AT ALL STEPS
outputfile <- "GribbleGap_Q_to_JAN19.csv"

###BRING IN EXISTING FULL DATA
setwd("~/OneDrive - Western Carolina University/Gribble Gap Discharge/FINAL FULL DISCHARGE RECORD")

    dat <- read.csv("GribbleGap_Q_to_DEC18.csv")
    #[1] "LEVEL"       "TEMPERATURE" "disch"       "time"        "GGwsd"  
    
    #dat$time <- strptime(dat$time, format = "%m/%d/%y %H:%M")
    dat$time <- strptime(dat$time, format = "%Y-%m-%d %H:%M:%S")
    dat$time <- as.POSIXct(dat$time)

###BRING IN NEW DATA
    setwd("~/OneDrive - Western Carolina University/Gribble Gap Discharge")
    
    newdat <- read.csv("gg_jan19_disch.csv")
    ##[1] "X"           "LEVEL"       "TEMPERATURE" "disch"       "time"    
    
    newdat$time <- strptime(newdat$time, format = "%Y-%m-%d %H:%M:%S")
    newdat$time <- as.POSIXct(newdat$time)
    
    newdat <- newdat[,-1]
    newdat <- newdat[,-1]
    
    #calc mm/d
    newdat$GGwsd <- newdat$disch * 0.2009302 

    newdat$note <- NA
#[1] "LEVEL"       "TEMPERATURE" "disch"       "time"        "GGwsd"   

##
##
##
#Check to see if index needs to be dropped from dat
    dat <- dat[,-1]
    
#combine
fulldat <- rbind(dat,newdat)

#check
plot(fulldat$time, fulldat$disch, type = 'l', log = 'y')
points(newdat$time, newdat$disch, type = 'l', col = "red",lwd = 2)

#check zoomed
start <- strptime("9/9/2018", format = "%m/%d/%Y")
end <- strptime("1/20/2019", format = "%m/%d/%Y")
plot(fulldat$time[fulldat$time > start & fulldat$time < end], fulldat$disch[fulldat$time > start & fulldat$time < end], type = 'l', log = 'y')
points(newdat$time[newdat$time > start & newdat$time < end], newdat$disch[newdat$time > start & newdat$time < end], type = 'l', col = "red")

#write output
setwd("~/OneDrive - Western Carolina University/Gribble Gap Discharge/FINAL FULL DISCHARGE RECORD")

write.csv(fulldat, outputfile)
