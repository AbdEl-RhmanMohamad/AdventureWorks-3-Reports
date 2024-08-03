/* Creating views for fact and dim tables
AbdEl-Rhman Ashraf
27/07/2024
ITI - Power BI Track
*/

create view V_Dim_Territory
AS
SELECT [TerritoryID]
      ,[Name] as [Territory Name]
      ,[CountryRegionCode]
      ,[Group]
FROM [AdventureWorks2022].[Sales].[SalesTerritory];



-------------------------------------
create view V_Dim_ShipMethod
AS
SELECT [ShipMethodID]
      ,[Name] as ShipMethod
FROM [AdventureWorks2022].[Purchasing].[ShipMethod];



----------------------------------------------------------
Alter VIEW V_Dim_Product
AS
SELECT p.[ProductID]
      ,p.[Name] as [Product Name]
      ,p.[Color]
	  ,p.[StandardCost]
      ,p.[SafetyStockLevel]
      ,p.[ReorderPoint]
      ,p.[Class]
      ,p.[Style]
      ,p.[ProductSubcategoryID]
	  ,ps.[Name] as [ProductSubCategory]
	  ,pc.[ProductCategoryID]
	  ,pc.[Name] as [ProductCategory]
FROM [AdventureWorks2022].[Production].[Product] as p
LEFT JOIN [Production].[ProductSubcategory] as ps
on p.ProductSubcategoryID = ps.ProductSubcategoryID
left join [Production].[ProductCategory] as pc
on ps.ProductCategoryID = pc.ProductCategoryID;


----------------------------------------------------------
CREATE VIEW V_FactSales
AS
SELECT sod.[SalesOrderID]
      ,sod.[SalesOrderDetailID]
      ,sod.[OrderQty]
      ,sod.[ProductID]
      ,sod.[UnitPrice]
      ,sod.[UnitPriceDiscount]
      ,sod.[LineTotal]
	  ,CAST(FORMAT(soh.[OrderDate], 'yyyMMdd') AS int) as [OrderDate]
      ,CAST(FORMAT(soh.[DueDate], 'yyyMMdd') AS int) as [DueDate]
      ,CAST(FORMAT(soh.[ShipDate], 'yyyMMdd') AS int) as [ShipDate]
	  ,soh.[OrderDate] as [OrderDateAsDate]
	  ,soh.[Status]
      ,soh.[OnlineOrderFlag]
      ,soh.[SalesPersonID]
	  ,soh.[TerritoryID]
	  ,soh.[ShipMethodID]
	  ,(sod.LineTotal * soh.Freight) / soh.SubTotal as [Freight]
	  ,(sod.LineTotal * soh.TaxAmt) / soh.SubTotal as [Tax]
	  ,p.[SellEndDate]
FROM [AdventureWorks2022].[Sales].[SalesOrderDetail] as sod
left join [AdventureWorks2022].[Sales].[SalesOrderHeader] as soh
on sod.SalesOrderID = soh.SalesOrderID
left join [AdventureWorks2022].[Production].[Product] as p
on sod.ProductID = p.ProductID;
-----------------------------------------------------------------------------------
