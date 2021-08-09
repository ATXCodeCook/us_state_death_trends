## Yearly and Quarterly Trends in U.S. States' Deaths (2014-2021)

### Introduction and Objectives

This report explores the Center for Disease Control's (CDC) Weekly Morbidity and 
Mortality data from 2014 through the 1st quarter of 2021. 
The data includes weekly death counts for specific causes in the United States. 
The data also includes weekly death counts for individual states and specific 
areas such as New York City, Puerto Rico and Washington, D.C. The data is 
voluntary and not guaranteed to be reported in a timely or regular basis. 
Therefore, the most recent weeks data will be incomplete and unreliable for analysis 
and insights. More information on the data set can be found at CDC's website 
using the following links: 

- [2014-2015 MMWR Data Set](https://data.cdc.gov/NCHS/Weekly-Counts-of-Deaths-by-State-and-Select-Causes/3yf8-kanr){target="_blank"}
- [2020-2021 MMWR Data Set](https://data.cdc.gov/NCHS/Weekly-Provisional-Counts-of-Deaths-by-State-and-S/muzy-jte6){target="_blank"}

#### Objective

The objective of the project is to analyze state level weekly cause of death 
data available from the Centers for Disease Control (CDC) to identify specific 
diseases with the highest **growth** in deaths so that it may be used to redirect 
financial, material and human resources to reducing the number of deaths in the disease category.

#### Analysis and Recommendations
The analysis and recommendations are found at the bottom of the document in the 
"Analysis and Recommendations" section. The sections preceeding the Analysis and 
Recommendations section are for analysis of the data sets structure, limitations 
and patterns. The analysis shown is based on specific states or special regions of 
interest.  This locations may be changed by changing the parameters of the functions 
used to generate the plots (see examples below):

year_trend_boxplot(**'New York City'**,**c('Natural', 'Heart')**)

state_cause_yearly_compare(**'New York City'**,**c('Natural')**)

qtr_significance_boxplots(**'New York City'**,**c('Natural', 'Heart')**)


See function descriptions in the header of the .rmd file for further details of these functions.

