# Reloading data provided by authors

pol_dat <- read.csv("raw_data/pol_dat16.csv")

# Cleaning data code provided by authors
# Make legislative professionalism logged for analyses

pol_dat$legprofscore <- log(pol_dat$legprofscore)
pol_dat$legprofscore_1993 <- log(pol_dat$legprofscore_1993)

# Adding region variable to data

northeast <- c("CT", "DE", "MA", "ME", "NH", "NJ", "NY", "PA", "RI", "VT")
south <-c("AL", "AR", "FL", "GA", "KY", "LA", "MD", "MS", "NC", "OK", "SC", "TN", "TX", "VA", "WV")
midwest<- c("IA", "IL", "IN", "KS", "MI", "MN", "MO", "ND", "OH", "SD", "WI")
west <- c("AK", "AZ", "CA", "CO", "HI", "ID", "MT", "NM", "NV", "OR", "UT", "WA", "WY")

pol_dat <- pol_dat %>% 
  mutate(region = ifelse(state %in% northeast, "Northeast", 
                         ifelse(state %in% south, "South", 
                                ifelse(state %in% midwest, "Midwest", "West"))))

# Creating models with region

pol_dat$term_limit_temp <- pol_dat$house_term_limit
pol_dat$temp_abs_diff   <- pol_dat$abs_diff

pooled_nocov <- felm(l_diffs~term_limit_temp
                            |state+year|0|state
                            ,data=pol_dat)

pooled_nocov_region <- felm(l_diffs~term_limit_temp
                     |state+year+region|0|state
                     ,data=pol_dat)


pol_dat$temp_abs_diff <- pol_dat$hs_abs_diff

house_nocov <- felm(h_diffs~term_limit_temp
                    |state+year|0|state
                    ,data=pol_dat)

house_nocov_region <- felm(h_diffs~term_limit_temp
                    |state+year+region|0|state
                    ,data=pol_dat)

pol_dat$term_limit_temp <- pol_dat$senate_term_limit
pol_dat$temp_abs_diff   <- pol_dat$sen_abs_diff

senate_nocov <- felm(s_diffs~term_limit_temp
                     |state+year|0|state
                     ,data=pol_dat)

senate_nocov_region <- felm(s_diffs~term_limit_temp
                     |state+year+region|0|state
                     ,data=pol_dat)

# Creating Table 4: region fixed effects

panel_region_sg_recreate <- stargazer(pooled_nocov,pooled_nocov_region,house_nocov,house_nocov_region,senate_nocov,senate_nocov_region,
                               type = "text",
                               add.lines = list(c("State Fixed Effects","Yes","Yes","Yes","Yes","Yes","Yes"),
                                                c("Year Fixed Effects","Yes","Yes","Yes","Yes","Yes","Yes"),
                                                c("Region Fixed Effects", "No", "Yes", "No", "Yes", "No", "Yes"),
                                                c("Projected R Squared",round(summary(pooled_nocov)$P.r.squared,3),round(summary(pooled_nocov_region)$P.r.squared,3)
                                                  ,round(summary(house_nocov)$P.r.squared,3),round(summary(house_nocov_region)$P.r.squared,3)
                                                  ,round(summary(senate_nocov)$P.r.squared,3),round(summary(senate_nocov_region)$P.r.squared,3))),
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
                               out = "figures/panel_region_sg_recreate.txt",
                               no.space = T)

# Reloading original data frame

pol_dat <- read.csv("raw_data/pol_dat16.csv")

pol_dat$legprofscore <- log(pol_dat$legprofscore)
pol_dat$legprofscore_1993 <- log(pol_dat$legprofscore_1993)

# Lagging term limit variable by 4 years

lag_dat <- pol_dat %>% 
  group_by(state) %>% 
  arrange(year, .by_group = T) %>% 
  mutate(lag_term_limit = lag(house_term_limit, 4))
  
lag_dat$lag_term_limit[is.na(lag_dat$lag_term_limit)] = 0
  
# Creating models with lagged data

lag_dat$term_limit_temp <- lag_dat$house_term_limit
lag_dat$temp_abs_diff   <- lag_dat$abs_diff

pooled_nocov <- felm(l_diffs~term_limit_temp
                     |state+year|0|state
                     ,data=lag_dat)

pooled_cov <- felm(l_diffs~term_limit_temp
                   +divided_gov
                   +legprofscore+temp_abs_diff
                   |state+year|0|state
                   ,data=lag_dat)

lag_dat$term_limit_temp <- lag_dat$lag_term_limit

pooled_nocov_lag <- felm(l_diffs~term_limit_temp
                     |state+year|0|state
                     ,data=lag_dat)

pooled_cov_lag <- felm(l_diffs~term_limit_temp
                   +divided_gov
                   +legprofscore+temp_abs_diff
                   |state+year|0|state
                   ,data=lag_dat)

# Creating Table 5: Lagged polarization

panel_lag_sg_recreate <- stargazer(pooled_nocov,pooled_nocov_lag,pooled_cov,pooled_cov_lag,
                                      type = "text",
                                      add.lines = list(c("State Fixed Effects","Yes","Yes","Yes","Yes"),
                                                       c("Year Fixed Effects","Yes","Yes","Yes","Yes"),
                                                       c("Lag", "No", "Yes", "No", "Yes"),
                                                       c("Projected R Squared",round(summary(pooled_nocov)$P.r.squared,3),round(summary(pooled_nocov_lag)$P.r.squared,3)
                                                         ,round(summary(pooled_cov)$P.r.squared,3),round(summary(pooled_cov_lag)$P.r.squared,3))),
                                      notes.append = FALSE,notes.label = "",
                                      notes= "Note. Linear Regression Coeffcients with standard errors clustered on states in parentheses.",
                                      omit.stat = c("rsq", "f", "ser","adj.rsq", "n"),font.size = "footnotesize",
                                      star.char=c("*","**"),star.cutoffs = c(0.10,0.05),digits=3,digits.extra=0,
                                      dep.var.caption="Polarization",table.placement = "!ht",
                                      dep.var.labels = c("Pooled"),
                                      covariate.labels=c("Term Limits","Divided Gov.",
                                                         "ln(Leg. Professionalism)","Party Competitiveness"),
                                      label="baseline_panel_analysis",
                                      table.layout ="-ld-#-tas-n",
                                      title="Term Limits and Polarization",
                                      out = "figures/panel_lag_sg_recreate.txt",
                                      no.space = T)
