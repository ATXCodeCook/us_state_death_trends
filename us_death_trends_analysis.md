---
title: "Analysis of U.S. National Disease Death Trends (2014-2021)"
author: "Patrick Cook"
date: "8/13/2021"
output: 
  html_document:
    # df_print: paged
    keep_md: True
---






**Note**: Initial data sets were cleaned and merged prior to this analysis. The 
original data sets' structure and cleaning steps may be found in the file 
[us_state_death_trends_wrangling](us_state_death_trends_wrangling.Rmd).

## Introduction and Objectives

This report explores the Center for Disease Control's (CDC) Weekly Morbidity and 
Mortality data from 2014 through the **------>1st quarter of 2021<--------**. 
**This data analysis is focused on National level weekly death counts for specific 
causes at the United States**. A 2nd report will analyze specific state and local 
regions. The data is voluntary and not guaranteed to be reported in a timely or 
regular basis. Therefore, the most recent data (quarter) will be may be 
incomplete and unreliable for analysis and insights. 

More information on the original data sets can be found at CDC's website using 
the following links: 

- [2014-2015 MMWR Data Set](https://data.cdc.gov/NCHS/Weekly-Counts-of-Deaths-by-State-and-Select-Causes/3yf8-kanr){target="_blank"}
- [2020-2021 MMWR Data Set](https://data.cdc.gov/NCHS/Weekly-Provisional-Counts-of-Deaths-by-State-and-S/muzy-jte6){target="_blank"}

**Note**: The most current data can be downloaded using the links above. To use the 
data sets without any code modifications, the user will need to:

1. Place the data two sets in a subdirectory named "data", and
2. Rename the data sets as "weekly_2014_2019" and "weekly_2020_2021."

## Data Structure

### Observations and features  

#### First three observations (chronologically) of the data set.  


```r
us_deaths_df <- mmwr_1421_df[Location == "United States", ]

# Dropping unused levels (only United States occurs). 
us_deaths_df$Location <- droplevels(us_deaths_df$Location)


head(us_deaths_df, 3)
```

```
##         Location Year Week Week_End_Date Natural Heart Cancer Lower_Respiratory
## 1: United States 2014    1    2014-01-04   50189 13166  11244              3331
## 2: United States 2014    2    2014-01-11   52450 13663  11504              3444
## 3: United States 2014    3    2014-01-18   51043 12928  11496              3333
##    Brain Alzheimer Diabetes Covid_19_Multi Covid_19 Influenza_Pneumonia Kidney
## 1:  2669      1780     1654              0        0                1639    965
## 2:  2738      1917     1735              0        0                1910   1098
## 3:  2714      1914     1660              0        0                1920   1056
##    Other_Respiratory Septicemia Abnormal_Finding
## 1:               756        882              679
## 2:               845        905              665
## 3:               812        919              598
```

#### Last three observations (chronologically) of the data set.  


```r
tail(us_deaths_df, 3)
```

```
##         Location Year Week Week_End_Date Natural Heart Cancer Lower_Respiratory
## 1: United States 2021   27    2021-07-10   46047 10299  10230              2207
## 2: United States 2021   28    2021-07-17   41596  9006   9258              2144
## 3: United States 2021   29    2021-07-24   31341  6715   6927              1611
##    Brain Alzheimer Diabetes Covid_19_Multi Covid_19 Influenza_Pneumonia Kidney
## 1:  2534      1801     1364           1377     1134                 614    874
## 2:  2314      1689     1246           1472     1259                 544    745
## 3:  1737      1333      880           1418     1255                 370    544
##    Other_Respiratory Septicemia Abnormal_Finding
## 1:               794        639             3417
## 2:               650        566             3180
## 3:               443        406             2506
```


```r
str(us_deaths_df)
```

```
## Classes 'data.table' and 'data.frame':	395 obs. of  18 variables:
##  $ Location           : Factor w/ 1 level "United States": 1 1 1 1 1 1 1 1 1 1 ...
##  $ Year               : int  2014 2014 2014 2014 2014 2014 2014 2014 2014 2014 ...
##  $ Week               : int  1 2 3 4 5 6 7 8 9 10 ...
##  $ Week_End_Date      : Date, format: "2014-01-04" "2014-01-11" ...
##  $ Natural            : int  50189 52450 51043 50560 50402 49790 50175 49010 47907 48353 ...
##  $ Heart              : int  13166 13663 12928 12813 12896 12681 12984 12577 12248 12318 ...
##  $ Cancer             : int  11244 11504 11496 11629 11584 11355 11477 11478 11251 11535 ...
##  $ Lower_Respiratory  : int  3331 3444 3333 3467 3283 3351 3303 3047 3008 3043 ...
##  $ Brain              : int  2669 2738 2714 2720 2699 2684 2669 2799 2630 2529 ...
##  $ Alzheimer          : int  1780 1917 1914 1862 1867 1873 1843 1814 1776 1830 ...
##  $ Diabetes           : int  1654 1735 1660 1602 1586 1643 1642 1564 1588 1536 ...
##  $ Covid_19_Multi     : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ Covid_19           : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ Influenza_Pneumonia: int  1639 1910 1920 1765 1642 1528 1472 1269 1228 1215 ...
##  $ Kidney             : int  965 1098 1056 1029 998 1038 1021 973 1018 1040 ...
##  $ Other_Respiratory  : int  756 845 812 753 720 728 739 731 687 760 ...
##  $ Septicemia         : int  882 905 919 845 890 849 851 708 779 777 ...
##  $ Abnormal_Finding   : int  679 665 598 622 664 641 638 643 595 642 ...
##  - attr(*, ".internal.selfref")=<externalptr>
```



After preprocessing and cleaning, the United States (U.S.) subset of data used 
in this analysis accounts for 395 observations and 18 features which includes 
categorical location data, chronological date and week of year information, and 
integer weekly disease death data. The earliest week is the 1st week of January 
2014. The most current as of this analysis is the week ending January 24, 2021. 
Next, is the  data set's summary statistics in the U.S. subset.


#### Summary statistics  


```r
summary(us_deaths_df)
```

```
##           Location        Year           Week       Week_End_Date       
##  United States:395   Min.   :2014   Min.   : 1.00   Min.   :2014-01-04  
##                      1st Qu.:2015   1st Qu.:13.00   1st Qu.:2015-11-24  
##                      Median :2017   Median :25.00   Median :2017-10-14  
##                      Mean   :2017   Mean   :25.79   Mean   :2017-10-14  
##                      3rd Qu.:2019   3rd Qu.:39.00   3rd Qu.:2019-09-03  
##                      Max.   :2021   Max.   :53.00   Max.   :2021-07-24  
##     Natural          Heart           Cancer      Lower_Respiratory
##  Min.   :31341   Min.   : 6715   Min.   : 6927   Min.   :1611     
##  1st Qu.:46298   1st Qu.:11607   1st Qu.:11276   1st Qu.:2614     
##  Median :49094   Median :12380   Median :11429   Median :2838     
##  Mean   :50551   Mean   :12426   Mean   :11420   Mean   :2939     
##  3rd Qu.:53174   3rd Qu.:13174   3rd Qu.:11606   3rd Qu.:3261     
##  Max.   :81615   Max.   :16020   Max.   :12408   Max.   :4373     
##      Brain        Alzheimer       Diabetes    Covid_19_Multi     Covid_19    
##  Min.   :1737   Min.   :1333   Min.   : 880   Min.   :    0   Min.   :    0  
##  1st Qu.:2631   1st Qu.:2045   1st Qu.:1484   1st Qu.:    0   1st Qu.:    0  
##  Median :2792   Median :2228   Median :1603   Median :    0   Median :    0  
##  Mean   :2803   Mean   :2237   Mean   :1641   Mean   : 1533   Mean   : 1384  
##  3rd Qu.:2981   3rd Qu.:2454   3rd Qu.:1765   3rd Qu.:    0   3rd Qu.:    0  
##  Max.   :3535   Max.   :3212   Max.   :2442   Max.   :25889   Max.   :23825  
##  Influenza_Pneumonia     Kidney       Other_Respiratory   Septicemia    
##  Min.   : 370.0      Min.   : 544.0   Min.   : 443.0    Min.   : 406.0  
##  1st Qu.: 765.5      1st Qu.: 904.5   1st Qu.: 724.0    1st Qu.: 709.0  
##  Median : 865.0      Median : 961.0   Median : 781.0    Median : 748.0  
##  Mean   :1022.1      Mean   : 970.5   Mean   : 791.4    Mean   : 764.5  
##  3rd Qu.:1182.0      3rd Qu.:1034.0   3rd Qu.: 854.0    3rd Qu.: 818.5  
##  Max.   :2930.0      Max.   :1239.0   Max.   :1086.0    Max.   :1066.0  
##  Abnormal_Finding
##  Min.   : 494.0  
##  1st Qu.: 593.0  
##  Median : 624.0  
##  Mean   : 716.7  
##  3rd Qu.: 670.0  
##  Max.   :3477.0
```

```r
describeBy(us_deaths_df)
```

```
## Warning in FUN(newX[, i], ...): no non-missing arguments to min; returning Inf
```

```
## Warning in FUN(newX[, i], ...): no non-missing arguments to max; returning -Inf
```

```
## Warning in describeBy(us_deaths_df): no grouping variable requested
```

```
##                     vars   n     mean      sd median  trimmed     mad   min
## Location*              1 395     1.00    0.00      1     1.00    0.00     1
## Year                   2 395  2017.29    2.20   2017  2017.27    2.97  2014
## Week                   3 395    25.79   15.03     25    25.62   19.27     1
## Week_End_Date          4 395      NaN      NA     NA      NaN      NA   Inf
## Natural                5 395 50551.41 6567.18  49094 49545.39 4797.69 31341
## Heart                  6 395 12426.04 1095.40  12380 12379.48 1177.18  6715
## Cancer                 7 395 11419.98  356.34  11429 11437.35  241.66  6927
## Lower_Respiratory      8 395  2939.15  406.34   2838  2908.45  403.27  1611
## Brain                  9 395  2803.38  248.69   2792  2797.75  260.94  1737
## Alzheimer             10 395  2237.14  319.19   2228  2235.93  302.45  1333
## Diabetes              11 395  1640.81  220.23   1603  1620.73  195.70   880
## Covid_19_Multi        12 395  1533.48 4352.95      0   345.79    0.00     0
## Covid_19              13 395  1384.39 3973.19      0   299.17    0.00     0
## Influenza_Pneumonia   14 395  1022.06  395.16    865   956.96  209.05   370
## Kidney                15 395   970.46   89.79    961   967.35   96.37   544
## Other_Respiratory     16 395   791.41   99.95    781   787.38   94.89   443
## Septicemia            17 395   764.54   80.70    748   758.90   75.61   406
## Abnormal_Finding      18 395   716.66  402.14    624   633.19   54.86   494
##                       max range  skew kurtosis     se
## Location*               1     0   NaN      NaN   0.00
## Year                 2021     7  0.04    -1.20   0.11
## Week                   53    52  0.08    -1.18   0.76
## Week_End_Date        -Inf  -Inf    NA       NA     NA
## Natural             81615 50274  2.11     6.37 330.43
## Heart               16020  9305  0.11     1.61  55.12
## Cancer              12408  5481 -5.65    65.50  17.93
## Lower_Respiratory    4373  2762  0.62     0.00  20.45
## Brain                3535  1798  0.12     0.41  12.51
## Alzheimer            3212  1879  0.08     0.10  16.06
## Diabetes             2442  1562  0.92     1.44  11.08
## Covid_19_Multi      25889 25889  3.58    13.42 219.02
## Covid_19            23825 23825  3.62    13.68 199.91
## Influenza_Pneumonia  2930  2560  1.90     4.40  19.88
## Kidney               1239   695  0.14     0.76   4.52
## Other_Respiratory    1086   643  0.34     0.12   5.03
## Septicemia           1066   660  0.54     1.28   4.06
## Abnormal_Finding     3477  2983  5.15    27.70  20.23
```


