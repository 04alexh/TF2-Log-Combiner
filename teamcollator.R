dev.off() 
cat("\014")


library(datasets)
require(pacman)
pacman::p_load(pacman, dplyr, GGally, ggplot2, ggthemes, ggvis, httr, lubridate, plotly, rio, rmarkdown, shiny, stringr, tidyr, rjson)


#Creating
#Based on creation from fuckcock


framexist<-exists("teamtotframe")
framelen<-length("teamtotframe")
if (framexist == FALSE){
  teamtotframe<-data.frame(check.rows = F, check.names = F)
}

teamcollator<-function(frame1){
  frame1len<-nrow(frame1)
  
  i<-1
  while (i <= frame1len){
    rowname<-row.names(frame1[i,])
    rowdata<-frame1[rowname,][-c(9,23,28:30)]
    
    team<-sapply(strsplit(rowname, split = "-"), `[`, 3)
    row.names(rowdata)<-team
    
    teamtest<-team %in% row.names(teamtotframe)
    
    if(teamtest == T){
      
      fromteamframe<-data.frame(teamtotframe[team,])
      twodf<-rbind(rowdata, fromteamframe)
      
      sums<-t(data.frame(colSums(twodf[c(1:21)])))
      means<-t(data.frame(colMeans(twodf[c(22:25)])))
  
      
      minorframe<-cbind(sums, means)
      row.names(minorframe)<-team
      
      teamtotframe<<-teamtotframe[!(row.names(teamtotframe) %in% team),]
      teamtotframe<<-rbind(teamtotframe, minorframe)
    } else {
      teamtotframe<<-rbind(teamtotframe, rowdata)
    }
    i<-i+1}
  
  
}