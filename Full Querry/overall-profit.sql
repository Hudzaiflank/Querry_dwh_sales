
WITH MonthlyProfit AS (
    SELECT
        d.Year,
        d.Month,
        SUM(s.Sales) - SUM(s.Quantity * s.Discount) AS MonthlyProfit
    FROM
        dim_date d
    JOIN
        fact_sales s ON d.Order_Date = s.Order_Date
    WHERE
        d.Year IN ('2022', '2023')
    GROUP BY
        d.Year, d.Month
)
-- Calculate the overall profit margin increase from 2022 to 2023
SELECT
    'Overall' AS Metric,
    '2022' AS Year,
    SUM(CASE WHEN Year = '2022' THEN MonthlyProfit END) AS Profit2022,
    '2023' AS Year,
    SUM(CASE WHEN Year = '2023' THEN MonthlyProfit END) AS Profit2023,
    (SUM(CASE WHEN Year = '2023' THEN MonthlyProfit END) - SUM(CASE WHEN Year = '2022' THEN MonthlyProfit END)) / SUM(CASE WHEN Year = '2022' THEN MonthlyProfit END) AS ProfitMarginIncrease
FROM
    MonthlyProfit;
