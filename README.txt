##########################################################################
# Term Limits and Legislative Polarization ###############################
# Replication Files ######################################################
# Michael P. Olson and Jon Rogowski ######################################
##########################################################################

# Overview ###############################################################

	This file contains all data and codes needed to reproduce the
	results from the text and supplementary materials for "Term Limits 
	and Legislative Polarization" by Michael P. Olson and Jon Rogowski.

# Notes ##################################################################

	This replication package contains the final datasets and code used 
	to generate results presented in the text and supplementary 
	materials. Those wishing the code and data to create the final 
	datasets should contact Michael Olson at michaelolson@g.harvard.edu.

	The replication package is designed to be easily run by opening
	and running only two files. 

	The first is "a.central_analysis_file.R." This file installs 
	(if necessary) and loads all required packages and then
	runs in order the files that conduct the paper's analyses. With careful
	attention to working directories, the analysis files can all be run 
	independently as well, with one exception: the results in Table 3
	and Table C.3 depend on results produced in separate scripts, 
	"f.legprof_interactions.R" and "g.dime_campaign_finance_analysis.R",
	with the results output from the latter file. These files should
	therefore both be run together, in that order.

	A file, "ca_analysis.do," must be run using Stata to replicate
	the analysis presented in Table C.2 in the supplementary materials.

# Contents ###############################################################

    # Scripts

	1) "a.central_analysis_file.R"
		This script sets the working directory, installs and loads
		required R packages, loads a function to make marginal
		effects plots, and then runs each of the analysis R scripts.
		To reproduce all results, appropriately setting the 
		working directory in this file and then running this script
		should result in all results being output in the 
		termlimits_polarization_ouput subfolder.

	2) "b.continuous_margeff_function.R"
		This script contains a function to create marginal effects
		plots. The function is an adapted version of code provided
		by Anton Strezhnev (https://www.antonstrezhnev.com/software/)

	3) "c.aggregate_analysis_2016.R"
		This script generates results presented in Tables 1 and 2
		in the text, and Tables A.1, B.1, B.2, B.3, B.4, B.5, B.6,
		B.10, B.11, and Figures A.1, B.1 and B.2, in the 
		supplementary materials.

	4) "d.dime_aggregate_analysis.R"
		This script generates results presented in Table B.7 in 
		the supplementary materials.

	5) "e.competitiveness_analysis.R"
		This script generates results presented in Table C.5 in the
		supplementary materials.

	6) "f.legprof_interactions.R"
		This script generates results presented in Figure 1A and Table 3
		in the text and Figure C.1 and Tables C.3 and C.4 in the 
		supplementary materials. 		

	7) "g.dime_campaign_finance_analysis.R"
		This script generates results presented in Figure 1B and Table 3
		in the text and Table C.3 in the supplementary materials.
		

	8) "h.individual_leadership_analysis.R"
		This script generates results presented in Table B.9 in the 
		supplementary materials.

	9) "i.individual_margdist_analysis.R"
		This script generates results presented in Table B.8 in the 
		supplementary materials.

	10) "j.individual_sm_analysis.R"
		This script generates results presented in Table C.1 in the 
		supplementary materials. 

	11) "k.ca_analysis.do"
		This script produces results presented in Table C.2 in the 
		supplementary materials.

    # Data

	1) "pol_dat16.csv"
		Contains the state-level data (with Shor and McCarty-based 
		polarization measures) used for most analyses. Omits state-
		years without polarization measures for both chambers. Omits
		Nebraska.

	2) "pol_dat_wNE_16.csv"
		Identical to "pol_dat16.csv", but retains Nebraska for 
		robustness checks.		

	3) "pol_dat_formatch16.csv"
		Identical to "pol_dat16.csv", but retains all years to use
		covariates for matching.

	4) "dime_aggregate.csv"
		Contains state-level estimates of legislative polarization
		based on campaign finance data (Bonica), merged with covariates

	5) "dime_contributions.csv"
		Contains state-level estimates of the share of campaign
		contributions coming from party organizations and PACs,
		merged with covariates.

	6) "sle_aggregate.csv"
		Contains state-year estimates of the share of state legislative
		races that were "close," merged with covariates.

	7) "shor_mccarty_individual.csv"
		Contains individual-level Shor-McCarty ideology scores, merged
		with covariates.

	8) "leadership_only.csv"
		Contains individual-level Shor-McCarty ideology scores, linked
		with data on individual leadership status.

	9) "sle_sm_dat.csv"
		Similar to "leadership_only.csv", but also merged with state
		legislative election returns.

	10) "Masket roll call estimates.dta"
		DW-NOMINATE estimates for members of the California assembly.

