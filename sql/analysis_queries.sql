/* =====================================================
   MEDICAL DEVICE MARKET ANALYSIS - SQL QUERIES
   ===================================================== */

-- 1. Top 10 Products by Revenue (2024)
SELECT Product_Name,
       SUM(Revenue_2024_USD) AS Total_Revenue
FROM medical_devices
GROUP BY Product_Name
ORDER BY Total_Revenue DESC
LIMIT 10;


-- 2. Rank Products Within Each Region (Window Function)
SELECT Region,
       Product_Name,
       Revenue_2024_USD,
       RANK() OVER (PARTITION BY Region ORDER BY Revenue_2024_USD DESC) AS Rank_in_Region
FROM medical_devices;


-- 3. Top 10 Growth Leaders (YoY 2024)
SELECT Product_Name,
       YoY_Growth_2024
FROM medical_devices
ORDER BY YoY_Growth_2024 DESC
LIMIT 10;


-- 4. Underperforming Products (Low Revenue)
SELECT Product_Name,
       AVG(Survey_Satisfaction_Score) AS Avg_Rating,
       SUM(Revenue_2024_USD) AS Total_Revenue
FROM medical_devices
GROUP BY Product_Name
HAVING Total_Revenue < 50000;


-- 5. Region-wise Revenue Contribution (%)
SELECT Region,
       SUM(Revenue_2024_USD) AS Region_Revenue,
       ROUND(
           100 * SUM(Revenue_2024_USD) /
           (SELECT SUM(Revenue_2024_USD) FROM medical_devices),
       2) AS Percentage_Contribution
FROM medical_devices
GROUP BY Region
ORDER BY Percentage_Contribution DESC;


-- 6. Fastest Growing Device Category
SELECT Device_Category,
       AVG(YoY_Growth_2024) AS Avg_Growth
FROM medical_devices
GROUP BY Device_Category
ORDER BY Avg_Growth DESC;


-- 7. Running Total Revenue (Window Function)
SELECT Product_Name,
       Revenue_2024_USD,
       SUM(Revenue_2024_USD) OVER (ORDER BY Revenue_2024_USD DESC) AS Running_Total
FROM medical_devices;


-- 8. Top 3 Products per Region (Advanced Window Function)
SELECT *
FROM (
    SELECT Region,
           Product_Name,
           Revenue_2024_USD,
           RANK() OVER (PARTITION BY Region ORDER BY Revenue_2024_USD DESC) AS rnk
    FROM medical_devices
) ranked
WHERE rnk <= 3;


-- 9. Average Satisfaction Score by Region
SELECT Region,
       AVG(Survey_Satisfaction_Score) AS Avg_Satisfaction
FROM medical_devices
GROUP BY Region
ORDER BY Avg_Satisfaction DESC;


-- 10. High Satisfaction but Low Revenue (Opportunity Products)
SELECT Product_Name,
       AVG(Survey_Satisfaction_Score) AS Avg_Rating,
       SUM(Revenue_2024_USD) AS Total_Revenue
FROM medical_devices
GROUP BY Product_Name
HAVING Avg_Rating > 4 AND Total_Revenue < 50000;


-- 11. Year-wise Total Revenue
SELECT 
    SUM(Revenue_2022_USD) AS Revenue_2022,
    SUM(Revenue_2023_USD) AS Revenue_2023,
    SUM(Revenue_2024_USD) AS Revenue_2024
FROM medical_devices;


-- 12. Top Manufacturers by Revenue
SELECT Manufacturer,
       SUM(Revenue_2024_USD) AS Total_Revenue
FROM medical_devices
GROUP BY Manufacturer
ORDER BY Total_Revenue DESC
LIMIT 10;


-- 13. Devices with Highest Market Share
SELECT Product_Name,
       Market_Share_Pct
FROM medical_devices
ORDER BY Market_Share_Pct DESC
LIMIT 10;


-- 14. Correlation Insight (High Trials vs Revenue)
SELECT Clinical_Trials,
       AVG(Revenue_2024_USD) AS Avg_Revenue
FROM medical_devices
GROUP BY Clinical_Trials
ORDER BY Avg_Revenue DESC;


-- 15. Products with Missing Reimbursement (Data Quality Insight)
SELECT Product_Name,
       Reimbursement_Coverage
FROM medical_devices
WHERE Reimbursement_Coverage IS NULL
   OR Reimbursement_Coverage = 'Unknown';
