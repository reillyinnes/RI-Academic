###script for getting stimulus names
rm(list=ls())
setwd()
stimDir<-("~/Desktop/jatos_mac_java/study_assets_root/emotionDiscrimination/img")

stimNames <- list.files(path=stimDir,pattern = "*.png|*.jpg|*.pdf")
#stimNames <- c(stimNames,stimNames)
saveStim <- "var test_stimuli = ["


## based on the stimulus name;
### assign correct response
### assign correct conditions
#### response keys are responseLeft and responseRight - set these in index.html. Ensure they relate to the correct response here. 

for (s in stimNames){
  gender <- ifelse(grepl("F", s), "female", "male")
  emotion <- ifelse(grepl("A", s), "Angry", "Happy")
  response <- ifelse(grepl("A", s), "responseLeft", "responseRight")
  openness <- ifelse(grepl("O", s), "open", "closed")
  saveStim <- paste0(saveStim,paste0("{ stimulus: 'img/",s,"', data: {test_part: 'test', cond: '",emotion,"', correct_response: function(){return ", response,"} , Gender: '", gender ,"' , Mouth: '", openness,"'  } },"))
}

saveStim <- paste(saveStim,"];",sep="")
saveStim
