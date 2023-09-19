dev.off() 
cat("\014")


library(datasets)
require(pacman)
pacman::p_load(pacman, dplyr, GGally, ggplot2, ggthemes, ggvis, httr, lubridate, plotly, rio, rmarkdown, shiny, stringr, tidyr, rjson)


#Creating
#Based on creation from fuckcock


framexist<-exists("playertotframe")
framelen<-length("playertotframe")
if (framexist == FALSE){
  playertotframe<-data.frame(check.rows = F, check.names = F)
}

playercollator<-function(frame1){
  frame1len<-nrow(frame1)
  
  i<-1
  while (i <= frame1len){
    rowname<-row.names(frame1[i,])
    rowdata<-frame1[rowname,]

    steamid<-sapply(strsplit(rowname, split = "-"), `[`, 1)
    row.names(rowdata)<-steamid
    
    nametest<-steamid %in% row.names(playertotframe)
    
    if(nametest == T){
      
      fromplayerframe<-data.frame(playertotframe[steamid,])
      twodf<-rbind(rowdata, fromplayerframe)
      
      sums<-t(data.frame(colSums(twodf[c(1:23)])))
      means<-t(data.frame(colMeans(twodf[c(24:27)])))
      poop<-data.frame(rowdata[c(28:30)])
      
      minorframe<-cbind(sums, means)
      minorframe<-cbind(minorframe, poop)
      row.names(minorframe)<-steamid
      
      playertotframe<<-playertotframe[!(row.names(playertotframe) %in% steamid),]
      playertotframe<<-rbind(playertotframe, minorframe)
    } else {
      playertotframe<<-rbind(playertotframe, rowdata)
    }
    i<-i+1}
    
  
  }