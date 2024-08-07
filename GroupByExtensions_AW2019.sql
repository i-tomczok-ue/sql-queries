-- GROUP BY extensions
--     ROLLUP
--     CUBE
--     GROUPING ID
--     GROUPING SETS

-- Oblicz ca³kowit¹ liczbê sprzedanych sztuk (OrderQty) dla ka¿dego produktu (ProductID) i ka¿dej promocji (SpecialOfferID), 
-- uwzglêdniaj¹c dodatkowo ca³kowit¹ liczbê sprzedanych sztuk dla ka¿dego produktu oraz ogólnie.

select * from sales.salesorderdetail

select ISNULL(ProductID, 0) as prod_id, ISNULL(SpecialOfferID, 0) as spec_offer_id, SUM(OrderQty) as totalQty -- ISNULL() for MS SQL / NVL() for Oracle
from sales.salesorderdetail
group by rollup(ISNULL(ProductID, 0), ISNULL(SpecialOfferID, 0))
 

-- Oblicz ca³kowit¹ wartoœæ sprzeda¿y (TotalDue) dla ka¿dego roku, miesi¹ca i dla ca³ego okresu.

select * from Sales.SalesOrderHeader

select YEAR(OrderDate) as year, MONTH(OrderDate) as month, sum(TotalDue) as TotalDue
from Sales.SalesOrderHeader
group by rollup(YEAR(OrderDate), MONTH(OrderDate))


-- Oblicz sumê iloœci (OrderQty) sprzedanych produktów dla ka¿dego produktu (ProductID) i ka¿dej promocji (SpecialOfferID).

select * from Sales.SalesOrderDetail

select ISNULL(ProductID, 0) as prod_id, ISNULL(SpecialOfferID, 0) as spec_offer_id, SUM(OrderQty) as totalQty
from sales.salesorderdetail
group by cube(ISNULL(ProductID, 0), ISNULL(SpecialOfferID, 0))


-- Oblicz ca³kowit¹ sprzeda¿ (TotalDue) dla ka¿dego roku, miesi¹ca oraz ca³kowit¹ sprzeda¿ dla ka¿dego roku.

select * from Sales.SalesOrderHeader

select YEAR(OrderDate) as year, MONTH(OrderDate) as month, sum(TotalDue) as TotalDue
from Sales.SalesOrderHeader
group by grouping sets((YEAR(OrderDate), MONTH(OrderDate)), YEAR(OrderDate), ())


-- Wyœwietl ca³kowit¹ wartoœæ sprzeda¿y (TotalDue) dla ka¿dego roku i miesi¹ca. Dodaj kolumnê, która poka¿e poziom grupowania (YEAR lub MONTH) za pomoc¹ GROUPING_ID.

select * from Sales.SalesOrderHeader

select YEAR(OrderDate) as year, MONTH(OrderDate) as month, sum(TotalDue) as TotalDue, grouping_id(YEAR(OrderDate), MONTH(OrderDate)) as g_id
from Sales.SalesOrderHeader
group by rollup(YEAR(OrderDate), MONTH(OrderDate))


-- Oblicz œredni¹ wagê produktów (Weight) dla ka¿dej kategorii (ProductCategoryID) i ka¿dej subkategorii (ProductSubcategoryID). 
-- U¿yj ROLLUP, aby dodatkowo obliczyæ œredni¹ wagê dla ka¿dej kategorii i ogólnie.

select * from Production.ProductSubcategory

select ppc.ProductCategoryID as cat_id, pp.ProductSubcategoryId as sub_cat_id, avg(pp.weight) as avg_w
from Production.Product as pp
join Production.ProductSubcategory as ppc
on pp.ProductSubcategoryID = ppc.ProductSubcategoryID
group by rollup(ppc.ProductCategoryID, pp.ProductSubcategoryId)


-- Policz liczbê pracowników dla ka¿dej p³ci (Gender) i ka¿dego statusu zatrudnienia (SalariedFlag). U¿yj CUBE, aby uwzglêdniæ wszystkie kombinacje.

SELECT * FROM HumanResources.Employee

SELECT Gender, SalariedFlag, COUNT(*) AS n
FROM HumanResources.Employee
GROUP BY CUBE(Gender, SalariedFlag)


