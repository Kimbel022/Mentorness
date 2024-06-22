-- Q1. Write a code to check NULL values
SELECT *
FROM CoronaVirusDataset
WHERE Province IS NULL OR
Country_Region IS NULL OR
Latitude IS NULL OR
Longitude IS NULL OR
Date IS NULL OR
Confirmed IS NULL OR
Deaths IS NULL OR
Recovered IS NULL 
--NO NULL VALUES


--Q2. If NULL values are present, update them with zeros for all columns. 
******************


-- Q3. check total number of rows
SELECT format(COUNT(*),'N0') AS Total_Number_of_Rows
FROM CoronaVirusDataset
--78386


-- Q4. Check what is start_date and end_date
SELECT 
MIN(Date) AS Start_Date,
MAX(Date) AS End_Date
FROM CoronaVirusDataset
--2020-01-22	2021-06-13


-- Q5. Number of month present in dataset
SELECT YEAR(date) AS Year,
COUNT(DISTINCT(MONTH(Date))) AS Number_of_Months
FROM CoronaVirusDataset
GROUP BY YEAR(date)


-- Q6. Find monthly average for confirmed, deaths, recovered
SELECT YEAR(Date) AS Year,
MONTH(Date) AS Month,
AVG(confirmed) AS Average_Confirmed,
AVG(Deaths) AS Average_Deaths,
AVG(Recovered) AS Average_Recovered
FROM CoronaVirusDataset
GROUP BY YEAR(Date),MONTH(Date)
ORDER BY YEAR(Date),MONTH(Date)


-- Q7. Find most frequent value for confirmed, deaths, recovered each month 
WITH CTE_RANKING
AS(
SELECT 
MONTH(Date) AS Month,
Confirmed,
Deaths,
Recovered,
COUNT(*) AS Frequency,
ROW_NUMBER() OVER(PARTITION BY MONTH(Date) ORDER BY COUNT(*) DESC) AS Ranking
FROM CoronaVirusDataset
GROUP BY MONTH(Date),Confirmed,Deaths,Recovered
)
SELECT 
Month,
Confirmed AS Most_Confirmed_Frequency,
Deaths AS Most_Deaths_Frequency,
Recovered AS Most_Recovered_Frequency
FROM CTE_RANKING
WHERE Ranking = 1
ORDER BY Month


-- Q8. Find minimum values for confirmed, deaths, recovered per year
SELECT YEAR(Date) AS Year,
MIN(Confirmed) AS Minimum_Confirmed,
MIN(Deaths) AS Minimum_Deaths,
MIN(Recovered) AS Minimum_Recovered
FROM CoronaVirusDataset
GROUP BY YEAR(Date)


-- Q9. Find maximum values of confirmed, deaths, recovered per year
SELECT YEAR(Date) AS Year,
MAX(Confirmed) AS Maximum_Confirmed,
MAX(Deaths) AS Maximum_Deaths,
MAX(Recovered) AS Maximum_Recovered
FROM CoronaVirusDataset
GROUP BY YEAR(Date)


-- Q10. The total number of case of confirmed, deaths, recovered each month
SELECT YEAR(Date) AS Year,
MONTH(Date) AS Month,
SUM(Confirmed) AS Total_Confirmed,
SUM(Deaths) AS Total_Deaths,
SUM(Recovered) AS Total_Recovered
FROM CoronaVirusDataset
GROUP BY YEAR(Date),MONTH(Date)
ORDER BY YEAR(Date),MONTH(Date)


-- Q11. Check how corona virus spread out with respect to confirmed case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT YEAR(Date) AS Year,MONTH(Date) AS Month,
SUM(Confirmed) AS Total_Confirmed_Cases,
AVG(Confirmed) AS Average_Confirmed_Cases,
VAR(Confirmed) AS Variance_Confirmed_Cases,
STDEV(Confirmed) AS STDEV_Confirmed_Cases
FROM CoronaVirusDataset
GROUP BY YEAR(Date),MONTH(Date)
ORDER BY YEAR(Date) ASC,MONTH(Date) ASC


-- Q12. Check how corona virus spread out with respect to death case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT 
YEAR(Date) AS Year,
MONTH(Date) AS Month,
SUM(Deaths) AS Total_Deaths_Cases,
AVG(Deaths) AS Average_Deats_Cases,
VAR(Deaths) AS Variance_Deaths_Cases,
STDEV(Deaths) AS STDEV_Deaths_Cases
FROM CoronaVirusDataset
GROUP BY YEAR(Date),MONTH(Date)
ORDER BY YEAR(Date) ASC,MONTH(Date) ASC


-- Q13. Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT 
YEAR(Date) AS Year,
MONTH(Date) AS Month,
SUM(Recovered) AS Total_Recovered_Cases,
AVG(Recovered) AS Average_Recovered_Cases,
VAR(Recovered) AS Variance_Recovered_Cases,
STDEV(Recovered) AS STDEV_Recovered_Cases
FROM CoronaVirusDataset
GROUP BY YEAR(Date),MONTH(Date)
ORDER BY YEAR(Date) ASC,MONTH(Date) ASC


-- Q14. Find Country having highest number of the Confirmed case
SELECT TOP 1 Country_Region,
SUM(Confirmed) AS Total_Confirmed_Cases
FROM CoronaVirusDataset
GROUP BY Country_Region
ORDER BY SUM(Confirmed) DESC


-- Q15. Find Country having lowest number of the death case
SELECT Country_Region,SUM(Deaths)
FROM CoronaVirusDataset
GROUP BY Country_Region
ORDER BY SUM(Deaths) ASC


-- Q16. Find top 5 countries having highest recovered case
SELECT TOP 5 Country_Region,SUM(Recovered)
FROM CoronaVirusDataset
GROUP BY Country_Region
ORDER BY SUM(Recovered) DESC