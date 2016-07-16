library(changepoint)

setwd("/Users/murakamijun/Desktop/testRData/test2")

args <- commandArgs(trailingOnly = T)
if(length(args)!=2){
		write("Error:commandline arguments for <infile> <outfile> are required", stderr())
		q()
}

infile <- args[1]
#paste(args[1], sep = ".csv")#1番目の引数を入力ファイルとして代入する
#outfile <- args[2]
outglaph <- paste(args[2],"pdf", sep = ".")#2番目の引数を出力ファイルとして代入する
outtxt <- paste(args[2],"txt", sep = ".")

#d <- read.csv("Wind.Direction.csv", header=T)
d <- read.csv(infile, header = T)#入力ファイルを読み込む

sink(file = outtxt)
head(d)
ansmeanvar=cpt.meanvar(d[,2], method='PELT')
plot(ansmeanvar,cpt.width=3)
print(ansmeanvar)
sink()
