-- Calculate profit margin for a specific product for each month in 2022 and 2023
WITH ProductMonthlyProfit AS (
    SELECT
        d.Year,
        d.Month,
        p.Product_ID,
        p.Product_Name,
        SUM(s.Sales) - SUM(s.Quantity * s.Discount) AS MonthlyProfit
    FROM
        dim_date d
    JOIN
        fact_sales s ON d.Order_Date = s.Order_Date
    JOIN
        dim_product p ON s.ProductID = p.Product_ID
    WHERE
        d.Year IN ('2022', '2023')
    GROUP BY
        d.Year, d.Month, p.Product_ID, p.Product_Name
)
-- Calculate the profit margin increase for a specific product from 2022 to 2023
SELECT
    'Product' AS Metric,
    Product_ID,
    Product_Name,	
    '2022' AS Year2022,
    SUM(CASE WHEN Year = '2022' THEN MonthlyProfit END) AS Profit2022,
    '2023' AS Year2023,
    SUM(CASE WHEN Year = '2023' THEN MonthlyProfit END) AS Profit2023,
    (SUM(CASE WHEN Year = '2023' THEN MonthlyProfit END) - SUM(CASE WHEN Year = '2022' THEN MonthlyProfit END)) / SUM(CASE WHEN Year = '2022' THEN MonthlyProfit END) AS ProfitMarginIncrease
FROM
    ProductMonthlyProfit
WHERE
    Product_ID = 'FUR-BO-10000362'  -- Replace with the specific product ID
GROUP BY
    Product_ID, Product_Name;
