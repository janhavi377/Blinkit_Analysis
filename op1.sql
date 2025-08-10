create database blinkit;
use blinkit;

RENAME TABLE `blinkit grocery data` to blinkData;

select * from blinkData;

SELECT COUNT(*) AS total_rows
FROM blinkData;

-- its not detecting the colum name so change column name
ALTER TABLE blinkData
RENAME COLUMN `ï»¿Item Fat Content` TO ItemFatContent;


UPDATE blinkData
SET ItemFatContent = 
    CASE
        WHEN ItemFatContent IN ('LF', 'low fat') THEN 'Low Fat'
        WHEN ItemFatContent = 'reg' THEN 'Regular'
        ELSE ItemFatContent
    END;
    
select distinct(ItemFatContent)
from blinkData;

SELECT *
FROM blinkData
WHERE ItemFatContent IN ('Register', 'Regular')
ORDER BY ItemFatContent; -- yaha tum apne actual comparison columns daalo


SELECT 
    SUM(ItemFatContent = 'Register') AS Register_Count,
    SUM(ItemFatContent = 'Regular')  AS Regular_Count
FROM blinkData;

DELETE FROM blinkData
WHERE ItemFatContent = 'Register';

select count(*)
from blinkData;


select distinct(ItemFatContent)
from blinkData;
-- ========================================================================================================================
-- KPI REQUIRNMENT
-- 1):Find Total Sales

select round(SUM( `Total Sales`),2) AS Total_Sales
from blinkData;

select CAST(SUM( `Total Sales`)/ 1000000 AS DECIMAL(10,2)) AS Total_Sales_Millions
From blinkData;


-- 2) find out Average Sales
select Cast(AVG(`Total Sales`) as decimal(10,2)) as Avg_sales
from blinkData;

-- 3) Find out no of Items in database
select count(*) from blinkData;


select cast(avg(`Outlet Establishment Year`) as decimal(10,2)) as total_avg
from blinkData
where `Outlet Establishment Year`=2020;

-- ========================================================================================================================
-- GRANULAR REQUIRNMENT

select * from blinkData;

select `ItemFatContent`, `Item Type`,
concat(Cast(AVG(`Total Sales`) as decimal(10,2)),'k') as Avg_sales,
Cast(SUM(Rating) as decimal(10,2)) as TotalRatings,
count(`ItemFatContent`) as Total_count
from blinkData
where `ItemFatContent`= 'Low Fat'
group by `Item Type`
order by `ItemFatContent` desc;


select * from blinkData;

select `Outlet Establishment Year`,
concat(Cast(AVG(`Total Sales`) as decimal(10,2)),'k') as Avg_sales,
Cast(SUM(Rating) as decimal(10,2)) as TotalRatings,
count(`ItemFatContent`) as Total_count
from blinkData
group by `Outlet Establishment Year`
order by `Outlet Establishment Year`;

-- CHARTS REQUIRNMENT
-- ==========================================================================================================================================================

-- Percentage of sales by outlet size

SELECT 
    `Outlet Size`, 
    CAST(SUM(`Total Sales`) AS DECIMAL(10,2)) AS TotalSales,
    CAST(
        SUM(`Total Sales`) * 100.0 / SUM(SUM(`Total Sales`)) OVER ()
        AS DECIMAL(10,2)
    ) AS per_sales
FROM blinkData
GROUP BY `Outlet Size`
ORDER BY TotalSales DESC;


select `Outlet Location Type`,
concat(Cast(AVG(`Total Sales`) as decimal(10,2)),'k') as Avg_sales,
CAST(
        SUM(`Total Sales`) * 100.0 / SUM(SUM(`Total Sales`)) OVER ()
        AS DECIMAL(10,2)
    ) AS per_sales,
Cast(SUM(Rating) as decimal(10,2)) as TotalRatings,
count(`ItemFatContent`) as Total_count
from blinkData
group by `Outlet Location Type`
order by per_sales desc;





