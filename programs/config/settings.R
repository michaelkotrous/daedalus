# Load data and library dependencies
accidentdata <- read.table("aircraft-GAaccidents-final.csv", sep=",", header=T, na.strings="NULL")
library(chron)
library(Hmisc)
library(dplyr)
library(lmtest)
library(urca)

# Set variables used across test
top5codes <- c("250", "240", "230", "350", "220")
activity_fields <- c("_per_private10k_diff", "_per_avgas10k_diff", "_per_hours100k_diff", "_per_pilots10k_diff")
activity_levels <- c("_per_private10k", "_per_avgas10k", "_per_hours100k", "_per_pilots10k")