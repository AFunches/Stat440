/* Mark Belsis */
/* Final_Project Submission */



/* Read in Chicago Crimes from 2010 (Crimes_-_2010.csv) */
data ChicagoCrime2010;
	infile '/home/mbelsis20/Stat 440/FINAL_PROJECT/Data/Crimes_-_2010.csv' DSD firstobs=2;
	length CaseNumber $8 Date $22 Block $35 Offense $26 Description $41 LocationType $31 Location $30;
	input CaseNumber $ Date $ Block $ IUCR $ Offense $ Description $ LocationType $ Arrest $ Domestic $ Beat Ward Code $ XCoordinate YCoordinate Year Latitude Longitude Location;
	label CaseNumber = 'Unique ID of case incident'
		Date = 'Date of crime'
		Block = 'Block of incident'
		IUCR = 'Illinois Uniform Crime Reporting code to classify criminal incidents'
		Offense = 'Classification of crime'
		Description = 'More in depth description of the crime'
		LocationType = 'Description of location such as Street, Apartment, Residence, etc.'
		Arrest = 'TRUE or FALSE variable on whether an arrest was made'
		Domestic = 'TRUE or FALSE variable on whether the crime was domestic'
		Beat = 'Indicates beat (police geographical area) in which crime occurred.'
		Ward = 'An numerical ID for a local authority area'
		Year = 'Year of crime';
run;



/* Read in Chicago Crimes from 2018 (Crimes_-_2018.csv) */
data ChicagoCrime2018;
	infile '/home/mbelsis20/Stat 440/FINAL_PROJECT/Data/Crimes_-_2018.csv' DSD firstobs=2;
	length ID $8 CaseNumber $8 Date $22 Update $22 Block $35 Offense $26 Description $41 LocationType $31 Location $30;
	input ID $ CaseNumber $ Date $ Block $ IUCR $ Offense $ Description $ LocationType $ Arrest $ Domestic $ Beat District Ward Community Code $ XCoordinate YCoordinate Year Update Latitude Longitude Location;
	label CaseNumber = 'Unique ID of case incident'
		ID= 'ID of observation'
		Code = 'FBI Code of Offense'
		Date = 'Date of crime'
		Update = 'Date crime record was updated'
		Block = 'Block of incident'
		IUCR = 'Illinois Uniform Crime Reporting code to classify criminal incidents'
		Offense = 'Classification of crime'
		Description = 'More in depth description of the crime'
		LocationType = 'Description of location such as Street, Apartment, Residence, etc.'
		Arrest = 'TRUE or FALSE variable on whether an arrest was made'
		Domestic = 'TRUE or FALSE variable on whether the crime was domestic'
		Beat = 'Indicates beat (police geographical area) in which crime occurred.'
		District = 'District Number crime occured in'
		Ward = 'An numerical ID for a local authority area'
		Community = 'Community Crime occured in'
		Year = 'Year of crime';
run;



/* Proc Contents for general overview of both datasets */
proc contents data=ChicagoCrime2010;
run;

proc contents data=ChicagoCrime2018;
run;



/* Proc Sort for both datasets */
proc sort data=ChicagoCrime2010 out=ChicagoCrime2010_Sorted;
	by Date;
run;
	
proc sort data=ChicagoCrime2018 out=ChicagoCrime2018_Sorted;
	by Date;
run;



/* Merging both datasets */
data ChicagoCrime;
	merge ChicagoCrime2010_Sorted ChicagoCrime2018_Sorted;
	by Date;
	length CaseNumber $8 ID $8 Date $22 Update $22 Block $35 Offense $26 Description $41 LocationType $31 Location $30;
	label CaseNumber = 'Unique ID of case incident'
		ID= 'ID of observation'
		Code = 'FBI Code of Offense'
		Date = 'Date of crime'
		Update = 'Date crime record was updated'
		Block = 'Block of incident'
		IUCR = 'Illinois Uniform Crime Reporting code to classify criminal incidents'
		Offense = 'Classification of crime'
		Description = 'More in depth description of the crime'
		LocationType = 'Description of location such as Street, Apartment, Residence, etc.'
		Arrest = 'TRUE or FALSE variable on whether an arrest was made'
		Domestic = 'TRUE or FALSE variable on whether the crime was domestic'
		Beat = 'Indicates beat (police geographical area) in which crime occurred.'
		District = 'District Number crime occured in'
		Ward = 'An numerical ID for a local authority area'
		Community = 'Community Crime occured in'
		Year = 'Year of crime';
