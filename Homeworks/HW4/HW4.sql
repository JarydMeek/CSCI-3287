-- QUESTION 1:
SELECT CompanyName, Country FROM hwSuppliers WHERE Country="Japan" OR Country="Germany";

-- QUESTION 2:
SELECT ProductName, QuantityPerUnit, UnitPrice FROM hwProducts WHERE UnitPrice<7 AND UnitPrice>4;

-- QUESTION 3:
SELECT CompanyName, City, Country FROM hwCustomers WHERE (Country="USA" and City="Portland") OR (Country="Canada" and City="Vancouver");

-- QUESTION 4:
SELECT ContactName, ContactTitle FROM hwSuppliers WHERE SupplierID>=5 AND SupplierID<=8 ORDER BY ContactName DESC;

-- QUESTION 5:
SELECT ProductNAme, UnitPrice FROM hwProducts WHERE UnitPrice=(SELECT UnitPrice FROM hwProducts ORDER BY UnitPrice LIMIT 1);

-- QUESTION 6:
-- Note: The wording on this one confuses me slightly, I assumed it to mean "Not USA and Not Shipped between 5/4 and 5/10" but if you meant "Not USA and Shipped between 5/4 and 5/10" just remove the NOT before Between :)
SELECT ShipCountry,COUNT(OrderID) AS OrderCount FROM hwOrders WHERE ShipCountry!="USA" AND ShippedDate NOT BETWEEN 2015-05-04 AND 2015-05-10 GROUP BY ShipCountry HAVING COUNT(OrderID)>3;

-- QUESTION 7:
SELECT FirstName,LastName,DATE_FORMAT(HireDate,'%m/%d/%Y') AS HireDate FROM hwEmployees WHERE Country!="USA" AND TIMESTAMPDIFF(YEAR,HireDate,NOW())>5;

-- QUESTION 8:
SELECT ProductName,(UnitsInStock*UnitPrice) AS InventoryValue FROM hwProducts WHERE (UnitsInStock*UnitPrice) > 3000 AND (UnitsInStock*UnitPrice) < 4000;

-- QUESTION 9:
SELECT ProductName,UnitsInStock,ReorderLevel FROM hwProducts WHERE ProductName LIKE "s%" AND UnitsInStock<ReorderLevel;

-- QUESTION 10:
SELECT ProductName,UnitPrice FROM hwProducts WHERE QuantityPerUnit LIKE "%box%" AND Discontinued=1;

-- QUESTION 11:
SELECT ProductName,(UnitsInStock*UnitPrice) AS InventoryValue FROM hwProducts INNER JOIN hwSuppliers ON hwProducts.SupplierID=hwSuppliers.SupplierID WHERE hwSuppliers.Country="Japan";

-- QUESTION 12:
SELECT Country,COUNT(CustomerID) AS CustomerCount FROM hwCustomers GROUP BY Country HAVING COUNT(CustomerID)>8;

-- QUESTION 13:
SELECT ShipCountry,ShipCity,COUNT(OrderID) AS OrderCount FROM hwOrders WHERE ShipCountry="Austria" OR ShipCountry="Argentina" GROUP BY ShipCountry,ShipCity;

-- QUESTION 14:
SELECT CompanyName,hwProducts.ProductName FROM hwSuppliers INNER JOIN hwProducts ON hwProducts.SupplierID=hwSuppliers.SupplierID WHERE Country="Spain";

-- QUESTION 15:
SELECT ROUND(AVG(UnitPrice),2) AS AveragePrice FROM hwProducts WHERE ProductName LIKE '%T';

-- QUESTION 16:
SELECT FirstName,LastName,Title,COUNT(OrderID) FROM hwEmployees INNER JOIN hwOrders ON hwEmployees.EmployeeID=hwOrders.EmployeeID GROUP BY hwEmployees.EmployeeID HAVING COUNT(OrderID)>120;

-- QUESTION 17:
SELECT hwCustomers.CustomerID, hwCustomers.Country FROM hwCustomers LEFT JOIN hwOrders ON hwCustomers.CustomerID = hwOrders.CustomerID WHERE hwOrders.CustomerID IS NULL;

-- QUESTION 18:
SELECT CategoryName,hwProducts.ProductName FROM hwCategories INNER JOIN hwProducts ON hwProducts.CategoryID=hwCategories.CategoryID WHERE hwProducts.UnitsInStock=0;

-- QUESTION 19:
SELECT ProductName,QuantityPerUnit FROM hwProducts INNER JOIN hwSuppliers ON hwProducts.SupplierID=hwSuppliers.SupplierID WHERE (hwProducts.QuantityPerUnit LIKE "%pkg%" OR hwProducts.QuantityPerUnit LIKE "%jars%") AND hwSuppliers.Country="Japan";

-- QUESTION 20:
SELECT CompanyName,ShipName,round(SUM((UnitPrice*Quantity)-Discount),2) AS TotalValue FROM hwCustomers INNER JOIN hwOrders ON hwCustomers.CustomerID=hwOrders.CustomerID INNER JOIN hwOrderDetails ON hwOrderDetails.OrderID=hwOrders.OrderID  WHERE Country="Mexico" GROUP BY hwCustomers.CustomerID,hwOrders.shipName;

-- QUESTION 21:
SELECT ProductName,Region FROM hwProducts INNER JOIN hwSuppliers ON hwProducts.SupplierID=hwSuppliers.SupplierID WHERE ProductName LIKE 'L%' AND Region IS NOT NULL AND TRIM(Region) !=  "";

-- QUESTION 22:
SELECT ShipCountry,ShipName,DATE_FORMAT(OrderDate,'%M %Y') AS OrderDate FROM hwOrders LEFT JOIN hwCustomers ON hwOrders.CustomerID=hwCustomers.CustomerID and ShipCity="Versailles" and hwCustomers.CustomerID IS NULL;

-- QUESTION 23:
SELECT ProductName,UnitsInStock, RANK () OVER ( ORDER BY UnitsInStock DESC) AS RankPosition FROM hwProducts WHERE ProductName LIKE 'F%' LIMIT 5;

-- QUESTION 24:
SELECT ProductName,UnitPrice, RANK () OVER ( ORDER BY UnitPrice ASC) AS RankPosition FROM hwProducts WHERE ProductID >=1 and ProductID <= 5 LIMIT 5;

-- QUESTION 25:
SELECT FirstName,LastName,Country,DATE_FORMAT(BirthDate,'%m/%d/%Y') AS BirthDate,RANK() OVER(PARTITION BY Country ORDER BY BirthDate asc) RankPosition FROM hwEmployees WHERE YEAR(BirthDate) > 1984 ORDER BY Country,RankPosition;