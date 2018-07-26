# Analysis in R
The R code above reflects the analyses performed by Koopman and Kotrous in a 2018 working paper, currently available on SSRN. All the R code used in that paper can be executed after changing the second line of `master.R` to set R's working directory to match the path to your clone of the Daedalus project, assuming the following R libraries, as well as their dependencies, are installed.

Dependencies:

* chron
* Hmisc
* dplyr
* lmtest

The config directory has R scripts that load dependencies and clean the exported dataset in order to correct issues introduced by filtering the exported dataset to only include U.S.-registered, Part 91 airplanes. Further, the config files create a data frame that produces annual counts of Part 91 accidents and fatalities from 1983 through 2015. It also includes four activity measures for estimating trends in accident rates and fatality rates.

The test directory includes the specific tests run in Koopman and Kotrous (2018). These can be used to replicate the results therein, or modified to run tests of your own. In addition, you can write brand new tests!
