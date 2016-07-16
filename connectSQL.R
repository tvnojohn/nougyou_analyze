library(RMySQL)
 
###データベースへ接続
#<"select * from database where <xxx>> のデータを取得
dataLoad <- function(selectdata, dbname, user, password){
		       
	md <- dbDriver("MySQL") 
	dbconnector <- dbConnect(md, dbname, user, password)
	sample.table <- dbGetQuery(dbconnector, selectdata)
	dbDisconnect(dbconnector)

	return(sample.table)
}

