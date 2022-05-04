-- Question 1
SELECT C.CustomerName, C.Gender, S.SalesPersonName, S.City FROM Fact_ProductSales P 
	INNER JOIN Dim_Customer C ON P.CustomerID = C.CustomerID 
	INNER JOIN Dim_SalesPerson S ON P.SalesPersonID = S.SalesPersonID
	INNER JOIN Dim_Date D ON P.SalesDateKey = D.DateKey
	WHERE D.MONTHNAME = "September" AND D.YEAR = 2015 AND P.SalesPrice > 20 AND P.Quantity > 8;
    
-- Question 2
SELECT S.StoreName, S.City, Pr.ProductName FROM Fact_ProductSales P
	INNER JOIN Dim_Store S ON P.StoreID = S.StoreID
    INNER JOIN Dim_Product Pr ON P.ProductID = Pr.ProductKey
    INNER JOIN Dim_Date D ON P.SalesDateKey = D.DateKey
	WHERE D.MONTHNAME = "March" AND D.YEAR = 2017 AND P.ProductCost < 50 AND S.City = "Boulder";
    
-- Question 3
SELECT SalesPersonName, SUM(P.SalesPrice * P.Quantity) AS `Total Revenue` FROM Fact_ProductSales P
	INNER JOIN Dim_SalesPerson S ON P.SalesPersonID = S.SalesPersonID
    INNER JOIN Dim_Date D ON P.SalesDateKey = D.DateKey
	WHERE D.YEAR = 2017
    GROUP BY S.SalesPersonID
    ORDER BY `Total Revenue` DESC
    LIMIT 2;
    
-- Question 4
SELECT C.CustomerName, SUM(P.SalesPrice * P.Quantity) AS `Total Revenue` FROM Fact_ProductSales P
	INNER JOIN Dim_Customer C ON P.CustomerID = C.CustomerID 
    INNER JOIN Dim_Date D ON P.SalesDateKey = D.DateKey
	WHERE D.YEAR = 2017
    GROUP BY C.CustomerID
    ORDER BY `Total Revenue` ASC
    LIMIT 1;

-- Question 5
SELECT S.StoreName, SUM(P.SalesPrice) AS `Total Sales Price` FROM Fact_ProductSales P
    INNER JOIN Dim_Store S ON P.StoreID = S.StoreID
    INNER JOIN Dim_Date D ON P.SalesDateKey = D.DateKey
	WHERE D.YEAR > 2010 AND D.YEAR < 2017
    GROUP BY S.StoreID
    ORDER BY S.StoreName ASC;
    
-- Question 6
SELECT S.StoreName, Pr.ProductName, SUM((SalesPrice*Quantity)-(ProductCost*Quantity)) AS `Total Profits` FROM Fact_ProductSales P
	INNER JOIN Dim_Store S ON P.StoreID = S.StoreID
	INNER JOIN Dim_Product Pr ON P.ProductID = Pr.ProductKey
    INNER JOIN Dim_Date D ON P.SalesDateKey = D.DateKey
    WHERE D.Year = 2010 AND Pr.ProductName LIKE '%Jasmine Rice%'
    GROUP BY S.StoreID, Pr.ProductName;
    
-- Question 7
SELECT SUM(P.SalesPrice * P.Quantity) AS `Total Revenue`, D.Quarter FROM Fact_ProductSales P
	INNER JOIN Dim_Date D ON P.SalesDateKey = D.DateKey
    INNER JOIN Dim_Store S ON P.StoreID = S.StoreID
    WHERE D.YEAR = 2016 AND S.StoreName = "ValueMart Boulder"
    GROUP BY D.QUARTER
    ORDER BY D.QUARTER ASC;

-- Question 8
SELECT C.CustomerName, SUM(P.SalesPrice) AS `Total Sales Price` FROM Fact_ProductSales P
	INNER JOIN Dim_Customer C ON P.CustomerID = C.CustomerID 
    WHERE C.CustomerName = "Melinda Gates" OR C.CustomerName = "Harrison Ford"
    GROUP BY C.CustomerID;
    
-- Question 9
SELECT S.StoreName, P.SalesPrice, Quantity FROM Fact_ProductSales P
	INNER JOIN Dim_Store S ON P.StoreID = S.StoreID
    INNER JOIN Dim_Date D ON P.SalesDateKey = D.DateKey
    WHERE D.YEAR = 2017 AND D.MONTHNAME = "March" AND D.DAYOFMONTH = 12;
    
-- Question 10
SELECT S.SalesPersonName, SUM(P.SalesPrice * P.Quantity) AS `Total Revenue` FROM Fact_ProductSales P
	INNER JOIN Dim_SalesPerson S ON P.SalesPersonID = S.SalesPersonID
    GROUP BY S.SalesPersonID
    ORDER BY `Total Revenue` DESC
    LIMIT 1;
    
-- Question 11

-- PLEASE NOTE
-- The instructions were ambiguous on this one on whether or not to show the total profit column
-- I interpreted the instructions to mean just show the product name (organized by highest total profit) but don't show the profit column
-- IF you meant show the profit column, just remove the outer Select statement from the below, and you'll get the top 3 product names and total profits organized by max profit.

SELECT x.ProductName FROM (
	SELECT Pr.ProductName, SUM((SalesPrice*Quantity)-(ProductCost*Quantity)) AS `Total Profit` FROM Fact_ProductSales P
		INNER JOIN Dim_Product Pr ON P.ProductID = Pr.ProductKey
		GROUP BY P.ProductID
		ORDER BY `Total Profit` DESC
		LIMIT 3
) as x;

-- Question 12

SELECT D.YEAR, D.MONTHNAME, SUM(P.SalesPrice * P.Quantity) AS `Total Revenue` FROM Fact_ProductSales P
    INNER JOIN Dim_Date D ON P.SalesDateKey = D.DateKey
    WHERE D.Year = 2017 AND D.MONTH >= 1 AND D.MONTH <= 3
    GROUP BY D.MONTHNAME;
    
-- Question 13
SELECT Pr.ProductName, ROUND(AVG(P.ProductCost),2) AS `Average Product Cost`, ROUND(AVG(P.SalesPrice),2) AS `Average Sales Price` FROM Fact_ProductSales P
	INNER JOIN Dim_Product Pr ON P.ProductID = Pr.ProductKey
    INNER JOIN Dim_Date D ON P.SalesDateKey = D.DateKey
    WHERE D.YEAR = 2017
    GROUP BY Pr.ProductName;
    
-- Question 14
SELECT C.CustomerName, ROUND(AVG(P.SalesPrice),2) AS `Average Sales Price`, ROUND(AVG(P.Quantity),2) AS `Average Quantity` FROM Fact_ProductSales P
	INNER JOIN Dim_Customer C ON P.CustomerID = C.CustomerID 
    WHERE C.CustomerName = "Melinda Gates"
    GROUP BY C.CustomerName;
    
-- Question 15
SELECT S.StoreName, ROUND(MAX(P.SalesPrice),2) AS `Maximum Sales Price`, ROUND(MIN(P.SalesPrice),2) AS `Minimum Sales Price` FROM Fact_ProductSales P
	INNER JOIN Dim_Store S ON P.StoreID = S.StoreID
    WHERE S.City = "Boulder"
    GROUP BY S.StoreName;