-- Oblicz liczbê klientów dla ka¿dego terytorium (TerritoryID) oraz globalnie. U¿yj GROUPING SETS, aby zdefiniowaæ te grupy.

select * from Sales.Customer

select TerritoryID, count(*) as n
from Sales.Customer
group by grouping sets(TerritoryID, ())


-- Oblicz ca³kowit¹ wartoœæ sprzeda¿y (LineTotal) dla ka¿dego produktu (ProductID) i promocji (SpecialOfferID). Dodaj kolumnê z poziomem grupowania za pomoc¹ GROUPING_ID.

select * from Sales.SalesOrderDetail

select ProductID, SpecialOfferID, sum(linetotal) as total, GROUPING_ID(ProductID, SpecialOfferID)
from Sales.SalesOrderDetail
group by cube(ProductID, SpecialOfferID)


-- Oblicz ca³kowit¹ wartoœæ zamówieñ (TotalDue) dla ka¿dego dostawcy (VendorID) i ka¿dego roku. 
-- U¿yj ROLLUP, aby uwzglêdniæ ca³kowit¹ wartoœæ zamówieñ dla ka¿dego dostawcy oraz ca³kowit¹ wartoœæ zamówieñ ogó³em.

select * from Purchasing.PurchaseOrderHeader

select VendorId, YEAR(OrderDate) as year, sum(TotalDue) as totalDue
from Purchasing.PurchaseOrderHeader
group by rollup(VendorId, YEAR(OrderDate))


-- Oblicz œrednie wynagrodzenie (Rate) dla ka¿dego typu zatrudnienia (EmploymentType), dla ka¿dej p³ci (Gender) oraz ogólnie.

select * from HumanResources.Employee -- Gender / zmiana EmploymentType na OrganizationLevel
select * from HumanResources.EmployeePayHistory -- Rate

select e.Gender, e.OrganizationLevel, avg(eh.Rate) as avg_rate
from HumanResources.Employee as e
join HumanResources.EmployeePayHistory as eh
on e.BusinessEntityID = eh.BusinessEntityID
where e.Gender is not null and e.OrganizationLevel is not null
group by grouping sets((e.Gender, e.OrganizationLevel), e.Gender, e.OrganizationLevel, ())


-- Oblicz ca³kowit¹ wartoœæ sprzeda¿y (SalesYTD) dla ka¿dego terytorium (TerritoryID) i ka¿dego kraju regionu (CountryRegionCode), dodaj¹c poziom grupowania za pomoc¹ GROUPING_ID.

select * from Sales.SalesTerritory

select TerritoryID, CountryRegionCode, sum(SalesYTD) AS totalSales, GROUPING_ID(TerritoryID, CountryRegionCode) as g_id
from Sales.SalesTerritory
GROUP BY CUBE(TerritoryID, CountryRegionCode)


-- Policz liczbê pracowników w ka¿dym dziale (DepartmentID) oraz ka¿dej grupie (GroupName), uwzglêdniaj¹c wszystkie mo¿liwe kombinacje.

select * from HumanResources.Department -- DepartmentID, GroupName
select * from HumanResources.EmployeeDepartmentHistory

select d.DepartmentID, d.GroupName, count(e.BusinessEntityID) as n
from HumanResources.Department as d
join HumanResources.EmployeeDepartmentHistory as e
on d.DepartmentID = e.DepartmentID
group by cube(d.DepartmentID, d.GroupName)


-- Oblicz ca³kowit¹ sprzeda¿ (SalesYTD) dla ka¿dego sprzedawcy (SalesPersonID) i ka¿dego terytorium (TerritoryID), dodaj¹c poziom grupowania za pomoc¹ GROUPING_ID.

select * from sales.SalesPerson

select BusinessEntityID, TerritoryID, sum(SalesYTD) AS totalSales, GROUPING_ID(BusinessEntityID, TerritoryID) as g_id
from sales.SalesPerson
where TerritoryID is not null
group by cube(BusinessEntityID, TerritoryID)


-- Policz liczbê transakcji (TransactionID) dla ka¿dego typu transakcji (TransactionType) i ka¿dego produktu (ProductID), uwzglêdniaj¹c wszystkie mo¿liwe kombinacje.

select * from Production.TransactionHistory

select TransactionType, ProductID, count(TransactionID) as n
from Production.TransactionHistory
group by cube(TransactionType, ProductID)


