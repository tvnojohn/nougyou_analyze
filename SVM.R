#install.packages("kernlab")
library(kernlab)

setwd("/Users/murakamijun/Documents/講義/M1講義/データ科学特論/データセット")

x <- read.csv("x-tra.csv",header = F)
y1 <- read.csv("y-tra.csv",header = F)
test <- read.csv("x-test.csv",header = F)

#y <-t(as.matrix(y1))
y1 <-replace(y1,which(y1==1),"A")
y1 <-replace(y1,which(y1==-1),"B")
y <-t(y1)
z<-cbind(x,y)

plus_label = length(which(y=="A"))
minus_label = length(which(y=="B"))
cat("(# of -1):(# of +1)=",minus_label,":",plus_label,"\n")

attach(x)

#admit.svm<-ksvm(z$y~., data=z,kernel = "polydot")
admit.svm<-ksvm(z$y~., data=z,kernel = "rbfdot")
admit.svm

predict.svm<-predict(admit.svm,z)
predict.svm2<-sub("A","+1",predict.svm)
predict.svm2<-sub("B","-1",predict.svm2)
out <- NULL
for (i in 1:(length(predict.svm2)-1)) {
	out <- cbind(out, predict.svm2[i]) 
	out <- cbind(out, ",")
}
out <- cbind(out, predict.svm2[length(predict.svm2)])
write(t(out),file="ytra2.txt")
out
table(predict.svm,z$y)

sum(table(predict.svm,z$y)[1,1]+
table(predict.svm,z$y)[2,2])/sum(table(predict.svm,z$y))

result <- predict(admit.svm,test)
result2<-sub("A","+1",result)
result2<-sub("B","-1",result2)
out2 <- NULL
for (i in 1:(length(result2)-1)) {
	out2 <- cbind(out2, result2[i]) 
	out2 <- cbind(out2, ",")
}
out2 <- cbind(out2, result2[length(result2)])
write(t(out2),file="ytest.txt")
out2
#result
#cat(ifelse(result>0,+1,-1))

#result_predict.svm<-predict(x_svm, y)
#result_predict

#table(result_predict, y$Species)
