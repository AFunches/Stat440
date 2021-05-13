/* <Alex Pope Funches> */
/* Midterm Project Submission */

data Work.Boston;
    infile '/home/funchesoalex0/sasuser.v94/Stat 440/Midterm Project/Boston_damaged.dat' DLM= '09'X DSD firstobs=2;
    length TOWN $24;
    input  ObservationNumber Town TownNumber TractID Longitude Latitude MedV CMedV Crim ZN Industry Chas Nox Rooms
    		Age Distance Rad Tax PTRatio BProportion LStat;
    label MEDV='Vector of Median Values of Owner-Occupied Housing in USD 1000'
    	CMEDV ='Vector of Corrected Median Values of Owner-Occupied Housing in USD 1000'
    	Crim = 'Vector of Per Capita Crime'
    	Zn = 'Vector of Proportions of Residential Land Zoned for Lots Over 25,000 Sq Ft per Town'
    	Industry = 'Vector of Proportions of Non-Retail Business Acres per Town'
    	Chas = 'Factor Indicating if Tract Borders Charles River'
    	Nox = 'Vector of Nitric Oxide Concentration (Parts per 10 Million) per town'
    	Rooms = 'Average Number of Rooms per Dwelling'
    	Age = 'Vector of Proportions of Owner-Occupied Units Built Before 1940'
    	Distance = 'Vector of Weighted Distances to Five Boston Employment Centers'
    	Rad = 'Vector of Index of Accessibility to Radial Highways per Town'
    	Tax = 'Vector of Full Value Property-Tax Rate per USD 10,000 per Town'
    	PTRatio = 'Vector of Pupil-Teacher Ratios per Town'
    	BProportion = 'Proportion of Blacks per Town'
    	LStat = 'Vector of Percentage Values of Lower Status Population'; 
run; 
 
proc means data=Work.Boston;
	var ObservationNumber TownNumber TractID Longitude Latitude MedV CMedV Crim ZN Industry Chas Nox Rooms
    	Age Distance Rad Tax PTRatio BProportion LStat;
run; 

proc means data=Work.Boston; /* Only running the means procedure for concerning variables (excluding BProportion)*/
	var Nox Industry Tax;
run; 

proc freq data=Work.Boston;
	tables BProportion;
	where BProportion = 396.9;
run;

proc freq data = Work.Boston; /*Just to see where Nox had values of 9,999 and correct it*/ 
	tables Nox*ObservationNumber;
	where Nox = 9999;
run; 

data Boston;
    infile '/home/funchesoalex0/sasuser.v94/Stat 440/Midterm Project/Boston_damaged.dat' DLM= '09'X DSD firstobs=2;
    length TOWN $24;
    input  ObservationNumber Town TownNumber TractID Longitude Latitude MedV CMedV Crim ZN Industry Chas Nox Rooms
    		Age Distance Rad Tax PTRatio BProportion LStat;
    label MEDV='Vector of Median Values of Owner-Occupied Housing in USD 1000'
    	CMEDV ='Vector of Corrected Median Values of Owner-Occupied Housing in USD 1000'
    	Crim = 'Vector of Per Capita Crime'
    	Zn = 'Vector of Proportions of Residential Land Zoned for Lots Over 25,000 Sq Ft per Town'
    	Industry = 'Vector of Proportions of Non-Retail Business Acres per Town'
    	Chas = 'Factor Indicating if Tract Borders Charles River'
    	Nox = 'Vector of Nitric Oxide Concentration (Parts per 10 Million) per town'
    	Rooms = 'Average Number of Rooms per Dwelling'
    	Age = 'Vector of Proportions of Owner-Occupied Units Built Before 1940'
    	Distance = 'Vector of Weighted Distances to Five Boston Employment Centers'
    	Rad = 'Vector of Index of Accessibility to Radial Highways per Town'
    	Tax = 'Vector of Full Value Property-Tax Rate per USD 10,000 per Town'
    	PTRatio = 'Vector of Pupil-Teacher Ratios per Town'
    	BProportion = 'Proportion of Blacks per Town'
    	LStat = 'Vector of Percentage Values of Lower Status Population'; 
    format Longitude COMMA9.6
    	   Latitude COMMA9.6; 
   	if Industry=. AND Town='Somerville' then Industry=21.89;
   	if Tax=. AND Town='Waltham' then Tax=277;
   	if Tax=. AND Town='Quincy' then Tax=304; 
   	if Nox=9999 AND Town='Reading' then Nox=0.426;
   	if Nox=9999 AND Town='Malden' then Nox=0.547;
   	if Nox=9999 AND Town='Waltham' then Nox=0.489;
run; 

proc means data=Boston;
	var Nox Industry Tax;
run; 

proc contents data=Boston order=VARNUM; 
	ods exclude EngineHost;
run; 
 /* Fixed Following Issues
 Added Decimals to Lat/Long
 Changed missing observations represented by periods in Tax/Industry to 0
 Changed Nox value of 9999 to 0 */ 

/* Exercise 1 */
title 'Exercise 1'; 
/* Part A */
title 'Part A';
proc means data=Boston;
	var TractID;
	class Town;	
run; 
/* Part B */
title 'Part B';
proc means data=Boston;
	var Crim;
	class Town;
	output out=BostonCrim mean=Average_Crim;
run; 

proc sort data=BostonCrim (keep=Town Average_Crim);
	by Average_Crim;
run;

proc print data=BostonCrim (obs=5);
run; 

proc sort data=BostonCrim (keep=Town Average_Crim);
	by descending Average_Crim;
run; 

proc print data=BostonCrim (obs=5);
run; 
 
/* Part C */
title 'Part C';
proc means data=Boston N Mean STDDEV Min Max Lclm Uclm Mode;
	var MedV;
run; 

proc freq data=Boston;
	tables MedV / chisq;
run; 