run;

proc contents data=ChicagoCrime;
run;



/* Data Cleaning and Validation */

/* The two SQL statements below were originally one but were split for easier copying for the results of the report */
proc sql;
select count(*) as n 'Total number of the observations',
	nmiss(CaseNumber) as nm_cn 'Number of the missing values for Case Number',
	nmiss(Date) as nm_date 'Number of the missing values for Date',
	nmiss(Block) as nm_block 'Number of the missing values for Block',
	nmiss(IUCR) as nm_IUCR 'Number of the missing values for IUCR',
	nmiss(Offense) as nm_offense 'Number of the missing values for Offense',
	nmiss(Description) as nm_description 'Number of the missing values for Description',
	nmiss(LocationType) as nm_locationtype 'Number of the missing values for LocationType',
	nmiss(Arrest) as nm_arrest 'Number of the missing values for Arrest',
	nmiss(Domestic) as nm_domestic 'Number of the missing values for Domestic',
	nmiss(Beat) as nm_beat 'Number of the missing values for Beat'

from ChicagoCrime;
quit;



proc sql;
select
	nmiss(Ward) as nm_ward 'Number of the missing values for Ward',
	nmiss(Code) as nm_code 'Number of the missing values for Code',
	nmiss(XCoordinate) as nm_xcoordinate 'Number of the missing values for XCoordinate',
	nmiss(YCoordinate) as nm_ycoordinate 'Number of the missing values for YCoordinate',
	nmiss(Year) as nm_year 'Number of the missing values for Year',
	nmiss(Latitude) as nm_latitude 'Number of the missing values for Latitude',
	nmiss(Longitude) as nm_longitude 'Number of the missing values for Longitude',
	nmiss(Location) as nm_location 'Number of the missing values for Location'
from ChicagoCrime;
quit;
	
proc print data=ChicagoCrime;
	where CaseNumber is missing;
run;

proc print data=ChicagoCrime;
	where LocationType is missing;
run;
proc print data=ChicagoCrime;
	where Ward is missing;
run;

proc freq data=ChicagoCrime NLEVELS;
	tables _all_ / noprint;
run;

proc freq data=ChicagoCrime noprint;
	table CaseNumber / out=ChicagoCrime_cases;
run;

proc print data=ChicagoCrime_cases;
	where Count > 1;
run;

			/*		QUESTIONS		*/
/* Question 1 How might crime rate change across mayor’s near the end of their term? */
title 'Exercise 1';

proc freq data=ChicagoCrime;
	tables Offense*Year / nocol nocum;
run;

proc freq data=ChicagoCrime;
	tables Year / nocol nocum;
run;




/* Question 2 Which wards have the highest crime rate and what type of crimes? Is this consistent across years? */
title 'Exercise 2';

/* 2010 */
title2 'Top 5 Wards: 2010';
proc freq data=ChicagoCrime NOPRINT;
	where Year = 2010;
	tables Ward / nocol nocum out=Freq2010;
run;

data Freq2010_cleaned;
	set Freq2010;
	where Ward IS NOT MISSING;
run;

proc sort data=Freq2010_cleaned out=Freq2010_sorted;
	by descending COUNT;
run;

proc print data=Freq2010_sorted (obs=5) noobs;
run;

/* 2018 */
title2 'Top 5 Wards: 2018';
proc freq data=ChicagoCrime NOPRINT;
	where Year = 2018;
	tables Ward / nocol nocum out=Freq2018;
run;

