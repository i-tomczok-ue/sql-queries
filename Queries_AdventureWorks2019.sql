-- From the following table write a query in SQL to retrieve all rows and columns from the employee table in the Adventureworks database. Sort the result set in ascending order on jobtitle.
-- Sample table: HumanResources.Employee

SELECT * FROM HumanResources.Employee
ORDER BY JobTitle ASC

-- From the following table write a query in SQL to retrieve all rows and columns from the employee table using table aliasing in the Adventureworks database. Sort the output in ascending order on lastname.
-- Sample table: Person.Person

SELECT * FROM Person.Person
ORDER BY LastName ASC

-- From the following table write a query in SQL to return all rows and a subset of the columns (FirstName, LastName, businessentityid) from the person table in the AdventureWorks database. 
-- The third column heading is renamed to Employee_id. Arranged the output in ascending order by lastname.
-- Sample table: Person.Person

SELECT FirstName, LastName, businessentityid AS Employee_id
FROM Person.Person
ORDER BY LastName ASC


-- From the following table write a query in SQL to return only the rows for product that have a sellstartdate that is not NULL and a productline of 'T'. 
-- Return productid, productnumber, and name. Arranged the output in ascending order on name.
-- Sample table: production.Product

SELECT productid, productnumber, name
FROM production.Product
WHERE SellStartDate IS NOT NULL AND ProductLine = 'T'
ORDER BY Name ASC


-- From the following table write a query in SQL to return all rows from the salesorderheader table in Adventureworks database and calculate the percentage of tax on the subtotal have decided. 
-- Return salesorderid, customerid, orderdate, subtotal, percentage of tax column. Arranged the result set in ascending order on subtotal.
-- Sample table: sales.salesorderheader

SELECT salesorderid, customerid, orderdate, subtotal, ((TaxAmt/SubTotal)*100) AS percentage_of_tax
FROM Sales.SalesOrderHeader
ORDER BY SubTotal ASC


-- From the following table write a query in SQL to create a list of unique jobtitles in the employee table in Adventureworks database. 
-- Return jobtitle column and arranged the resultset in ascending order.
-- Sample table: HumanResources.Employee

SELECT DISTINCT JobTitle
FROM HumanResources.Employee
ORDER BY JobTitle ASC

-- From the following table write a query in SQL to calculate the total freight paid by each customer. Return customerid and total freight. Sort the output in ascending order on customerid.
-- Sample table: sales.salesorderheader

SELECT CustomerID, SUM(Freight) AS TotalFreight
FROM sales.salesorderheader
GROUP BY CustomerID
ORDER BY CustomerID ASC


-- From the following table write a query in SQL to find the average and the sum of the subtotal for every customer. 
-- Return customerid, average and sum of the subtotal. Grouped the result on customerid and salespersonid. Sort the result on customerid column in descending order.
-- Sample table: sales.salesorderheader

SELECT CustomerID, SalesPersonID, SUM(SubTotal) AS TotalSubtotal, AVG(SubTotal) AS AvgSubtotal
FROM sales.salesorderheader
GROUP BY CustomerID, SalesPersonID
ORDER BY CustomerID DESC


-- From the following table write a query in SQL to retrieve total quantity of each productid which are in shelf of 'A' or 'C' or 'H'. 
-- Filter the results for sum quantity is more than 500. Return productid and sum of the quantity. Sort the results according to the productid in ascending order.
-- Sample table: production.productinventory

SELECT ProductID, SUM(Quantity) AS TotalQty
FROM production.productinventory
WHERE Shelf IN ('A', 'C', 'H')
GROUP BY ProductID
HAVING SUM(Quantity) > 500
ORDER BY ProductID ASC


-- From the following table write a query in SQL to find the total quentity for a group of locationid multiplied by 10.
-- Sample table: production.productinventory

SELECT LocationID, SUM(Quantity)*10 AS QtyMultiplied
FROM production.productinventory
GROUP BY LocationID


-- From the following tables write a query in SQL to find the persons whose last name starts with letter 'L'. Return BusinessEntityID, FirstName, LastName, and PhoneNumber. 
-- Sort the result on lastname and firstname.
-- Sample table: Person.PersonPhone
-- Sample table: Person.Person

