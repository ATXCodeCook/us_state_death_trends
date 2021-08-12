---
title: "U.S. States' Disease Death Trends (2014-2021)"
author: "Patrick Cook"
date: "7/21/2021"
output: 
  html_document:
    df_print: paged
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

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":[""],"name":["_rn_"],"type":[""],"align":["left"]},{"label":["Jurisdiction.of.Occurrence"],"name":[1],"type":["chr"],"align":["left"]},{"label":["MMWR.Year"],"name":[2],"type":["int"],"align":["right"]},{"label":["MMWR.Week"],"name":[3],"type":["int"],"align":["right"]},{"label":["Week.Ending.Date"],"name":[4],"type":["chr"],"align":["left"]},{"label":["All..Cause"],"name":[5],"type":["int"],"align":["right"]},{"label":["Natural.Cause"],"name":[6],"type":["int"],"align":["right"]},{"label":["Septicemia..A40.A41."],"name":[7],"type":["int"],"align":["right"]},{"label":["Malignant.neoplasms..C00.C97."],"name":[8],"type":["int"],"align":["right"]},{"label":["Diabetes.mellitus..E10.E14."],"name":[9],"type":["int"],"align":["right"]},{"label":["Alzheimer.disease..G30."],"name":[10],"type":["int"],"align":["right"]},{"label":["Influenza.and.pneumonia..J10.J18."],"name":[11],"type":["int"],"align":["right"]},{"label":["Chronic.lower.respiratory.diseases..J40.J47."],"name":[12],"type":["int"],"align":["right"]},{"label":["Other.diseases.of.respiratory.system..J00.J06.J30.J39.J67.J70.J98."],"name":[13],"type":["int"],"align":["right"]},{"label":["Nephritis..nephrotic.syndrome.and.nephrosis..N00.N07.N17.N19.N25.N27."],"name":[14],"type":["int"],"align":["right"]},{"label":["Symptoms..signs.and.abnormal.clinical.and.laboratory.findings..not.elsewhere.classified..R00.R99."],"name":[15],"type":["int"],"align":["right"]},{"label":["Diseases.of.heart..I00.I09.I11.I13.I20.I51."],"name":[16],"type":["int"],"align":["right"]},{"label":["Cerebrovascular.diseases..I60.I69."],"name":[17],"type":["int"],"align":["right"]},{"label":["flag_allcause"],"name":[18],"type":["lgl"],"align":["right"]},{"label":["flag_natcause"],"name":[19],"type":["lgl"],"align":["right"]},{"label":["flag_sept"],"name":[20],"type":["chr"],"align":["left"]},{"label":["flag_neopl"],"name":[21],"type":["chr"],"align":["left"]},{"label":["flag_diab"],"name":[22],"type":["chr"],"align":["left"]},{"label":["flag_alz"],"name":[23],"type":["chr"],"align":["left"]},{"label":["flag_inflpn"],"name":[24],"type":["chr"],"align":["left"]},{"label":["flag_clrd"],"name":[25],"type":["chr"],"align":["left"]},{"label":["flag_otherresp"],"name":[26],"type":["chr"],"align":["left"]},{"label":["flag_nephr"],"name":[27],"type":["chr"],"align":["left"]},{"label":["flag_otherunk"],"name":[28],"type":["chr"],"align":["left"]},{"label":["flag_hd"],"name":[29],"type":["chr"],"align":["left"]},{"label":["flag_stroke"],"name":[30],"type":["chr"],"align":["left"]}],"data":[{"1":"United States","2":"2014","3":"1","4":"01/04/2014","5":"54065","6":"50189","7":"882","8":"11244","9":"1654","10":"1780","11":"1639","12":"3331","13":"756","14":"965","15":"679","16":"13166","17":"2669","18":"NA","19":"NA","20":"","21":"","22":"","23":"","24":"","25":"","26":"","27":"","28":"","29":"","30":"","_rn_":"1"},{"1":"United States","2":"2014","3":"2","4":"01/11/2014","5":"56353","6":"52450","7":"905","8":"11504","9":"1735","10":"1917","11":"1910","12":"3444","13":"845","14":"1098","15":"665","16":"13663","17":"2738","18":"NA","19":"NA","20":"","21":"","22":"","23":"","24":"","25":"","26":"","27":"","28":"","29":"","30":"","_rn_":"2"},{"1":"United States","2":"2014","3":"3","4":"01/18/2014","5":"54769","6":"51043","7":"919","8":"11496","9":"1660","10":"1914","11":"1920","12":"3333","13":"812","14":"1056","15":"598","16":"12928","17":"2714","18":"NA","19":"NA","20":"","21":"","22":"","23":"","24":"","25":"","26":"","27":"","28":"","29":"","30":"","_rn_":"3"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div><div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":[""],"name":["_rn_"],"type":[""],"align":["left"]},{"label":["Data.As.Of"],"name":[1],"type":["chr"],"align":["left"]},{"label":["Jurisdiction.of.Occurrence"],"name":[2],"type":["chr"],"align":["left"]},{"label":["MMWR.Year"],"name":[3],"type":["int"],"align":["right"]},{"label":["MMWR.Week"],"name":[4],"type":["int"],"align":["right"]},{"label":["Week.Ending.Date"],"name":[5],"type":["chr"],"align":["left"]},{"label":["All.Cause"],"name":[6],"type":["int"],"align":["right"]},{"label":["Natural.Cause"],"name":[7],"type":["int"],"align":["right"]},{"label":["Septicemia..A40.A41."],"name":[8],"type":["int"],"align":["right"]},{"label":["Malignant.neoplasms..C00.C97."],"name":[9],"type":["int"],"align":["right"]},{"label":["Diabetes.mellitus..E10.E14."],"name":[10],"type":["int"],"align":["right"]},{"label":["Alzheimer.disease..G30."],"name":[11],"type":["int"],"align":["right"]},{"label":["Influenza.and.pneumonia..J09.J18."],"name":[12],"type":["int"],"align":["right"]},{"label":["Chronic.lower.respiratory.diseases..J40.J47."],"name":[13],"type":["int"],"align":["right"]},{"label":["Other.diseases.of.respiratory.system..J00.J06.J30.J39.J67.J70.J98."],"name":[14],"type":["int"],"align":["right"]},{"label":["Nephritis..nephrotic.syndrome.and.nephrosis..N00.N07.N17.N19.N25.N27."],"name":[15],"type":["int"],"align":["right"]},{"label":["Symptoms..signs.and.abnormal.clinical.and.laboratory.findings..not.elsewhere.classified..R00.R99."],"name":[16],"type":["int"],"align":["right"]},{"label":["Diseases.of.heart..I00.I09.I11.I13.I20.I51."],"name":[17],"type":["int"],"align":["right"]},{"label":["Cerebrovascular.diseases..I60.I69."],"name":[18],"type":["int"],"align":["right"]},{"label":["COVID.19..U071..Multiple.Cause.of.Death."],"name":[19],"type":["int"],"align":["right"]},{"label":["COVID.19..U071..Underlying.Cause.of.Death."],"name":[20],"type":["int"],"align":["right"]},{"label":["flag_allcause"],"name":[21],"type":["chr"],"align":["left"]},{"label":["flag_natcause"],"name":[22],"type":["chr"],"align":["left"]},{"label":["flag_sept"],"name":[23],"type":["chr"],"align":["left"]},{"label":["flag_neopl"],"name":[24],"type":["chr"],"align":["left"]},{"label":["flag_diab"],"name":[25],"type":["chr"],"align":["left"]},{"label":["flag_alz"],"name":[26],"type":["chr"],"align":["left"]},{"label":["flag_inflpn"],"name":[27],"type":["chr"],"align":["left"]},{"label":["flag_clrd"],"name":[28],"type":["chr"],"align":["left"]},{"label":["flag_otherresp"],"name":[29],"type":["chr"],"align":["left"]},{"label":["flag_nephr"],"name":[30],"type":["chr"],"align":["left"]},{"label":["flag_otherunk"],"name":[31],"type":["chr"],"align":["left"]},{"label":["flag_hd"],"name":[32],"type":["chr"],"align":["left"]},{"label":["flag_stroke"],"name":[33],"type":["chr"],"align":["left"]},{"label":["flag_cov19mcod"],"name":[34],"type":["chr"],"align":["left"]},{"label":["flag_cov19ucod"],"name":[35],"type":["chr"],"align":["left"]}],"data":[{"1":"08/04/2021","2":"United States","3":"2020","4":"1","5":"2020-01-04","6":"60201","7":"55026","8":"844","9":"11567","10":"1829","11":"2537","12":"1559","13":"3503","14":"1068","15":"1094","16":"635","17":"14212","18":"3110","19":"0","20":"0","21":"","22":"","23":"","24":"","25":"","26":"","27":"","28":"","29":"","30":"","31":"","32":"","33":"","34":"","35":"","_rn_":"1"},{"1":"08/04/2021","2":"United States","3":"2020","4":"2","5":"2020-01-11","6":"60735","7":"55754","8":"863","9":"11961","10":"1942","11":"2566","12":"1528","13":"3709","14":"1035","15":"1092","16":"650","17":"13911","18":"3188","19":"1","20":"1","21":"","22":"","23":"","24":"","25":"","26":"","27":"","28":"","29":"","30":"","31":"","32":"","33":"","34":"","35":"","_rn_":"2"},{"1":"08/04/2021","2":"United States","3":"2020","4":"3","5":"2020-01-18","6":"59362","7":"54517","8":"831","9":"11701","10":"1819","11":"2491","12":"1483","13":"3526","14":"992","15":"1121","16":"615","17":"13591","18":"3257","19":"2","20":"1","21":"","22":"","23":"","24":"","25":"","26":"","27":"","28":"","29":"","30":"","31":"","32":"","33":"","34":"","35":"","_rn_":"3"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>


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




<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["Location"],"name":[1],"type":["fct"],"align":["left"]},{"label":["Year"],"name":[2],"type":["int"],"align":["right"]},{"label":["Week"],"name":[3],"type":["int"],"align":["right"]},{"label":["Week_End_Date"],"name":[4],"type":["date"],"align":["right"]},{"label":["Natural"],"name":[5],"type":["int"],"align":["right"]},{"label":["Septicemia"],"name":[6],"type":["int"],"align":["right"]},{"label":["Cancer"],"name":[7],"type":["int"],"align":["right"]},{"label":["Diabetes"],"name":[8],"type":["int"],"align":["right"]},{"label":["Alzheimer"],"name":[9],"type":["int"],"align":["right"]},{"label":["Influenza_Pneumonia"],"name":[10],"type":["int"],"align":["right"]},{"label":["Lower_Respiratory"],"name":[11],"type":["int"],"align":["right"]},{"label":["Other_Respiratory"],"name":[12],"type":["int"],"align":["right"]},{"label":["Kidney"],"name":[13],"type":["int"],"align":["right"]},{"label":["Abnormal_Finding"],"name":[14],"type":["int"],"align":["right"]},{"label":["Heart"],"name":[15],"type":["int"],"align":["right"]},{"label":["Brain"],"name":[16],"type":["int"],"align":["right"]},{"label":["Covid_19_Multi"],"name":[17],"type":["dbl"],"align":["right"]},{"label":["Covid_19"],"name":[18],"type":["dbl"],"align":["right"]}],"data":[{"1":"United States","2":"2014","3":"1","4":"2014-01-04","5":"50189","6":"882","7":"11244","8":"1654","9":"1780","10":"1639","11":"3331","12":"756","13":"965","14":"679","15":"13166","16":"2669","17":"0","18":"0"},{"1":"United States","2":"2014","3":"2","4":"2014-01-11","5":"52450","6":"905","7":"11504","8":"1735","9":"1917","10":"1910","11":"3444","12":"845","13":"1098","14":"665","15":"13663","16":"2738","17":"0","18":"0"},{"1":"United States","2":"2014","3":"3","4":"2014-01-18","5":"51043","6":"919","7":"11496","8":"1660","9":"1914","10":"1920","11":"3333","12":"812","13":"1056","14":"598","15":"12928","16":"2714","17":"0","18":"0"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>


```
##  [1] "Natural"             "Heart"               "Cancer"             
##  [4] "Lower_Respiratory"   "Brain"               "Alzheimer"          
##  [7] "Diabetes"            "Covid_19_Multi"      "Covid_19"           
## [10] "Influenza_Pneumonia" "Kidney"              "Other_Respiratory"  
## [13] "Septicemia"          "Abnormal_Finding"
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["Location"],"name":[1],"type":["fct"],"align":["left"]},{"label":["Year"],"name":[2],"type":["int"],"align":["right"]},{"label":["Week"],"name":[3],"type":["int"],"align":["right"]},{"label":["Week_End_Date"],"name":[4],"type":["date"],"align":["right"]},{"label":["Natural"],"name":[5],"type":["int"],"align":["right"]},{"label":["Heart"],"name":[6],"type":["int"],"align":["right"]},{"label":["Cancer"],"name":[7],"type":["int"],"align":["right"]},{"label":["Lower_Respiratory"],"name":[8],"type":["int"],"align":["right"]},{"label":["Brain"],"name":[9],"type":["int"],"align":["right"]},{"label":["Alzheimer"],"name":[10],"type":["int"],"align":["right"]},{"label":["Diabetes"],"name":[11],"type":["int"],"align":["right"]},{"label":["Covid_19_Multi"],"name":[12],"type":["dbl"],"align":["right"]},{"label":["Covid_19"],"name":[13],"type":["dbl"],"align":["right"]},{"label":["Influenza_Pneumonia"],"name":[14],"type":["int"],"align":["right"]},{"label":["Kidney"],"name":[15],"type":["int"],"align":["right"]},{"label":["Other_Respiratory"],"name":[16],"type":["int"],"align":["right"]},{"label":["Septicemia"],"name":[17],"type":["int"],"align":["right"]},{"label":["Abnormal_Finding"],"name":[18],"type":["int"],"align":["right"]}],"data":[{"1":"United States","2":"2014","3":"1","4":"2014-01-04","5":"50189","6":"13166","7":"11244","8":"3331","9":"2669","10":"1780","11":"1654","12":"0","13":"0","14":"1639","15":"965","16":"756","17":"882","18":"679"},{"1":"United States","2":"2014","3":"2","4":"2014-01-11","5":"52450","6":"13663","7":"11504","8":"3444","9":"2738","10":"1917","11":"1735","12":"0","13":"0","14":"1910","15":"1098","16":"845","17":"905","18":"665"},{"1":"United States","2":"2014","3":"3","4":"2014-01-18","5":"51043","6":"12928","7":"11496","8":"3333","9":"2714","10":"1914","11":"1660","12":"0","13":"0","14":"1920","15":"1056","16":"812","17":"919","18":"598"},{"1":"United States","2":"2014","3":"4","4":"2014-01-25","5":"50560","6":"12813","7":"11629","8":"3467","9":"2720","10":"1862","11":"1602","12":"0","13":"0","14":"1765","15":"1029","16":"753","17":"845","18":"622"},{"1":"United States","2":"2014","3":"5","4":"2014-02-01","5":"50402","6":"12896","7":"11584","8":"3283","9":"2699","10":"1867","11":"1586","12":"0","13":"0","14":"1642","15":"998","16":"720","17":"890","18":"664"},{"1":"United States","2":"2014","3":"6","4":"2014-02-08","5":"49790","6":"12681","7":"11355","8":"3351","9":"2684","10":"1873","11":"1643","12":"0","13":"0","14":"1528","15":"1038","16":"728","17":"849","18":"641"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