data Freq2018_cleaned;
	set Freq2018;
	where Ward IS NOT MISSING;
run;

proc sort data=Freq2018_cleaned out=Freq2018_sorted;
	by descending COUNT;
run;

proc print data=Freq2018_sorted (obs=5) noobs;
run;



/* 2010 */
proc freq data=ChicagoCrime NOPRINT;
	tables Offense*Ward /nocol nocum out = offense2010(drop=Percent);
	where Year = 2010 and Ward in (28,24,42,2,27);
run;

			/* Ward 2 */
title2 'Top 5 Offenses, Ward 2 in 2010';
proc sort data=offense2010 out=offense2010_ward2;
	where Ward = 2;
	by descending Count;
run;

proc print data=offense2010_ward2 (obs=5) noobs;
run;

			/* Ward 24 */
title2 'Top 5 Offenses, Ward 24 in 2010';
proc sort data=offense2010 out=offense2010_ward24;
	where Ward = 24;
	by descending Count;
run;

proc print data=offense2010_ward24 (obs=5) noobs;
run;

			/* Ward 27 */
title2 'Top 5 Offenses, Ward 27 in 2010';
proc sort data=offense2010 out=offense2010_ward27;
	where Ward = 27;
	by descending Count;
run;

proc print data=offense2010_ward27 (obs=5) noobs;
run;

			/* Ward 28 */
title2 'Top 5 Offenses, Ward 28 in 2010';
proc sort data=offense2010 out=offense2010_ward28;
	where Ward = 28;
	by descending Count;
run;

proc print data=offense2010_ward28 (obs=5) noobs;
run;

			/* Ward 42 */
title2 'Top 5 Offenses, Ward 42 in 2010';
proc sort data=offense2010 out=offense2010_ward42;
	where Ward = 42;
	by descending Count;
run;

proc print data=offense2010_ward42 (obs=5) noobs;
run;

/* 2018 */
title2 '2018';
proc freq data=ChicagoCrime NOPRINT;
	tables Offense*Ward /nocol nocum out = offense2018(drop=Percent);
	where Year = 2018 and Ward in (28,24,42,2,27);
run;

			/* Ward 2 */
title2 'Top 5 Offenses, Ward 2 in 2018';
proc sort data=offense2018 out=offense2018_ward2;
	where Ward = 2;
	by descending Count;
run;

proc print data=offense2018_ward2 (obs=5) noobs;
run;

			/* Ward 24 */
title2 'Top 5 Offenses, Ward 24 in 2018';
proc sort data=offense2018 out=offense2018_ward24;
	where Ward = 24;
	by descending Count;
run;

proc print data=offense2018_ward24 (obs=5) noobs;
run;

			/* Ward 27 */
title2 'Top 5 Offenses, Ward 27 in 2018';
proc sort data=offense2018 out=offense2018_ward27;
	where Ward = 27;
	by descending Count;
run;

proc print data=offense2018_ward27 (obs=5) noobs;
run;

			/* Ward 28 */
title2 'Top 5 Offenses, Ward 28 in 2018';
proc sort data=offense2018 out=offense2018_ward28;
	where Ward = 28;
	by descending Count;
run;

proc print data=offense2018_ward28 (obs=5) noobs;
run;

			/* Ward 42 */
title2 'Top 5 Offenses, Ward 42 in 2018';
proc sort data=offense2018 out=offense2018_ward42;
	where Ward = 42;
	by descending Count;
run;

proc print data=offense2018_ward42 (obs=5) noobs;
run;




/* Question 3 Are crimes more likely to occur in a particular location like a street or residence? */
title 'Exercise 3';
proc freq data=ChicagoCrime;
	tables Offense*LocationType /nocol nocum;
run; /*Can combine offense types with multiple levels like airport, cta, hospital etc */

proc freq data=ChicagoCrime;
	tables LocationType / nocol nocum out=top10crimelocations;
run; 

proc sort data=top10crimelocations;
	by descending Count;
run;

proc print data=top10crimelocations (OBS=10) noobs;
run;





