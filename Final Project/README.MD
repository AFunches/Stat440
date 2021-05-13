# Stat 440 FInal Project - Analyzing the Effect of Mayoral Changes and Locality on Chicago Crime Rates

**Description**<br/>
For the project we are using two datasets that contain observations representative of crime incidents in the City of Chicago in the years of 2010 and 2018. These datasets were extracted by the city of Chicago from the Chicago Police Department’s CLEAR system or the Citizen Law Enforcement Analysis and Reporting system of Chicago and uploaded to the Chicago Data Portal. <br/>
Chicago Crime Data 2010: https://data.cityofchicago.org/Public-Safety/Crimes-2010/q4de-h6yq <br/>
Chicago Crime Data 2018: https://data.cityofchicago.org/Public-Safety/Crimes-2018/3i3m-jwuy <br/>

The aim of this project is to investigate how a mayor’s policies may affect crime rate and the setting it occurred in. Desiring to see this visually in a dataset the final year of each of the previous two mayors’ terms were selected which would allow for quantitative comparison and help us capture any effect their terms and enacted policies may have had on the crime rate. This research interest guided our questions of interest which includes finding the wards which have the highest number of reported crimes, their type, and if crimes are more likely to occur in a particular location.

**Data Description**<br/>
Both files have a similar structure and most of the same variables <br/>
2010 Chicago Crime Dataset <br/>
* 370,375 observations <br/>
* 18 variables <br/>

2018 Chicago Crime Dataset <br/>
* 267,985 observations <br/>
* 22 variables <br/>
* includes all of the variables the 2010 dataset includes with four others <br/>

**Variables:** <br/>
13 of the 22 variables contain categorical, character variables that are used for identification and to describe the location and date of occurrence for the crimes committed. Here are a few.. <br/>
* Case Number <br/>
* Date <br/>
* Primary Type <br/>
* Description <br/>
* Location Description <br/>
* Arrest - true or false <br/>
* Domestic - true or false <br/>

9 variables are numeric representations of the police geographical area, community, district, and geographic coordinates used for identification <br/>
* IURC <br/>
* Beat <br/>
* Ward <br/>
* FBI Code <br/>
* X Coordinates <br/>
* Y Coordinates <br/>
* Year <br/>
