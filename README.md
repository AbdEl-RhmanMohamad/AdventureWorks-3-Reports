# AdventureWorks Power BI Reports

This project involves designing and building three comprehensive Power BI reports (Overview, Operational, and Inventory) using the [AdventureWorks database](https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver15&tabs=ssms). Each report serves a specific purpose, providing key insights into different aspects of the business operations.

## Project Overview

### Requirements

1. **Overall Report:**
   - Displays company performance with a general view on areas, salespersons, order frequency, and products.

2. **Operational Report:**
   - Showcases sales team performance to facilitate rewards and comparisons, including performance metrics for the current and previous months and quarters.

3. **Inventory Report:**
   - Provides detailed information about product inventory, including stock levels, inventory turnover, and products nearing reorder points.

### Key Measures and Calculations

1. **Overall Report**
   - **Total Orders**
   - **Total Quantity**
   - **SubTotal**
   - **Total Due**
   - **Total Freight**
   - **Total Taxes**

2. **Operational Report**
   - **Sales Amount**
   - **Sales Percentage** 
   - **Comparison with Previous Month and Quarter

3. **Inventory Report**
   - **Total Inventory Value** 
   - **Current Stock Level** 
   - **Products Near Reorder Point**
     ```DAX
     Products Near Reorder Point = 
     IF (
         ISBLANK(
             CALCULATE(
                 COUNTROWS(vw_DimProducts),
                 FILTER(vw_DimProducts, vw_DimProducts[StockLevel] < vw_DimProducts[ReorderPoint])
             )
         ),
         "No Products Near Reorder Point",
         CALCULATE(
             COUNTROWS(vw_DimProducts),
             FILTER(vw_DimProducts, vw_DimProducts[StockLevel] < vw_DimProducts[ReorderPoint])
         )
     )
     ```
   - **Inventory Turnover:**
     ```DAX
     Inventory Turnover = DIVIDE([Cost of Goods Sold], AVERAGE(vw_DimProducts[StockLevel]))
     ```

## Visual Insights

### Overview Report
![Overview Report](https://github.com/user-attachments/assets/fe43d7fa-9e7b-4328-bad0-a755d89fe3a5)

- **Top Sales Persons:** Linda C Mitchell leads with $10.4M in sales.
- **Sales Amount by Category:** Bikes dominate the sales with $94.65M.
- **Sales by Territory:** Key regions contributing to sales.
- **Order Trends:** Orders by order date, due date, and ship date show a consistent trend throughout the quarters.

### Operational Report
![Operational Report](https://github.com/user-attachments/assets/e9435d8c-9d91-4ade-bdb1-b774ed3a7da8)


- **Top Sales Person:** Linda C Mitchell with $10.37M and 9.44% of total sales.
- **Sales Amount:** Total sales amounting to $109.85M.
- **Quarterly Performance:** Detailed performance metrics for each quarter.
- **Daily Sales:** Trend analysis of sales by day.

### Inventory Report
![Inventory Report](https://github.com/user-attachments/assets/f5cb05d4-6fb1-4fe4-96cc-2b9a52087cc9)

![TAT by Product](https://github.com/user-attachments/assets/3604b348-8d1f-4de9-8e13-243890c6dfed)


- **Current Stock Level by Category:** Highlighting categories with the most stock.
- **Products Near Reorder Point:** No products currently near reorder point.
- **Inventory Turnover:** Monthly trends showing fluctuations in inventory turnover.
- **Turnaround Time:** The time taken from when an order is placed for a product until it is restocked or becomes available again.
  ```DAX
  Turnaround Time = 
  AVERAGEX(
      vw_FactOrderDetails,
      DATEDIFF(vw_FactOrderDetails[OrderDate], vw_FactOrderDetails[RestockDate], DAY)
  )
  ```

## Conclusion

This Power BI project provides a robust framework for analyzing various facets of the AdventureWorks business operations, including sales performance, team efficiency, and inventory management. The insights gained from these reports can be pivotal for strategic decision-making and operational efficiency improvements.
