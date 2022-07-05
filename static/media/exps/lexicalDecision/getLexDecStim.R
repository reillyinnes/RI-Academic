rm(list=ls())
setwd("~/Documents/Research/General_Experiment/Coding_Experiments/Examples")
data <- read.csv("wgnmkrs_stim.csv")
data <- data[!is.na(data$FREQ),]
table(data$COND)
data$resp <- ifelse(data$COND >2, "word", "non-word")
data$freqCond <- 0
data$freqCond[data$FREQ>77]<- 4
data$freqCond[data$FREQ< 70 & data$FREQ>3]<- 3
data$freqCond[data$FREQ<2 & data$resp == "word"]<- 2
data$freqCond[data$resp == "non-word"]<- 1
table(data$freqCond)

tmp<-split.data.frame(data, data$freqCond)

ntrials <- 40

NW <- sample(as.character(tmp$'1'$WORD), ntrials*3)
VLF <- sample(as.character(tmp$'2'$WORD), ntrials)
LF <- sample(as.character(tmp$'3'$WORD), ntrials)
HF <- sample(as.character(tmp$'4'$WORD), ntrials)

NW <- cbind(NW, "NW", "non-word")
VLF<- cbind(VLF, "VLF", "word")
LF<- cbind(LF, "LF", "word")
HF<- cbind(HF, "HF", "word")

data <- rbind(NW,VLF,LF,HF)
data <- as.data.frame(data)
names(data)<- c("stimuli", "freq", "cond")

saveStim <- "var test_stimuli = ["

counter<-0

for (i in 1:nrow(data)){
      s = data$stimuli[i]
      f = data$freq[i]
      c = data$cond[i]
      resp = ifelse(c == "word", "responseLeft", "responseRight")
    
  if (counter==0){
      saveStim <- paste0(saveStim,paste0("{ stimulus: '<p> &emsp; </p> <p> &emsp; </p> <p> &emsp; </p><div style='font-size:30px;'>",s,"</div>', data: {test_part: 'test', cond: '",f,"', correct_response: function(){return ", resp,"} } }, "))
      counter = counter + 1
    } else {
      saveStim <- paste0(saveStim,paste0("{ stimulus: '<p> &emsp; </p> <p> &emsp; </p> <p> &emsp; </p><div style='font-size:30px;'>",s,"</div>', data: {test_part: 'test', cond: '",f,"', correct_response: function(){return ", resp,"}  } }, "))
      counter = counter + 1
  }
}
saveStim <- paste(saveStim,"];",sep="")
saveStim