SELECT pp.BusinessEntityID, p.FirstName, p.LastName, pp.PhoneNumber
FROM Person.PersonPhone AS pp
JOIN Person.Person AS p
ON pp.BusinessEntityID = p.BusinessEntityID
WHERE p.LastName LIKE 'L%'
ORDER BY p.LastName, p.FirstName


-- From the following table write a query in SQL to find the sum of subtotal column. Group the sum on distinct salespersonid and customerid. 
-- Rolls up the results into subtotal and running total. Return salespersonid, customerid and sum of subtotal column i.e. sum_subtotal.
-- Sample table: sales.salesorderheader

SELECT SalesPersonID, CustomerID, SUM(SubTotal) AS sum_subtotal
FROM sales.salesorderheader
GROUP BY ROLLUP(SalespersonID, CustomerID)


-- From the following table write a query in SQL to find the sum of the quantity of all combination of group of distinct locationid and shelf column. 
-- Return locationid, shelf and sum of quantity as TotalQuantity.
-- Sample table: production.productinventory

SELECT LocationID, Shelf, SUM(Quantity) AS TotalQty
FROM production.productinventory
GROUP BY CUBE(LocationID, Shelf)


-- From the following table write a query in SQL to find the sum of the quantity with subtotal for each locationid. 
-- Group the results for all combination of distinct locationid and shelf column. Rolls up the results into subtotal and running total. 
-- Return locationid, shelf and sum of quantity as TotalQuantity.
-- Sample table: production.productinventory

SELECT LocationID, Shelf, SUM(Quantity) AS TotalQty
FROM production.productinventory
GROUP BY GROUPING SETS (ROLLUP(LocationID, Shelf), CUBE(LocationID, Shelf))


-- From the following table write a query in SQL to find the total quantity for each locationid and calculate the grand-total for all locations. 
-- Return locationid and total quantity. Group the results on locationid.
-- Sample table: production.productinventory

SELECT LocationID, Shelf, SUM(Quantity) AS TotalQty
FROM production.productinventory
GROUP BY GROUPING SETS (ROLLUP(LocationID, Shelf), CUBE(LocationID, Shelf))


-- From the following table write a query in SQL to retrieve the number of employees for each City. 
-- Return city and number of employees. Sort the result in ascending order on city.
-- Sample table: Person.BusinessEntityAddress

SELECT a.City, COUNT(e.BusinessEntityID) AS NoOfEmp
FROM Person.BusinessEntityAddress AS e
JOIN Person.Address AS a
ON a.AddressID = e.AddressID
GROUP BY a.City
ORDER BY a.City ASC


-- From the following table write a query in SQL to retrieve the total sales for each year. Return the year part of order date and total due amount. 
-- Sort the result in ascending order on year part of order date.
-- Sample table: Sales.SalesOrderHeader

SELECT YEAR(OrderDate) AS Year, SUM(TotalDue) AS TotalDue
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)
ORDER BY YEAR(OrderDate) ASC


-- From the following table write a query in SQL to retrieve the total sales for each year. Filter the result set for those orders where order year is on or before 2016. 
-- Return the year part of orderdate and total due amount. Sort the result in ascending order on year part of order date.
-- Sample table: Sales.SalesOrderHeader

SELECT YEAR(OrderDate) AS Year, SUM(TotalDue) AS TotalDue
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) <= 2016
GROUP BY YEAR(OrderDate)
ORDER BY YEAR(OrderDate) ASC


-- From the following table write a query in SQL to find the contacts who are designated as a manager in various departments. Returns ContactTypeID, name. Sort the result set in descending order.
-- Sample table: Person.ContactType

SELECT ContactTypeID, Name 
FROM Person.ContactType
WHERE Name LIKE '%Manager%'
ORDER BY ContactTypeID DESC


-- From the following tables write a query in SQL to make a list of contacts who are designated as 'Purchasing Manager'. Return BusinessEntityID, LastName, and FirstName columns. 
-- Sort the result set in ascending order of LastName, and FirstName.
-- Sample table: Person.BusinessEntityContact
-- Sample table: Person.ContactType
-- Sample table: Person.Person

