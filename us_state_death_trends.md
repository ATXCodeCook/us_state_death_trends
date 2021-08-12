---
title: "U.S. States' Disease Death Trends (2014-2021)"
author: "Patrick Cook"
date: "7/21/2021"
output: 
  html_document:
    # df_print: paged
    keep_md: True
---








### Introduction and Objectives

This report explores the Center for Disease Control's (CDC) Weekly Morbidity and 
Mortality data from 2014 through the 1st quarter of 2021. 
The data includes weekly death counts for specific causes in the United States. 
The data also includes weekly death counts for individual states and specific 
areas such as New York City, Puerto Rico and Washington, D.C. The data is 
voluntary and not guaranteed to be reported in a timely or regular basis. 
Therefore, the most recent data (quarter) will be incomplete and unreliable for 
analysis and insights. More information on the data set can be found at CDC's 
website using the following links: 

- [2014-2015 MMWR Data Set](https://data.cdc.gov/NCHS/Weekly-Counts-of-Deaths-by-State-and-Select-Causes/3yf8-kanr){target="_blank"}
- [2020-2021 MMWR Data Set](https://data.cdc.gov/NCHS/Weekly-Provisional-Counts-of-Deaths-by-State-and-S/muzy-jte6){target="_blank"}

Note: The most current data can be downloaded using the links above. To use the 
data sets without any code modifications, the user will need to:

1. Place the data two sets in a subdirectory named "data", and
2. Rename the data sets as "weekly_2014_2019" and "weekly_2020_2021."





#### Objective

The objective of the project is to analyze national and state level weekly cause
of death data available from the Centers for Disease Control (CDC) to identify 
specific diseases with the highest **growth** in deaths so that the information
may guide long-term and short-term planning. This planning will allow healthcare
systems to redirect resources, reducing financial, material, facility and labor 
cost wastage as well as identifying and addressing the cause for the increased 
deaths before the disease becomes a leading contributor of deaths.

### Initial Data Structure Exploration


```
## 'data.frame':	16902 obs. of  30 variables:
##  $ Jurisdiction.of.Occurrence                                                                       : chr  "United States" "United States" "United States" "United States" ...
##  $ MMWR.Year                                                                                        : int  2014 2014 2014 2014 2014 2014 2014 2014 2014 2014 ...
##  $ MMWR.Week                                                                                        : int  1 2 3 4 5 6 7 8 9 10 ...
##  $ Week.Ending.Date                                                                                 : chr  "01/04/2014" "01/11/2014" "01/18/2014" "01/25/2014" ...
##  $ All..Cause                                                                                       : int  54065 56353 54769 54223 54074 53484 53910 52752 51768 52163 ...
##  $ Natural.Cause                                                                                    : int  50189 52450 51043 50560 50402 49790 50175 49010 47907 48353 ...
##  $ Septicemia..A40.A41.                                                                             : int  882 905 919 845 890 849 851 708 779 777 ...
##  $ Malignant.neoplasms..C00.C97.                                                                    : int  11244 11504 11496 11629 11584 11355 11477 11478 11251 11535 ...
##  $ Diabetes.mellitus..E10.E14.                                                                      : int  1654 1735 1660 1602 1586 1643 1642 1564 1588 1536 ...
##  $ Alzheimer.disease..G30.                                                                          : int  1780 1917 1914 1862 1867 1873 1843 1814 1776 1830 ...
##  $ Influenza.and.pneumonia..J10.J18.                                                                : int  1639 1910 1920 1765 1642 1528 1472 1269 1228 1215 ...
##  $ Chronic.lower.respiratory.diseases..J40.J47.                                                     : int  3331 3444 3333 3467 3283 3351 3303 3047 3008 3043 ...
##  $ Other.diseases.of.respiratory.system..J00.J06.J30.J39.J67.J70.J98.                               : int  756 845 812 753 720 728 739 731 687 760 ...
##  $ Nephritis..nephrotic.syndrome.and.nephrosis..N00.N07.N17.N19.N25.N27.                            : int  965 1098 1056 1029 998 1038 1021 973 1018 1040 ...
##  $ Symptoms..signs.and.abnormal.clinical.and.laboratory.findings..not.elsewhere.classified..R00.R99.: int  679 665 598 622 664 641 638 643 595 642 ...
##  $ Diseases.of.heart..I00.I09.I11.I13.I20.I51.                                                      : int  13166 13663 12928 12813 12896 12681 12984 12577 12248 12318 ...
##  $ Cerebrovascular.diseases..I60.I69.                                                               : int  2669 2738 2714 2720 2699 2684 2669 2799 2630 2529 ...
##  $ flag_allcause                                                                                    : logi  NA NA NA NA NA NA ...
##  $ flag_natcause                                                                                    : logi  NA NA NA NA NA NA ...
##  $ flag_sept                                                                                        : chr  "" "" "" "" ...
##  $ flag_neopl                                                                                       : chr  "" "" "" "" ...
##  $ flag_diab                                                                                        : chr  "" "" "" "" ...
##  $ flag_alz                                                                                         : chr  "" "" "" "" ...
##  $ flag_inflpn                                                                                      : chr  "" "" "" "" ...
##  $ flag_clrd                                                                                        : chr  "" "" "" "" ...
##  $ flag_otherresp                                                                                   : chr  "" "" "" "" ...
##  $ flag_nephr                                                                                       : chr  "" "" "" "" ...
##  $ flag_otherunk                                                                                    : chr  "" "" "" "" ...
##  $ flag_hd                                                                                          : chr  "" "" "" "" ...
##  $ flag_stroke                                                                                      : chr  "" "" "" "" ...
```


```
## 'data.frame':	4428 obs. of  35 variables:
##  $ Data.As.Of                                                                                       : chr  "08/04/2021" "08/04/2021" "08/04/2021" "08/04/2021" ...
##  $ Jurisdiction.of.Occurrence                                                                       : chr  "United States" "United States" "United States" "United States" ...
##  $ MMWR.Year                                                                                        : int  2020 2020 2020 2020 2020 2020 2020 2020 2020 2020 ...
##  $ MMWR.Week                                                                                        : int  1 2 3 4 5 6 7 8 9 10 ...
##  $ Week.Ending.Date                                                                                 : chr  "2020-01-04" "2020-01-11" "2020-01-18" "2020-01-25" ...
##  $ All.Cause                                                                                        : int  60201 60735 59362 59162 58835 59491 58814 58912 59334 59695 ...
##  $ Natural.Cause                                                                                    : int  55026 55754 54517 54399 54002 54414 53970 53987 54314 54387 ...
##  $ Septicemia..A40.A41.                                                                             : int  844 863 831 830 813 810 794 781 819 814 ...
##  $ Malignant.neoplasms..C00.C97.                                                                    : int  11567 11961 11701 11879 11963 11704 11807 11780 11789 11711 ...
##  $ Diabetes.mellitus..E10.E14.                                                                      : int  1829 1942 1819 1865 1828 1957 1848 1880 1831 1867 ...
##  $ Alzheimer.disease..G30.                                                                          : int  2537 2566 2491 2517 2480 2515 2537 2515 2519 2511 ...
##  $ Influenza.and.pneumonia..J09.J18.                                                                : int  1559 1528 1483 1488 1411 1464 1513 1461 1507 1608 ...
##  $ Chronic.lower.respiratory.diseases..J40.J47.                                                     : int  3503 3709 3526 3403 3314 3413 3478 3454 3460 3469 ...
##  $ Other.diseases.of.respiratory.system..J00.J06.J30.J39.J67.J70.J98.                               : int  1068 1035 992 979 981 974 978 968 1011 1002 ...
##  $ Nephritis..nephrotic.syndrome.and.nephrosis..N00.N07.N17.N19.N25.N27.                            : int  1094 1092 1121 1107 1074 1135 1070 1058 1092 1071 ...
##  $ Symptoms..signs.and.abnormal.clinical.and.laboratory.findings..not.elsewhere.classified..R00.R99.: int  635 650 615 641 621 601 621 614 680 659 ...
##  $ Diseases.of.heart..I00.I09.I11.I13.I20.I51.                                                      : int  14212 13911 13591 13610 13464 14004 13638 13628 13711 13683 ...
##  $ Cerebrovascular.diseases..I60.I69.                                                               : int  3110 3188 3257 3185 3083 3056 3089 3083 3126 3097 ...
##  $ COVID.19..U071..Multiple.Cause.of.Death.                                                         : int  0 1 2 2 1 2 2 6 9 37 ...
##  $ COVID.19..U071..Underlying.Cause.of.Death.                                                       : int  0 1 1 1 0 1 0 6 9 33 ...
##  $ flag_allcause                                                                                    : chr  "" "" "" "" ...
##  $ flag_natcause                                                                                    : chr  "" "" "" "" ...
##  $ flag_sept                                                                                        : chr  "" "" "" "" ...
##  $ flag_neopl                                                                                       : chr  "" "" "" "" ...
##  $ flag_diab                                                                                        : chr  "" "" "" "" ...
##  $ flag_alz                                                                                         : chr  "" "" "" "" ...
##  $ flag_inflpn                                                                                      : chr  "" "" "" "" ...
##  $ flag_clrd                                                                                        : chr  "" "" "" "" ...
##  $ flag_otherresp                                                                                   : chr  "" "" "" "" ...
##  $ flag_nephr                                                                                       : chr  "" "" "" "" ...
##  $ flag_otherunk                                                                                    : chr  "" "" "" "" ...
##  $ flag_hd                                                                                          : chr  "" "" "" "" ...
##  $ flag_stroke                                                                                      : chr  "" "" "" "" ...
##  $ flag_cov19mcod                                                                                   : chr  "" "" "" "" ...
##  $ flag_cov19ucod                                                                                   : chr  "" "" "" "" ...
```


```
##   Jurisdiction.of.Occurrence MMWR.Year MMWR.Week Week.Ending.Date All..Cause
## 1              United States      2014         1       01/04/2014      54065
## 2              United States      2014         2       01/11/2014      56353
## 3              United States      2014         3       01/18/2014      54769
##   Natural.Cause Septicemia..A40.A41. Malignant.neoplasms..C00.C97.
## 1         50189                  882                         11244
## 2         52450                  905                         11504
## 3         51043                  919                         11496
##   Diabetes.mellitus..E10.E14. Alzheimer.disease..G30.
## 1                        1654                    1780
## 2                        1735                    1917
## 3                        1660                    1914
##   Influenza.and.pneumonia..J10.J18.
## 1                              1639
## 2                              1910
## 3                              1920
##   Chronic.lower.respiratory.diseases..J40.J47.
## 1                                         3331
## 2                                         3444
## 3                                         3333
##   Other.diseases.of.respiratory.system..J00.J06.J30.J39.J67.J70.J98.
## 1                                                                756
## 2                                                                845
## 3                                                                812
##   Nephritis..nephrotic.syndrome.and.nephrosis..N00.N07.N17.N19.N25.N27.
## 1                                                                   965
## 2                                                                  1098
## 3                                                                  1056
##   Symptoms..signs.and.abnormal.clinical.and.laboratory.findings..not.elsewhere.classified..R00.R99.
## 1                                                                                               679
## 2                                                                                               665
## 3                                                                                               598
##   Diseases.of.heart..I00.I09.I11.I13.I20.I51.
## 1                                       13166
## 2                                       13663
## 3                                       12928
##   Cerebrovascular.diseases..I60.I69. flag_allcause flag_natcause flag_sept
## 1                               2669            NA            NA          
## 2                               2738            NA            NA          
## 3                               2714            NA            NA          
##   flag_neopl flag_diab flag_alz flag_inflpn flag_clrd flag_otherresp flag_nephr
## 1                                                                              
## 2                                                                              
## 3                                                                              
##   flag_otherunk flag_hd flag_stroke
## 1                                  
## 2                                  
## 3
```

```
##   Data.As.Of Jurisdiction.of.Occurrence MMWR.Year MMWR.Week Week.Ending.Date
## 1 08/04/2021              United States      2020         1       2020-01-04
## 2 08/04/2021              United States      2020         2       2020-01-11
## 3 08/04/2021              United States      2020         3       2020-01-18
##   All.Cause Natural.Cause Septicemia..A40.A41. Malignant.neoplasms..C00.C97.
## 1     60201         55026                  844                         11567
## 2     60735         55754                  863                         11961
## 3     59362         54517                  831                         11701
##   Diabetes.mellitus..E10.E14. Alzheimer.disease..G30.
## 1                        1829                    2537
## 2                        1942                    2566
## 3                        1819                    2491
##   Influenza.and.pneumonia..J09.J18.
## 1                              1559
## 2                              1528
## 3                              1483
##   Chronic.lower.respiratory.diseases..J40.J47.
## 1                                         3503
## 2                                         3709
## 3                                         3526
##   Other.diseases.of.respiratory.system..J00.J06.J30.J39.J67.J70.J98.
## 1                                                               1068
## 2                                                               1035
## 3                                                                992
##   Nephritis..nephrotic.syndrome.and.nephrosis..N00.N07.N17.N19.N25.N27.
## 1                                                                  1094
## 2                                                                  1092
## 3                                                                  1121
##   Symptoms..signs.and.abnormal.clinical.and.laboratory.findings..not.elsewhere.classified..R00.R99.
## 1                                                                                               635
## 2                                                                                               650
## 3                                                                                               615
##   Diseases.of.heart..I00.I09.I11.I13.I20.I51.
## 1                                       14212
## 2                                       13911
## 3                                       13591
##   Cerebrovascular.diseases..I60.I69. COVID.19..U071..Multiple.Cause.of.Death.
## 1                               3110                                        0
## 2                               3188                                        1
## 3                               3257                                        2
##   COVID.19..U071..Underlying.Cause.of.Death. flag_allcause flag_natcause
## 1                                          0                            
## 2                                          1                            
## 3                                          1                            
##   flag_sept flag_neopl flag_diab flag_alz flag_inflpn flag_clrd flag_otherresp
## 1                                                                             
## 2                                                                             
## 3                                                                             
##   flag_nephr flag_otherunk flag_hd flag_stroke flag_cov19mcod flag_cov19ucod
## 1                                                                           
## 2                                                                           
## 3
```


```
## [1] NA                        ""                       
## [3] "Suppressed (counts 1-9)"
```

```
## [1] ""                        "Suppressed (counts 1-9)"
```

#### Feature name differences


```
## [1] "---- Columns in 2014-2019 data missing from 2020-2021 data"
```

```
## [1] "All..Cause"                        "Influenza.and.pneumonia..J10.J18."
```


```
## [1] "---- Columns in 2020-2021 data missing from 2014-2019 data"
```

```
## [1] "Data.As.Of"                                
## [2] "All.Cause"                                 
## [3] "Influenza.and.pneumonia..J09.J18."         
## [4] "COVID.19..U071..Multiple.Cause.of.Death."  
## [5] "COVID.19..U071..Underlying.Cause.of.Death."
## [6] "flag_cov19mcod"                            
## [7] "flag_cov19ucod"
```


#### Observations above

1.  The 2014-2019 data set has 16,902 records with 30 features. The 2020-2021 
data contains 4,428 records with 35 features. The difference in features is due 
to the addition of two Covid-19 categories in the 2020-2021 data set.

2. Both data sets have flag columns that identify weekly death counts that are 
from 1 to 9 deaths that have been redacted due to privacy issues. The records 
with missing values are currently all due to the privacy flag. These flags 
columns are not needed for the analysis of growth rates and will be dropped. The
missing values will not be replaced due to the influence a zero or interpolated 
value would have on statistical calculations and patterns seen in plots. The 
missing values do still have value in that they indicate a positive weekly death 
count below 10. 

2. Both data sets contain coded feature names based on International Classification 
of Diseases (ICD-10) that will be renamed to shorter names based on affected 
organ or two word disease name.

3. The dates in both data sets are listed as characters and are not in the 
global standard format. Data type will be changed and put into ISO 8601 format.

4. The jurisdictions will be renamed to "Location" and changed to a factor.

5. Influenza.and.pneumonia has and additional ICD-10 code (J09) in the 2020-2021
data. ICD-10 code J09 was added for classifying specific strains of Influenza.

6. Data.As.Of exists in the 2020-2021 data set and is used to track updates. The
update information is a last update and not an indication of record completeness 
therefore this feature will be dropped. 

7. All..Cause vs All.Cause is a typing difference. This includes non-disease 
deaths and will not be used in the analysis. Therefore, the column will be 
removed.

8. Other features such as year and week may be changed to ordered factors as 
needed.

Both data sets will be merged after changing column names to more consistent 
names (# 2 above) and formatting (# 3 above). The data will be viewed 
chronologically after merging to look for inconsistencies in the data. 


### Cleaning and Wrangling





```
##         Location Year Week Week_End_Date Natural Septicemia Cancer Diabetes
## 1: United States 2014    1    2014-01-04   50189        882  11244     1654
## 2: United States 2014    2    2014-01-11   52450        905  11504     1735
## 3: United States 2014    3    2014-01-18   51043        919  11496     1660
##    Alzheimer Influenza_Pneumonia Lower_Respiratory Other_Respiratory Kidney
## 1:      1780                1639              3331               756    965
## 2:      1917                1910              3444               845   1098
## 3:      1914                1920              3333               812   1056
##    Abnormal_Finding Heart Brain Covid_19_Multi Covid_19
## 1:              679 13166  2669              0        0
## 2:              665 13663  2738              0        0
## 3:              598 12928  2714              0        0
```


```
##  [1] "Natural"             "Heart"               "Cancer"             
##  [4] "Lower_Respiratory"   "Brain"               "Alzheimer"          
##  [7] "Diabetes"            "Covid_19_Multi"      "Covid_19"           
## [10] "Influenza_Pneumonia" "Kidney"              "Other_Respiratory"  
## [13] "Septicemia"          "Abnormal_Finding"
```

```
##         Location Year Week Week_End_Date Natural Heart Cancer Lower_Respiratory
## 1: United States 2014    1    2014-01-04   50189 13166  11244              3331
## 2: United States 2014    2    2014-01-11   52450 13663  11504              3444
## 3: United States 2014    3    2014-01-18   51043 12928  11496              3333
## 4: United States 2014    4    2014-01-25   50560 12813  11629              3467
## 5: United States 2014    5    2014-02-01   50402 12896  11584              3283
## 6: United States 2014    6    2014-02-08   49790 12681  11355              3351
##    Brain Alzheimer Diabetes Covid_19_Multi Covid_19 Influenza_Pneumonia Kidney
## 1:  2669      1780     1654              0        0                1639    965
## 2:  2738      1917     1735              0        0                1910   1098
## 3:  2714      1914     1660              0        0                1920   1056
## 4:  2720      1862     1602              0        0                1765   1029
## 5:  2699      1867     1586              0        0                1642    998
## 6:  2684      1873     1643              0        0                1528   1038
##    Other_Respiratory Septicemia Abnormal_Finding
## 1:               756        882              679
## 2:               845        905              665
## 3:               812        919              598
## 4:               753        845              622
## 5:               720        890              664
## 6:               728        849              641
```

