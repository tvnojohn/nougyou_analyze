read.csv <- function(csv_name){
	x <- read.table(csv_name, header = T, sep=",",row.names=NULL)
	return(x)
}
