# Reading in data provided by authors

pol_dat <- read.csv("raw_data/pol_dat16.csv")

# Cleaning data code provided by authors
# Make legislative professionalism logged for analyses

pol_dat$legprofscore <- log(pol_dat$legprofscore)
pol_dat$legprofscore_1993 <- log(pol_dat$legprofscore_1993)

# Recreating Table A.1: Summary Statistics of Key Variables

sumstat_dat <- data.frame(statistic = c("Legislative Polarization", "Term Limits","Divided Gov."
                                           ,"ln(Leg. Professionalism)","Party Competitiveness"),
                     mean = as.double(c(mean(pol_dat$l_diffs), mean(pol_dat$house_term_limit), mean(pol_dat$divided_gov), mean(pol_dat$legprofscore), mean(pol_dat$abs_diff))),
                     median = as.double(c(median(pol_dat$l_diffs), median(pol_dat$house_term_limit), median(pol_dat$divided_gov), median(pol_dat$legprofscore), median(pol_dat$abs_diff))),
                     min = as.double(c(min(pol_dat$l_diffs), min(pol_dat$house_term_limit), min(pol_dat$divided_gov), min(pol_dat$legprofscore), min(pol_dat$abs_diff))),
                     max = as.double(c(max(pol_dat$l_diffs), max(pol_dat$house_term_limit), max(pol_dat$divided_gov), max(pol_dat$legprofscore), max(pol_dat$abs_diff))),
                     sd = as.double(c(sd(pol_dat$l_diffs), sd(pol_dat$house_term_limit), sd(pol_dat$divided_gov), sd(pol_dat$legprofscore), sd(pol_dat$abs_diff))))

sumstat_gt <- sumstat_dat %>% 
  gt() %>% 
  tab_header("Table A.1: Summary Statistics of Key Variables") %>% 
  cols_label(statistic = "Statistic",
             mean = "Mean",
             median = "Median",
             min = "Min",
             max = "Max",
             sd = "St. Dev.") %>% 
 fmt_number(columns = 2:6, decimals = 3)

sumstat_sg_recreate <- stargazer(pol_dat[,c("l_diffs","house_term_limit","divided_gov",
                                   "legprofscore","abs_diff")],
                                 type = "text",
                        summary.stat=c("mean","median","min","max","sd"),
                        covariate.labels=c("Legislative Polarization","Term Limits","Divided Gov."
                                           ,"ln(Leg. Professionalism)","Party Competitiveness"),
                        title="Summary Statistics of Key Variables",
                        table.layout ="-c-b-",table.placement = "!ht",
                        label="summary_stats",
                        no.space = T,
                        out = "figures/sumstat_sg_recreate.txt")
  
  
sumstat_gt %>%
    gtsave("sumstat_gt.pdf", path = "figures", zoom = 0.3)
