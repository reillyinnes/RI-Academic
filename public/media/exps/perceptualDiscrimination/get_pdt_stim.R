rm(list=ls())
setwd("~/Desktop/jatos_mac_java/study_assets_root/perceptualDiscrimination/img")
values <- c(0.47,0.485,0.49,0.51,0.515,0.53)
colour <- c(rep("blue",3), rep("orange", 3))
ntrials <- 40

library(raster)    

blue <- rgb(0,25,63,1,max=255)
orange <- rgb(63,25,0,1,max=255)


for (i in 1:length(values)){
  for (j in 1:ntrials){
    coherence = values[i]
    orange = ceiling(256*coherence)
    blue = 256-orange
    col <- colour[i]
    colours <- c(rep(TRUE,blue), rep(FALSE, orange))
    png(paste0(col, "_", coherence,"_", j, '.png')) 
    r <- matrix(sample(colours,256), ncol=16)
    #r <- matrix(runif(256)<coherence, ncol=16)
    #par(bg = 'black')
    #plot(raster(r), col = c("#002563", "#632500"), axes=F, box=F, legend=F)
    plot(raster(r), col = c("orange", "blue"), axes=F, box=F, legend=F)

    #plot(raster(r), col = c("blue", "orange"), axes=F, box=F, legend=F)
    dev.off() 
  }
}

  
stimDir<-("~/Desktop/jatos_mac_java/study_assets_root/perceptualDiscrimination/img")

stimNames <- list.files(path=stimDir,pattern = "*.png|*.jpg|*.pdf")
saveStim <- "var test_stimuli = ["

counter<-0

## based on the stimulus name;
### assign correct response
### assign correct conditions
#### response keys are responseLeft and responseRight - set these in index.html. Ensure they relate to the correct response here. 

for (i in 1:length(values)){
  for (j in 1:ntrials){
    col <- ifelse(values[i]<.5, "blue", "orange")
    resp <- ifelse(values[i]<.5, "responseLeft", "responseRight")
    saveStim <- paste0(saveStim,paste0("{ stimulus: 'img/",col,"_",values[i],"_",j,".png', data: {test_part: 'test', cond: '",col,"', coherence: '",values[i], "',  correct_response: function(){return ", resp,"} } },"))
    counter = counter + 1
  }
}
saveStim <- paste(saveStim,"];",sep="")
saveStim

