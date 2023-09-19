
cat("\014")


library(datasets)
require(pacman)
pacman::p_load(pacman, dplyr, GGally, ggplot2, ggthemes, ggvis, httr, lubridate, plotly, rio, rmarkdown, shiny, stringr, tidyr, rjson)


#Creating
#Based on creation from fuckcock


framexist<-exists("megaframe")
framelen<-length("megaframe")
if (framexist == FALSE){
  megaframe<-data.frame(check.rows = F, check.names = F)
}


addloghl<-function(loglink, blu, red){
  library("rjson")     #Loads json package
  logdata<-fromJSON(paste(readLines(loglink), collapse = ""))     #Reads log link
  inc <- function(i)     #Increment function
  {
    eval.parent(substitute(i <- i + 1))
  }
  playerscs<-logdata$players


  amountofplayers<-length(playerscs)
  
  i<-1
  while(i <= amountofplayers) {
    #Saves name and class of one line from new log
    tempname<-names(playerscs[i])
    tempclass<-playerscs[[tempname]][["class_stats"]][[1]][["type"]]
    
    #changes term heavyclass to heavy
    if (tempclass == "heavyweapons"){
      tempclass<-"heavy"
    }
    
  

    
    nameclass<-paste(tempname, tempclass, sep="-")
    
    
    
    
    #creates some new stats like time, team, and actual name that are added later
    time<-playerscs[[names(playerscs[i])]][["class_stats"]][[1]][["total_time"]]
    teamcol<-playerscs[[tempname]][["team"]]
    playername<-data.frame(logdata[["names"]][tempname])
    colnames(playername)<-"Name"
    classplayer<-data.frame(tempclass)
    colnames(classplayer)<-"Class"
    
    #if player in log on red, use inputted Red team name, does same with blu
    if(teamcol == "Red"){
      teamact<-red
    }else if (teamcol == "Blue"){
      teamact<-blu
    }
    
    teamtest<-teamact
    nameclassteam<-paste(nameclass, teamtest, sep="-")
    nameclassteamtest<-nameclassteam %in% row.names(megaframe)
    
    teamact<-data.frame(teamact, row.names = nameclassteam)
    colnames(teamact)<-"Team"
  
    

    
    #alters the logdata to a list without any non numerical values
    alterlist<-list(playerscs[[i]][c(-1,-2,-7,-8,-16,-17,-19,-30)])
    
    #forces the altered list to a dataframe then adds time played to it
    toframe<-as.data.frame(alterlist, row.names = nameclassteam)
    toframe<-cbind(toframe,time)
    
    #medictime
    
   
   
    #If the added log shares both the steamid and class of an existing row on the megaframe, it will 
    #sum/mean the data in those two rows, delete the old data, and input the new data into the megaframe
    if (nameclassteamtest == TRUE) {
      
      
      tocombine<-data.frame(megaframe[nameclassteam,])
      
     
      twodf<-rbind(tocombine[1,][-c(24:30)], toframe)
      
      minorframe<-t(data.frame(colSums(twodf)))
      row.names(minorframe)<-nameclassteam
      
      time<-minorframe[[23]][1]
      k<-minorframe[[1]][1]
      d<-minorframe[[2]][1]
      a<-minorframe[[3]][1]
      dmg<-minorframe[[5]][1]
      dt<-minorframe[[7]][1]
      
      kd<-k/d
      kad<-(k+a)/d
      dpm<-dmg/(time/60)
      dtm<-dt/(time/60)
      
      minorframe<-cbind(minorframe,kd)
      minorframe<-cbind(minorframe,kad)
      minorframe<-cbind(minorframe,dpm)
      minorframe<-cbind(minorframe,dtm)
      minorframe<-cbind(minorframe,classplayer)
      minorframe<-cbind(minorframe,teamact)
      minorframe<-cbind(minorframe,playername)
      
      #This deletes the megaframe's old data and then inputs the newly combined data for returning players
      megaframe<<-megaframe[!(row.names(megaframe) %in% nameclassteam),]
      megaframe<<-rbind(megaframe, minorframe)
    } else {
      
      k<-toframe[[1]][1]
      d<-toframe[[2]][1]
      a<-toframe[[3]][1]
      dmg<-toframe[[5]][1]
      dt<-toframe[[7]][1]
      
      kd<-k/d
      kad<-(k+a)/d
      dpm<-dmg/(time/60)
      dtm<-dt/(time/60)
      
      toframe<-cbind(toframe,kd)
      toframe<-cbind(toframe,kad)
      toframe<-cbind(toframe,dpm)
      toframe<-cbind(toframe,dtm)
      toframe<-cbind(toframe,classplayer)
      toframe<-cbind(toframe,teamact)
      toframe<-cbind(toframe,playername)
      
      megaframe<<-rbind(megaframe, toframe)
    }
    inc(i)
  }
}  
    
    
    
    


