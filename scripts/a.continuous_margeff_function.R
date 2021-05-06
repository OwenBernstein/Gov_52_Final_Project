###################################################################################################
# Legislative Term Limits and Polarization ########################################################
# Marginal Effects Plot Function ##################################################################
# Michael Olson and Jon Rogowski ##################################################################
###################################################################################################

# This script creates a function to generate marginal effects plots from interactive felm models
# The function is an adapted version of code provided by Anton Strezhnev 
# (https://www.antonstrezhnev.com/software/)

###################################################################################################
# Function ########################################################################################
###################################################################################################
  
  continuous_margeff_plot <- function(model,base_coef,moderating_coef,data,pretty_mod){
  
  coefs <- coef(model)
  beta_chair <- coefs[base_coef]
  beta_int <- coefs[paste(base_coef,moderating_coef,sep=":")]
  xlb <- min(data[,moderating_coef],na.rm=TRUE)
  xub <- max(data[,moderating_coef],na.rm=TRUE)
  xvals <- as.data.frame(seq(from=xlb,to=xub,by=(xub-xlb)/1000))
  marg_eff <- function(z){
    return(beta_chair + z*beta_int)
  }
  marg_eff_out <- marg_eff(xvals)
  dat <- as.data.frame(cbind(xvals,marg_eff_out))
  colnames(dat) <- c("xvals","marg_eff")
  vcov_beta_chair <- model$clustervcv[base_coef,base_coef]
  vcov_beta_int   <- model$clustervcv[paste(base_coef,moderating_coef,sep=":"),paste(base_coef,moderating_coef,sep=":")]
  vcov_beta_int_chair <- model$clustervcv[base_coef,paste(base_coef,moderating_coef,sep=":")]
  
  marg_eff_var <- function(z){
    return(vcov_beta_chair+z^2*vcov_beta_int + 2*z*vcov_beta_int_chair)
  }
  
  dat$marg_eff_var_vals <- marg_eff_var(dat$xvals)
  
  marg_eff_95CI_lb <- function(z,x){
    return(z - qnorm(.975)*sqrt(x))
  }
  
  dat$lb <- marg_eff_95CI_lb(z=dat$marg_eff,x=dat$marg_eff_var_vals)
  
  marg_eff_95CI_ub <- function(z,x){
    return(z + qnorm(.975)*sqrt(x))
  }
  
  dat$ub <- marg_eff_95CI_ub(z=dat$marg_eff,x=dat$marg_eff_var_vals)
  dat$lb <- marg_eff_95CI_lb(z=dat$marg_eff,x=dat$marg_eff_var_vals)
  
  plot <- ggplot(data=dat,aes(x=xvals,y=marg_eff)) +
    geom_hline(yintercept=0,colour="indianred",linetype=2,size=1)+
    geom_smooth(linetype=1,colour="black") +
    geom_smooth(aes(x=xvals,y=lb),linetype=3,colour="black",size=1) +
    geom_smooth(aes(x=xvals,y=ub),linetype=3,colour="black",size=1) +
    xlab(pretty_mod)+
    ylab("Marginal Effect")+
    theme_minimal()+
    geom_rug(data=data,aes_string(x=moderating_coef,y=),sides="b",inherit.aes = F)+
    theme(plot.margin=unit(c(1,1,1,1),"cm")) +
    theme(axis.title.y=element_text(margin=margin(0,20,0,0)))
  
  return(plot)
  
  }
