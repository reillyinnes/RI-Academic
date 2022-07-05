rm(list=ls())

# library(pmwg)
setwd("~/Documents/Research/Amsterdam/Code")

source("pmwg/variants/standard.R")
library(TruncatedNormal)
library(openintro)

data <- fastfood[,1:13]
names(data)[1]<-"subject"
data <- data[c(1,3:13)]
data <- na.omit(data)
data[,c(2,3,7,8)]<- data[,c(2,3,7,8)]/100


## plots

par(mfrow=c(4,3))
apply(data[,-1], 2, hist, main = NULL)
dev.off()


### likelihood
ll <- function(x, data, sample = F ){
  x=exp(x)
  if(sample){
    n_pars = length(x)
    Restaurant = data[,1]
    tmpData = as.matrix(data[,-1])
    out = TruncatedNormal::rtmvnorm(nrow(tmpData), x, diag(1, nrow = n_pars), lb = rep(0,n_pars))
    out <- as.data.frame(cbind(out,Restaurant))
    return(out)
  }else{
    n_pars = length(x)
    tmpData = as.matrix(data[,-1])
    out = sum(TruncatedNormal::dtmvnorm(tmpData, x, diag(1, nrow = n_pars), lb = rep(0,n_pars), log = T, B = 1))
    return(out)
  }
  
}

pars=names(data)[-1]


priors <- list(
  theta_mu_mean = rep(0, length(pars)),
  theta_mu_var = diag(rep(10, length(pars)))) 


# Create the Particle Metropolis within Gibbs sampler object ------------------

sampler <- pmwgs(
  data = data,
  pars = pars,
  prior = priors,
  ll_func = ll
)

sampler <- init(sampler) # i don't use any start points here

sampled <- run_stage(sampler, stage = "burn",iter = 50, particles = 50, n_cores = 4, pstar=.6) #epsion will set automatically to 0.5
sampled <- run_stage(sampled, stage = "adapt",iter = 250, particles = 50, n_cores = 4, pstar=.6) 
sampled <- run_stage(sampled, stage = "sample",iter = 100, particles = 30, n_cores = 4, pstar=.6) 


#### Inference


tmp <- sampled
matplot(t(tmp$samples$theta_mu),type="l")
matplot(t(tmp$samples$subj_ll),type="l")

tmp2 <- apply(tmp$samples$theta_mu[,tmp$samples$stage=="sample"],1,median)
exp(tmp2)
tmp2 <- apply(tmp$samples$alpha[,,tmp$samples$stage=="sample"],1:2, median)
round(exp(tmp2),3)

cov<-apply(tmp$samples$theta_var[,,tmp$samples$stage=="sample"],1:2, median)
colnames(cov)<-tmp$par_names
rownames(cov)<-tmp$par_names
cor<-cov2cor(cov) #correlation matrix
library(corrplot)
corrplot(cor, method="circle", type = "lower", title = "Parameter Correlations", tl.col = "black",mar=c(0,0,2,0))
