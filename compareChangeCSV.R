args <- commandArgs(trailingOnly = T)

if(length(args) != 1){
	write("Error:commandline arguments for <culmname> <when> <how long(1day~        )> <username> <password> are requied", stderr())
	 #R --vanilla --slave --args test.csv < analyze.R
	q()
}

#library(changepoint)
library(ggplot2)
#library(reshape2)
source("readCSV.R")
source("changeFinder.R")

select <- read.csv(args[1])
selectname <- c("name","time","data")
names(select) <- selectname
#select
center <- subset(select, select$name==select[1,1])
gate <- subset(select, select$name!=select[1,1])
##changeFinder
pdf("test.pdf")
center.x <- c(as.numeric(center[,3]))
gate.x <- c(as.numeric(gate[,3]))

center.point <- CF(center.x,10, 0.01, 7, 7)
plot(center.x, type="l", lwd=5, col = 2, ylim = range(gate.x,center.point))
lines(center.point, col =3)

gate.point <- CF(gate.x,10, 0.01, 7, 7)
plot(gate.x, type="l", lwd=5,col = 1, ylim = range(gate.x,gate.point))
lines(gate.point, col =4)

plot(gate.x, type="l", lwd = 10, col = rep(c(1:2,1:2), each = nrow(gate)), ylim = range(gate.x,gate.point))
lines(gate.point, col =4)
lines(center.x, col=2,lwd=5)
lines(center.point, col =3)

y <- round(center.point - gate.point)
plot(y,type="l")
#lines(gate.point, col =4)
#lines(center.point, col =3)

y.point <- CF(y,10,0.01,7,7)
plot(y,type='l',col = rep(c(1:2,1:2), each = nrow(y)), ylim = range(y,y.point))
lines(y.point, col =4)

dev.off()