SELECT ec.BusinessEntityID, p.LastName, p.FirstName
FROM Person.BusinessEntityContact AS ec
JOIN Person.ContactType AS ct
ON ec.ContactTypeID = ct.ContactTypeID
JOIN Person.Person AS p
ON p.BusinessEntityID = ec.BusinessEntityID
WHERE ct.Name = 'Purchasing Manager'
ORDER BY p.LastName, p.FirstName ASC


-- From the following table write a query in SQL to count the number of contacts for combination of each type and name. 
-- Filter the output for those who have 100 or more contacts. Return ContactTypeID and ContactTypeName and BusinessEntityContact. 
-- Sort the result set in descending order on number of contacts.
-- Sample table: Person.BusinessEntityContact
-- Sample table: Person.ContactType

SELECT ct.ContactTypeID, ct.Name, COUNT(BusinessEntityID) AS NoOfContacts
FROM Person.BusinessEntityContact AS ec 
JOIN Person.ContactType AS ct
ON ec.ContactTypeID = ct.ContactTypeID 
GROUP BY ct.ContactTypeID, ct.Name
--HAVING COUNT(BusinessEntityID) > 100
ORDER BY COUNT(BusinessEntityID) DESC


-- From the following table write a query in SQL to retrieve the RateChangeDate, full name (first name, middle name and last name) and weekly salary (40 hours in a week) of employees. 
-- In the output the RateChangeDate should appears in date format. Sort the output in ascending order on NameInFull.
-- Sample table: HumanResources.EmployeePayHistory
-- Sample table: Person.Person

SELECT * FROM HumanResources.EmployeePayHistory -- RateChangeDate, BusinessEntityID
SELECT * FROM Person.Person -- full name, BusinessEntityID

SELECT	CAST(h.RateChangeDate AS VARCHAR(10)) AS FromDate,
		CONCAT(p.FirstName, ' ', p.MiddleName, ' ', p.LastName) AS NameInFull,
		(40 * h.Rate) AS WeeklySalary
FROM HumanResources.EmployeePayHistory AS h
JOIN Person.Person AS p
ON h.BusinessEntityID = p.BusinessEntityID
ORDER BY CONCAT(p.FirstName, ' ', p.MiddleName, ' ', p.LastName) ASC


-- From the following tables write a query in SQL to calculate and display the latest weekly salary of each employee. 
-- Return RateChangeDate, full name (first name, middle name and last name) and weekly salary (40 hours in a week) of employees Sort the output in ascending order on NameInFull.
-- Sample table: Person.Person
-- Sample table: HumanResources.EmployeePayHistory

WITH LatestChange AS (
	SELECT BusinessEntityID, MAX( RateChangeDate) AS LatestChange
	FROM HumanResources.EmployeePayHistory
	GROUP BY BusinessEntityID
)
SELECT	CAST(l.LatestChange AS VARCHAR(10)) AS FromDate,
		CONCAT(p.FirstName, ' ', p.MiddleName, ' ', p.LastName) AS NameInFull,
		(40 * h.Rate) AS WeeklySalary
FROM HumanResources.EmployeePayHistory AS h
JOIN Person.Person AS p
ON h.BusinessEntityID = p.BusinessEntityID
JOIN LatestChange AS l
ON l.BusinessEntityID = p.BusinessEntityID
ORDER BY CONCAT(p.FirstName, ' ', p.MiddleName, ' ', p.LastName) ASC


-- From the following table write a query in SQL to find the sum, average, count, minimum, and maximum order quentity for those orders whose id are 43659 and 43664. 
-- Return SalesOrderID, ProductID, OrderQty, sum, average, count, max, and min order quantity.
-- Sample table: Sales.SalesOrderDetail

SELECT	SalesOrderID, ProductID, OrderQty, SUM(OrderQty) AS SumOrderQty, 
		AVG(OrderQty) AS AvgOrderQty, COUNT(OrderQty) AS CountOrderQty, 
		MAX(OrderQty) AS MaxOrderQty, MIN(OrderQty) AS MinOrderQty
FROM Sales.SalesOrderDetail
WHERE SalesOrderID IN (43659, 43664)
GROUP BY SalesOrderID, ProductID, OrderQty
