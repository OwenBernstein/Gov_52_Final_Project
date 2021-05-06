# Model creation code provided by authors
# Table 1: Fixed Effects OLS Estimates: State Legislative Polarization and Term Limits ##############

pol_dat$term_limit_temp <- pol_dat$house_term_limit
pol_dat$temp_abs_diff   <- pol_dat$abs_diff

pooled_nocov <- felm(l_diffs~term_limit_temp
                     |state+year|0|state
                     ,data=pol_dat)

pooled_cov <- felm(l_diffs~term_limit_temp
                   +divided_gov
                   +legprofscore+temp_abs_diff
                   |state+year|0|state
                   ,data=pol_dat)

pol_dat$temp_abs_diff <- pol_dat$hs_abs_diff

house_nocov <- felm(h_diffs~term_limit_temp
                    |state+year|0|state
                    ,data=pol_dat)

house_cov <- felm(h_diffs~term_limit_temp
                  +divided_gov
                  +legprofscore+temp_abs_diff
                  |state+year|0|state
                  ,data=pol_dat)

pol_dat$term_limit_temp <- pol_dat$senate_term_limit
pol_dat$temp_abs_diff   <- pol_dat$sen_abs_diff

senate_nocov <- felm(s_diffs~term_limit_temp
                     |state+year|0|state
                     ,data=pol_dat)

senate_cov <- felm(s_diffs~term_limit_temp
                   +divided_gov
                   +legprofscore+temp_abs_diff
                   |state+year|0|state
                   ,data=pol_dat)

# Recreating Table 1: Term Limits and Polarization

panel_sg_recreate <- stargazer(pooled_nocov,pooled_cov,house_nocov,house_cov,senate_nocov,senate_cov,
                  type = "text",
                  add.lines = list(c("State Fixed Effects","Yes","Yes","Yes","Yes","Yes","Yes"),
                                   c("Year Fixed Effects","Yes","Yes","Yes","Yes","Yes","Yes"),
                                   c("Projected R Squared",round(summary(pooled_nocov)$P.r.squared,3),round(summary(pooled_cov)$P.r.squared,3)
                                     ,round(summary(house_nocov)$P.r.squared,3),round(summary(house_cov)$P.r.squared,3)
                                     ,round(summary(senate_nocov)$P.r.squared,3),round(summary(senate_cov)$P.r.squared,3))),
                  notes.append = FALSE,notes.label = "",
                  notes= "Note. Linear Regression Coeffcients with standard errors clustered on states in parentheses.",
                  omit.stat = c("rsq", "f", "ser","adj.rsq", "n"),font.size = "footnotesize",
                  star.char=c("*","**"),star.cutoffs = c(0.10,0.05),digits=3,digits.extra=0,
                  dep.var.caption="Polarization",table.placement = "!ht",
                  dep.var.labels = c("Pooled","House","Senate"),
                  covariate.labels=c("Term Limits","Divided Gov.",
                                     "ln(Leg. Professionalism)","Party Competitiveness"),
                  label="baseline_panel_analysis",
                  table.layout ="-ld-#-tas-n",
                  title="Term Limits and Polarization",
                  out = "figures/panel_sg_recreate.txt",
                  no.space = T)

# Model creation code provided by authors
# Table 2: Asymmetric Polarization and Term Limits ################################################

pol_dat$term_limit_temp <- pol_dat$house_term_limit
pol_dat$temp_abs_diff   <- pol_dat$abs_diff
pol_dat$temp_dem        <- pol_dat$dem_leg_median
pol_dat$temp_rep       <- pol_dat$rep_leg_median

dem_pooled <- felm(temp_dem~term_limit_temp
                   +divided_gov
                   +legprofscore+temp_abs_diff
                   |state+year|0|state
                   ,data=pol_dat)

rep_pooled <- felm(temp_rep~term_limit_temp
                   +divided_gov
                   +legprofscore+temp_abs_diff
                   |state+year|0|state
                   ,data=pol_dat)

pol_dat$temp_abs_diff <- pol_dat$hs_abs_diff
pol_dat$temp_dem        <- pol_dat$hou_dem
pol_dat$temp_rep       <- pol_dat$hou_rep

dem_house <- felm(temp_dem~term_limit_temp
                  +divided_gov
                  +legprofscore+temp_abs_diff
                  |state+year|0|state
                  ,data=pol_dat)

rep_house <- felm(temp_rep~term_limit_temp
                  +divided_gov
                  +legprofscore+temp_abs_diff
                  |state+year|0|state
                  ,data=pol_dat)

pol_dat$term_limit_temp <- pol_dat$senate_term_limit
pol_dat$temp_abs_diff   <- pol_dat$sen_abs_diff
pol_dat$temp_dem        <- pol_dat$sen_dem
pol_dat$temp_rep       <- pol_dat$sen_rep

dem_senate <- felm(temp_dem~term_limit_temp
                   +divided_gov
                   +legprofscore+temp_abs_diff
                   |state+year|0|state
                   ,data=pol_dat)

