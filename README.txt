##########################################################################
# Owen Bernstein Gov 52 Final Project ####################################
# Replication of Term Limits and Legislative Polarization#################
# by Michael P. Olson and Jon Rogowski ###################################
##########################################################################

# Overview ###############################################################

The data in this project is obtained from the Harvard Dataverse at
https://doi.org/10.7910/DVN/GDZTK8. The data is provided by Michael P. Olson and
Jon Rogowski as part of their replication materials for their paper "Term Limits
and Legislative Polarization". 

Much of the code and the folders is also obtained through the Harvard Dataverse
as part of the replication material. 

The file Gov-52-Final-Project.Rmd can be used to run all of the fils in the project. 
It produces a pdf document with a summary of the "Term Limits and Legislative
Polarization," replication analysis, an extension of the paper, a conclusion,
and a bibliography. 


# Contents ###############################################################

    # Scripts

	1) "a.continuous_margeff_function"
	  This script is provided by Michael P. Olson and Jon Rogowski
	  as part of their replication files. 
		This script contains a function to create marginal effects
		plots. The function is an adapted version of code provided
		by Anton Strezhnev (https://www.antonstrezhnev.com/software/)

	3) "b.summary_statistics.R"
		This script generates results presented in the recreation of
		Table A.1. It loads and cleans data, and then presents
		summary statistics of key variables in a gt table and a
		stargzaer plot. 

	4) "c.main_analysis.R"
		This script generates results presented in the recreation of
		Table 1, Table 2, and Table B.3. It creates various models
		and presents the results as stargazer plots. 

	5) "d.legislative_professionalism_analysis.R"
		This script generates results presented in Table 3 and Figure 1.
		It creates various models and figures and presents them as
		stargazer plots and ggplots. 
		
  6) "e.extension_analysis.R"
    This script generates results presented in Table 4 and Table 5.
    It creates new models using lagged data and regional data. 
		
# Packages and Computational Environment##################################
	
R version 4.0.2 (2020-06-22) -- "Taking Off Again"

To run this code the following packages are required:

tidyverse
webshot
gt
readstata13
foreign
data.table
tidyr
stringi
stringr
dplyr
multiwayvcov
lmtest
stargazer
ggplot2
DataCombine
lfe
Matching
