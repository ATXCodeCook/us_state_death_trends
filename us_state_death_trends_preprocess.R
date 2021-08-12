
# Install packages
pacman::p_load(pacman, data.table, dplyr, tidyr, knitr, ggplot2, psych, cowplot, 
               corrplot, stringr, Hmisc, RColorBrewer)

# -----------------------------------------------------------------------------
# -------------- Set color palettes and sorting/helper variables --------------
# -----------------------------------------------------------------------------

# Diverging Palette: Modified from Brewer"Dark2", "Set1" and "Paired" palettes.
mycolors <- c("#1B9E77", "#D95F02", "#7570B3", "#E7298A", "#00aaff", "#E6AB02", 
              "#A6761D", "#666666", "#E41A1C", "#377EB8", "#4DAF4A", "#984EA3", 
              "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999", "#66A61E", 
              "#B2DF8A", "#33A02C", "#FB9A99", "#E31A1C", "#FDBF6F", "#FF7F00", 
              "#CAB2D6", "#6A3D9A", "#FFFF99", "#B15928")

# create list of system greys (every other shade)
mygreycolors <- sprintf('grey%s', seq(0, 100, 2))

# Order string years [add current years as included]
ordered_years <- c("2014", "2015", "2016",
                   "2017", "2018", "2019", "2020", "2021")

# Some years are given 53 weeks in the year (usually leap years)
ordered_weeks <- seq(1:53)

# Order of states and special regions by population, greatest to least.
# Used for viewing states with similar population sizes and graphic ordering
state_by_pop <- c("California", "Texas", "Florida", "New York", "Pennsylvania", 
                  "Illinois", "Ohio", "Georgia", "North Carolina", "Michigan", 
                  "New Jersey", "Virginia", "New York City", "Washington", 
                  "Arizona", "Massachusetts", "Tennessee", "Indiana", 
                  "Missouri", "Maryland", "Wisconsin", "Colorado", "Minnesota", 
                  "South Carolina", "Alabama", "Louisiana", "Kentucky", 
                  "Oregon", "Oklahoma", "Connecticut", "Utah", "Puerto Rico", 
                  "Iowa", "Nevada", "Arkansas", "Mississippi", "Kansas", 
                  "New Mexico", "Nebraska", "West Virginia", "Idaho", "Hawaii", 
                  "New Hampshire", "Maine", "Montana", "Rhode Island", 
                  "Delaware", "South Dakota", "North Dakota", "Alaska", 
                  "District of Columbia", "Vermont", "Wyoming"
                  )

# End helper Variables


# -----------------------------------------------------------------------------
# --------------------------------- Functions ---------------------------------
# -----------------------------------------------------------------------------



# End Functions



# import data sets (included in data folder)

tmp_mmwr_1419_df = read.csv("data/weekly_2014_2019.csv",
                   header = TRUE,
                   stringsAsFactors = FALSE)

tmp_mmwr_2021_df = read.csv("data/weekly_2020_2021.csv",
                   header = TRUE,
                   stringsAsFactors = FALSE)

# Verify flag column entries are only 'Suppressed (counts1-9)' privacy flags.
unique(unlist(select(tmp_mmwr_1419_df, contains('flag'))))
unique(unlist(select(tmp_mmwr_2021_df, contains('flag'))))

# Differences in feature names of two data sets

tmp_col_list_1419 <- colnames(tmp_mmwr_1419_df)
tmp_col_list_2021 <- colnames(tmp_mmwr_2021_df)


# Dropping flag columns

tmp_mmwr_1419_df <- select(tmp_mmwr_1419_df,
                           -contains(c('flag', 'All.')))

tmp_mmwr_2021_df <- select(tmp_mmwr_2021_df, 
                           -contains(c('flag', 'Data.As.Of', 'All.')))

# Rename feature list to more readable and analysis-friendly names

col_list <- c('Location', 'Year', 'Week', 'Week_End_Date', 'Natural', 
              'Septicemia', 'Cancer', 'Diabetes', 'Alzheimer', 
              'Influenza_Pneumonia', 'Lower_Respiratory', 'Other_Respiratory', 
              'Kidney', 'Abnormal_Finding', 'Heart', 'Brain', 'Covid_19_Multi', 
              'Covid_19')

# Add Covid-19 features filled with 0 and update feature names for 2014-19 data
tmp_mmwr_1419_df[col_list[17:18]] <- 0
colnames(tmp_mmwr_1419_df) <- col_list

# Update feature names for 2014-19 data
colnames(tmp_mmwr_2021_df) <- col_list

# Change data types and formatting for dates
tmp_mmwr_1419_df$Week_End_Date <- as.Date(tmp_mmwr_1419_df$Week_End_Date,
                                          format='%m/%d/%Y')

tmp_mmwr_2021_df$Week_End_Date <- as.Date(tmp_mmwr_2021_df$Week_End_Date,
                                          format='%Y-%m-%d')


# Merge data sets, clean global environment and confirm changes

if (exists("tmp_mmwr_1419_df") && exists("tmp_mmwr_2021_df")) {
  
  # Merge data sets into data.table
  mmwr_1421_df <- rbindlist(list(tmp_mmwr_1419_df, tmp_mmwr_2021_df))
  
  # Change Location to factors
  mmwr_1421_df$Location <- as.factor(mmwr_1421_df$Location)

  # Remove temporary data frames, environmental variables
  rm(list = ls(pattern = "^tmp_"))
}

# Create ordered causes of death vector from greatest to least.

# Initial order of disease columns
tmp_char_vector <- c('Natural', 'Septicemia', 'Cancer', 'Diabetes', 
                           'Alzheimer', 'Influenza_Pneumonia', 
                           'Lower_Respiratory', 'Other_Respiratory', 'Kidney', 
                           'Abnormal_Finding', 'Heart', 'Brain', 
                           'Covid_19_Multi', 'Covid_19')

# Get means of National disease deaths counts
# Order diseases from greatest deaths to least and add to col_list
deaths_ordered <- tmp_char_vector[rev(
                                  order(
                                  colMeans(
                                   mmwr_1421_df[Location == 'United States',
                                                Natural:Covid_19],
                                   na.rm=TRUE)))]

col_list <- c('Location', 'Year', 'Week', 'Week_End_Date', deaths_ordered)

rm(list = ls(pattern = "^tmp"))

# reorder table by col_list (most significant deaths to least)
mmwr_1421_df <- mmwr_1421_df[ , col_list, with = FALSE]

# Export cleaned data set
write.csv(mmwr_1421_df,
          "data\\processed_data\\mmwr_1421_df.csv",
          row.names = FALSE)