rep_senate <- felm(temp_rep~term_limit_temp
                   +divided_gov
                   +legprofscore+temp_abs_diff
                   |state+year|0|state
                   ,data=pol_dat)

# Recreating Table 2: Term Limits and Asymmetric Polarization: Party Medians

asym_sg_recreate <- stargazer(dem_pooled,dem_house,dem_senate,rep_pooled,rep_house,rep_senate,
                     type = "text",
                     add.lines = list(c("Chamber","Pooled","House","Senate","Pooled","House","Senate"),
                                      c("State Fixed Effects","Yes","Yes","Yes","Yes","Yes","Yes"),
                                      c("Year Fixed Effects","Yes","Yes","Yes","Yes","Yes","Yes"),
                                      c("Projected R Squared",round(summary(dem_pooled)$P.r.squared,3),round(summary(dem_house)$P.r.squared,3)
                                        ,round(summary(dem_senate)$P.r.squared,3),round(summary(rep_pooled)$P.r.squared,3)
                                        ,round(summary(rep_house)$P.r.squared,3),round(summary(rep_senate)$P.r.squared,3))),
                     notes.append = FALSE,notes.label = "",
                     notes="Entries are linear regression coefficients with standard errors clustered on states in parentheses.",
                     omit.stat = c("rsq", "f", "ser","adj.rsq"),font.size = "footnotesize",
                     star.char=c("*","**"),star.cutoffs = c(0.10,0.05),digits=3,digits.extra=0,
                     dep.var.labels=c("Democrats","Republicans"),
                     dep.var.caption = c("Party Medians"),table.placement = "!ht",
                     covariate.labels=c("Term Limits","Divided Gov.",
                                        "ln(Leg. Professionalism)","Party Competitiveness"),
                     label="asymmetric_polarization",
                     table.layout ="-ld-#-tas-n",
                     title="Term Limits and Asymmetric Polarization",
                     out = "figures/asym_sg_recreate.txt",
                     no.space = T)

# Model creation code provided by authors
# Table B.3: State Legislative Polarization and Term Limits: Additional Covariate Control

pol_dat$term_limit_temp <- pol_dat$house_term_limit
pol_dat$temp_abs_diff   <- pol_dat$abs_diff

ec_pooled_cov <- felm(l_diffs~term_limit_temp
                      +divided_gov
                      +legprofscore+temp_abs_diff
                      +gov_party
                      +logpop+pc_income
                      +unemploy
                      +pct_fb+gini
                      |state+year|0|state
                      ,data=pol_dat)

pol_dat$temp_abs_diff <- pol_dat$hs_abs_diff

ec_house_cov <- felm(h_diffs~term_limit_temp
                     +divided_gov
                     +legprofscore+temp_abs_diff
                     +gov_party
                     +logpop+pc_income
                     +unemploy
                     +pct_fb+gini
                     |state+year|0|state
                     ,data=pol_dat)

pol_dat$term_limit_temp <- pol_dat$senate_term_limit
pol_dat$temp_abs_diff   <- pol_dat$sen_abs_diff

ec_senate_cov <- felm(s_diffs~term_limit_temp
                      +divided_gov
                      +legprofscore+temp_abs_diff
                      +gov_party
                      +logpop+pc_income
                      +unemploy
                      +pct_fb+gini
                      |state+year|0|state
                      ,data=pol_dat)

# Recreating Table B.3: Term Limits and Polarization: Additional Covariate Control

extra_controls_sg_recreate <- stargazer(ec_pooled_cov,ec_house_cov,ec_senate_cov,
                                        type = "text",
                               add.lines = list(c("State Fixed Effects","Yes","Yes","Yes","Yes","Yes","Yes"),
                                                c("Year Fixed Effects","Yes","Yes","Yes","Yes","Yes","Yes"),
                                                c("Projected R Squared",round(summary(ec_pooled_cov)$P.r.squared,3)
                                                  ,round(summary(ec_house_cov)$P.r.squared,3)
                                                  ,round(summary(ec_senate_cov)$P.r.squared,3))),
                               notes.append = FALSE,notes.label = "",
                               notes="Entries are linear regression coefficients with standard errors clustered on states in parentheses.",
                               omit.stat = c("rsq", "f", "ser","adj.rsq"),font.size = "footnotesize",
                               star.char=c("*","**"),star.cutoffs = c(0.10,0.05),digits=3,digits.extra=0,
                               dep.var.caption="Polarization",table.placement = "!ht",
                               dep.var.labels = c("Pooled","House","Senate"),
                               covariate.labels=c("Term Limits","Divided Gov.","ln(Leg. Professionalism)","Party Competitiveness","Democratic Governor"
                                                  ,"ln(Population)","Per Capita Income","Unemployment Rate"
                                                  ,"Percent Foreign Born","State Gini Coefficient"),
                               label="extra_covariates",
                               table.layout ="-ld-#-t-as-n",
                               title="Term Limits and Polarization: Additional Covariate Control",
                               out = "figures/extra_controls_sg_recreate.txt",
                               no.space = T)
