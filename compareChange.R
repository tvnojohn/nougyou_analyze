args <- commandArgs(trailingOnly = T)

if(length(args) != 5){
	write("Error:commandline arguments for <culmname> <when> <how long(1day~        )> <username> <password> are requied", stderr())
	 #R --vanilla --slave --args Moisture 2015-09-22 2015-09-22-Moi user pass < analyze.R
	q()
}

args[1]<-paste("'",args[1],"'",sep="")
args[1]
selectculm <- paste("select * from eko where type =",args[1],"and date =", sep = "")
selectdate <- as.Date(args[2])
selectdate
#library(changepoint)
library(ggplot2)
#library(reshape2)
source("connectSQL.R")
source("changeFinder.R")

datecount = 0
username <- args[4]
pass <- args[5]
pdf_name <- args[3]

select <- paste(selectculm,"'",selectdate,"'",sep="")
select

dbname = ''
data.table <- dataLoad(select, dbname, user, pass)
data_old <- order(data.table$date, data.table$time)
data.table <- data.table[data_old, ]

##changeFinder
x <- c(as.numeric(data.table[,2])
CF_test <- CF(x,10, 0.01, 7, 7)
plot(x, col = rep(c(1:2,1:2), each =300), ylim = range(25,CF_test), xaxp     = c(0, 1400,23))
lines(CF_test, col =4)

