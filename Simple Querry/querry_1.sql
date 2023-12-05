SELECT
  SUM(MonthlyProfit) AS Profit2023
FROM (
  SELECT
    d.Year,
    d.Month,
    SUM(s.Sales) - SUM(s.Quantity * s.Discount) AS MonthlyProfit
  FROM
    dim_date d
    JOIN fact_sales s ON d.Order_Date = s.Order_Date
  WHERE
    d.Year = '2023'
  GROUP BY
    d.Year, d.Month
) AS MonthlyProfit;