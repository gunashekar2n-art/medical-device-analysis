-- Top Revenue Products
SELECT Product_Name, SUM(Revenue_2024_USD) AS Total_Revenue
FROM medical_devices
GROUP BY Product_Name
ORDER BY Total_Revenue DESC;

-- Region-wise Performance
SELECT Region, SUM(Revenue_2024_USD) AS Revenue
FROM medical_devices
GROUP BY Region;

-- Ranking Products
SELECT Product_Name, Region,
RANK() OVER (PARTITION BY Region ORDER BY Revenue_2024_USD DESC) AS Rank_in_Region
FROM medical_devices;