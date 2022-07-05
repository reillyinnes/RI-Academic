## SART stimuli
rm(list=ls())

#library(extrafont)

#setwd("~/Desktop/jatos_mac_java/study_assets_root/SART/")
# CEX <- c(16,15,18,14,17 )
# fonts <- c("sans", "serif","mono","Tahoma"  )

fonts <- c("Times New Roman", "Trebuchet MS","Helvetica","Arial")
sizes <- c("100", "110", "120", "130", "140"  )
numbers <- seq(1:9)
data <- expand_grid(fonts,sizes,numbers)




# for (i in 1:9){
#   for (j in CEX){
#     for (k in fonts){
#   png(paste0(i,'_',j,'_',k, '.png')) 
#   plot(1,type='n',axes=FALSE,ann=FALSE)
#   text(1,1,i, cex=j, family=k)
#   dev.off() 
#    }
#   }
# }


#stimDir<-("~/Desktop/jatos_mac_java/study_assets_root/SART/img")

#stimNames <- list.files(path=stimDir,pattern = "*.png|*.jpg|*.pdf")
#stimNames <- c(stimNames,stimNames,stimNames)
saveStim <- "var test_stimuli = ["


## based on the stimulus name;
### assign correct response
### assign correct conditions
#### response keys are responseLeft and responseRight - set these in index.html. Ensure they relate to the correct response here. 

for (i in 1:3){
  for(j in 1:nrow(data)){
    if(data$numbers[j]==3){
      saveStim <- paste0(saveStim,paste0("{ stimulus: '<p> &emsp; </p> <p> &emsp; </p> <p> &emsp; </p><div style='font-size: ",data$sizes[j],"px; font-family: ",data$fonts[j],"'>",data$numbers[j],"</div>', data: {test_part: 'no-go'} },"))
    }else{
      saveStim <- paste0(saveStim,paste0("{ stimulus: '<p> &emsp; </p> <p> &emsp; </p> <p> &emsp; </p><div style='font-size: ",data$sizes[j],"px; font-family: ",data$fonts[j],"'>",data$numbers[j],"</div>', data: {test_part: 'test'} },"))
      
    }
  }
}
# saveStim <- paste0(saveStim,paste0("{ stimulus: '<p> &emsp; </p> <p> &emsp; </p> <p> &emsp; </p><div style='font-size:30px;'>",s,"</div>', data: {test_part: 'test', cond: '",f,"', correct_response: function(){return ", resp,"} } }, "))
# 
# for (s in stimNames){
#   if (counter==0){
#     if (grepl('3',s)){
#       saveStim <- paste0(saveStim,paste0("{ stimulus: 'img/",s,"', data: {test_part: 'no-go'} },"))
#       counter = counter + 1
#     } else{
#       saveStim <- paste0(saveStim,paste0("{ stimulus: 'img/",s,"', data: {test_part: 'test' } },"))
#       counter = counter + 1
#     }
#   } else {
#     if (grepl('3',s)){
#       saveStim <- paste0(saveStim,paste0("{ stimulus: 'img/",s,"', data: {test_part: 'no-go'} },"))
#       counter = counter + 1
#     } else{
#       saveStim <- paste0(saveStim,paste0("{ stimulus: 'img/",s,"', data: {test_part: 'test'} },"))
#       counter = counter + 1
#     }
#   }
# }
saveStim <- paste(saveStim,"];",sep="")
saveStim


png('mask.png') 
plot(1,type='n',axes=FALSE,ann=FALSE)
text(1,1,"X", cex=16)
text(1,1,"O", cex=22)
dev.off()
