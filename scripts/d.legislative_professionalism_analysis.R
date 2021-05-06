# Data provided by authors 

pol_dat <- read.csv("raw_data/pol_dat16.csv")

pol_dat$leg_expend <- pol_dat$leg_expend/1000
pol_dat$leg_realsalary <- pol_dat$leg_realsalary/1000
pol_dat$sess_length <- pol_dat$sess_length/100
pol_dat$loglegprof <- log(pol_dat$legprofscore)
pol_dat$logsess <- log(pol_dat$sess_length)
pol_dat$logsalary <- log(pol_dat$leg_realsalary+1)
pol_dat$logexpend <- log(pol_dat$leg_expend)
pol_dat$logbowen1 <- log(pol_dat$bowen_legprof_firstdim+abs(min(pol_dat$bowen_legprof_firstdim))+1)
pol_dat$logbowen2 <- log(pol_dat$bowen_legprof_seconddim+abs(min(pol_dat$bowen_legprof_seconddim))+1) 

log_legprof <- felm(l_diffs~house_term_limit*loglegprof
                    +divided_gov+
                      +abs_diff
                    |state+year|0|state
                    ,data=pol_dat)

# Data provided by authors

dime_cont <-   read.csv("raw_data/dime_contributions.csv")
dime_cont <- dime_cont[dime_cont$state!="NE",]

# Model code provided by authors
# Table 3: Term Limits, Legislative Professionalism, and Party Influence  

pc_legprof <- felm(pc_share~house_term_limit*loglegprof
                   +divided_gov
                   +abs_diff
                   |state+year|0|state,data=dime_cont)

pac_legprof <- felm(pac_share~house_term_limit*loglegprof
                    +divided_gov
                    +abs_diff
                    |state+year|0|state,data=dime_cont)



# Recreating Table 3: Term Limits, Legislative Professionalism, and Party Influence  

mech_prof_sg_recreate <- stargazer(log_legprof,pc_legprof,pac_legprof,
                          type = "text",
                          keep=c("house_term_limit","loglegprof"),
                          add.lines = list(c("Controls","Yes","Yes","Yes"),
                                           c("State Fixed Effects","Yes","Yes","Yes","Yes"),
                                           c("Year Fixed Effects","Yes","Yes","Yes","Yes"),
                                           c("Projected R Squared",round(summary(log_legprof)$P.r.squared,3)
                                             ,paste(as.character(round(summary(pc_legprof)$P.r.squared,3)),"0",sep="")
                                             ,paste(as.character(round(summary(pac_legprof)$P.r.squared,3)),"0",sep=""))),
                          notes.append = FALSE,notes.label = "",
                          notes="",
                          star.char=c("*","**"),star.cutoffs = c(0.10,0.05),
                          omit.stat = c("rsq", "f", "ser","adj.rsq"),font.size = "footnotesize",
                          digits=3,digits.extra=0,
                          dep.var.labels = c("Pooled Polarization","Party Share Contributions",
                                             "PAC Share Contributions"),
                          covariate.labels=c("Term Limits","ln(Leg. Professionalism)",
                                             "Term Limits X ln(Professionalism)"),table.placement = "!ht",
                          label="mechanisms_panel",
                          table.layout ="-ld-#-tas-n",
                          title="Term Limits, Legislative Professionalism, and Party Influence",
                          out = "figures/mech_prof_sg_recreate.txt",
                          no.space = T)
                          




# Recreating Figure 1: Effect of Term Limits over Legislative Professionalism

logout <- continuous_margeff_plot(model=log_legprof,base_coef="house_term_limit",
                                  moderating_coef="loglegprof",data=pol_dat,
                                  pretty_mod = "Logged Legislative Professionalism") +
  labs(title = "Effect of Term Limits over Legislative Professionalism",
       y = "Marginal Effect of Term Limits on Political Polarization")

ggsave("figures/logout.pdf")
