SELECT
  SUM(Sales) - SUM(Quantity * Discount) AS Profit2023
FROM dim_date dd, fact_sales fs, dim_product p
WHERE dd.Order_Date = fs.Order_Date
AND fs.ProductID = p.Product_ID
AND dd.Year = '2023'
AND p.Product_ID = 'FUR-BO-10000362';