	SELECT *
FROM BIKE_SALES.DBO.Sales

/* How have bike sales evolved over the past year/quarter/month? */

	SELECT YEAR,MONTH, sum(order_quantity) AS TOTAL_YEARLY
FROM dbo.Sales
GROUP BY 
	YEAR,MONTH
ORDER BY TOTAL_YEARLY DESC;

/*Are there any seasonal patterns in sales? When are the peak and off-peak periods?*/

	SELECT
    YEAR,
    AVG(order_quantity) AS AvgQuantity,
    AVG(Revenue) AS AvgRevenue
FROM
    dbo.Sales
GROUP BY
    YEAR
ORDER BY
    YEAR DESC;

	/*Which bike models are the top sellers in terms of quantity and revenue*/

SELECT PRODUCT, sum(order_quantity ) AS TOP_SELLERS
FROM dbo.Sales
GROUP BY 
	PRODUCT
ORDER BY TOP_SELLERS DESC;

/*Customize marketing strategies for specific customer groups.*/

	SELECT CUSTOMER_GENDER, CUSTOMER_AGE,
CASE
	WHEN CUSTOMER_AGE < 25 THEN  'YOUNG'
	WHEN CUSTOMER_AGE BETWEEN 25 AND 34 THEN 'YOUNG ADULT'
	ELSE  'ADULT'
	END AS AGE_GRADES
FROM dbo.Sales
ORDER BY Customer_Age;

/* female vs male */
	SELECT CUSTOMER_GENDER,
	SUM(ORDER_QUANTITY) AS FM
FROM dbo.Sales
GROUP BY 
	CUSTOMER_GENDER
ORDER BY
	FM DESC;

	/* Monthly intervals within a year */
	SELECT Month,
	SUM(ORDER_QUANTITY) AS MONTHLY_SALES
FROM dbo.Sales
GROUP BY 
	Month
ORDER BY
	MONTHLY_SALES DESC;

	/* yearly intervals  */

	SELECT Year,
	SUM(ORDER_QUANTITY) AS YEAR_SALES
FROM dbo.Sales
GROUP BY 
	Year
ORDER BY
	YEAR_SALES DESC;

	SELECT  *,
	sum(Order_Quantity) OVER (PARTITION BY PRODUCT ORDER BY DAY , MONTH , YEAR) AS Sorted_by
FROM DBO.SALES
WHERE Product LIKE '%Hitch Rack%';

	/* FIGURING OUT COUNTRY WITH THE MOST ORDERS*/
	SELECT Country, SUM(ORDER_QUANTITY) COUNTRY_ORDER
FROM DBO.SALES
GROUP BY Country
ORDER BY COUNTRY_ORDER;

	/* so when working on the project i noticed there was an error with the revenue*/
	SELECT Revenue, (Order_Quantity * unit_price) revenue
FROM DBO.SALES


	/* Identify products with low profitability and consider adjustments.*/

SELECT Product,Product_Category,Sub_Category,Order_Quantity,Unit_Cost,Unit_Price,Revenue,Cost,
     CASE
        WHEN Revenue > 0 THEN ((Revenue - Cost) / Revenue) * 100
        ELSE NULL  -- Handle division by zero by returning NULL
    END AS ProfitMargin
FROM
    dbo.SALES
WHERE
  revenue > 0 -- Exclude products with zero revenue
ORDER BY
    ProfitMargin;


SELECT Product,Product_Category,Sub_Category,Order_Quantity,Unit_Cost,Unit_Price,Revenue,Cost,
     CASE
        WHEN Revenue > 0 THEN ((Revenue - Cost) / Revenue) * 100
        ELSE NULL  -- Handle division by zero by returning NULL
    END AS ProfitMargin
FROM
    dbo.SALES

ORDER BY
    ProfitMargin;

/* Calculate the average profit margin for different product categories*/

SELECt Product_Category,
    AVG((Revenue - Cost) / Revenue) * 100 AS Avg_Profit_Margin
FROM
    dbo.SALES
GROUP BY
    Product_Category;

	/* Compare revenue between different countries and states */

SELECT Country,State,
    SUM(Revenue) AS Total_Revenue
FROM
    dbo.SALES
GROUP BY
    Country,
    State
ORDER BY
    Total_Revenue DESC;

	/*Calculate the average unit cost and unit price for each product category.*/

SELECT Product_Category,
    AVG(Unit_Cost) AS Avg_Unit_Cost,
    AVG(Unit_Price) AS Avg_Unit_Price
FROM
    dbo.SALES
GROUP BY
    Product_Category;

/* Analyze the relationship between unit price, unit cost, and profit margin */
SELECT
    Product_Category,
    AVG(Unit_Price) AS Avg_Unit_Price,
    AVG(Unit_Cost) AS Avg_Unit_Cost,
    AVG(((Revenue - Cost) / Revenue) * 100) AS Avg_Profit_Margin
FROM
    dbo.SALES
WHERE
    Revenue > 0  -- Exclude products with zero revenue
GROUP BY
    Product_Category;

/* assuming there was any spikes or drops in sales during holidays or special events
SELECT
    Date,
    Revenue
FROM
    Sales
WHERE
    Date BETWEEN '2016-12-20' AND '2016-12-25'
ORDER BY
    Date; */



