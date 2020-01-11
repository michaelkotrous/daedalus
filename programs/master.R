# Set working directory to match path to daedalus project
setwd("/path/to/daedalus")

# Create directory to write output if it does not exist
dir.create("exports", showWarnings = FALSE)

# Run R scripts to load and clean NTSB dataset
source("programs/config/settings.R")
source("programs/config/data-cleanup.R")
source("programs/config/dataframes.R")

# Aggregate statistics, run tests, and export csvs for analysis
## csv output files will be written to the exports directory
source("programs/tests/accident-timeseries.R")
source("programs/tests/occurrence-code-percentages.R")
source("programs/tests/timeseries-autocorrelations.R")
source("programs/tests/accident-activity-change-correlations.R")
source("programs/tests/fatality-top5counts.R")
source("programs/tests/fatalityrate-coderate-change-correlations.R")
source("programs/tests/dickey-fuller.R")
source("programs/tests/cointegration.R")
source("programs/tests/durbinwatson.R")
source("programs/tests/chisquare.R")
