## Power bi Project

Greetings! This is a project that is based in Power bi that transforms and cleans a dataset,create relationships and builds reports within Power bi. This will be a guide to the project,documenting each process and any troubleshooting you could encounter along the way, if any.

### Table of contents

* Description of file types
* Power bi - How do you get the data?
* Data transform/cleaning
* Create a data model and relationship between data tables
* How to create a date table
* Create relationships between the data
* Organising the data by creating a new measure table
* Date and Geography Hierachy 
* Building reports within Power bi
    1. Customer detail
    2. Executive Summary
    3. Product detail
    4. Stores Map
    5. Tools tip TAB

* Cross filtering and Navigation 
* Trouble shooting in the project
* Postgresql Queries



### Description of file types

Text.csv - this is a text file and that the text is seperated by commas(csv). The csv stands for comma seperated values.

Local folder - this is a folder that is stored on your computer.Files stored on your desktop works best for easy access in Power bi's get data

Microsoft Azure - Depending on which system you run depends on whether you need to use Azure for this project.                                                                         
However, if you have a mac or are a linux user, then you need to create a virtual machine in Azure by creating a new account and following instructions on how to set one up. This could incur costs so be mindful of your time you spend on this project or using the virtual machine. Azure do offer a $200 credit upon opening your account but this is time limited. Here is the link to the doc on how to set that up https://learn.microsoft.com/en-us/azure/virtual-machines/windows/quick-create-portal. You can pay for the subscription of $85 a month, but that is only if you feel it would be beneficial for your usage and is not needed for this project. 

Power bi - If you use windows, you can download Power bi here for direct source  https://powerbi.microsoft.com/en-gb/landing/free-account/?ef_id=_k_c86f5521357318286277304a9325acff_k_&OCID=AIDcmmmhj6wa7w_SEM__k_c86f5521357318286277304a9325acff_k_&msclkid=c86f5521357318286277304a9325acff

Azure SQL Database - this project uses the course database credentials 

Azure Blob storage - this project uses the course database credentials 


### Power bi - How do you get the data?

Power bi has the ability to import data from many sources. This project covers 4 different ways you could do this. 

1. Azure SQL database - In Power bi, go to 'get data' tab on the ribbon, click on it and a drop down menu appears, 
go to Azure SQL database and you will need the server name and credentials of the owner of the database to connect, once connected we can now transform the data.

2. Text.csv - This file is usually downloaded from your source to the local computer and in Power bi, go to 'get data' tab on the ribbon and a drop down menu appears, go to text/CSV and double click, this will open a link to your local computer, find the file and import, the data is ready to be transformed.

3. Azure Blob storage - In power bi, go to the 'get data' tab on the ribbon, scroll down to Azure Blob Storage, click on it, you will need the account name,account key and container name of the owner of the database, we can transform the data.

4. Customers Zip file - This file is stored on your local computer as a zip folder. In power bi, go to 'get data' tab on the ribbon, click on it and a drop down menu appears, find folder, it looks like a yellow folder, click on it, it will ask you for the folder path, click browse and add the folder, your data is ready to be transformed. 

### Data transform/cleaning 

Once you have all the data, we can now clean and transform the data. 

1. Orders - The orders table contains the following data, information about each order, including the order and shipping dates, the customer, store and product IDs for associating with dimension tables, and the amount of each product ordered.
Only one single product per order, so there is only one code per order. 
The data transformed here as follows: Deleted the card number column, this is because the data should be kept private, split the order date and shipping date into two seperate columns of date and time and re-named them, filled in any nulls in order date, by filtering the blanks. Re-named all the columns to the correct format in Power bi.

2. Products - The products table contains products sold by the company, including the product code, name, category, cost price, sale price, and weight. 
The data transformed here as follows: removed duplicates from product code, split the weight column by 'kg' and 'g',converted the values to decimal numbers, replaced any errors with 1, deleted the columns after the split weights.Re-named all the columns to the correct format in Power bi.

3. Stores - The stores table contains information about each store, including the store code, store type, country, region, and address. 
The data transformed here as follows: re-named all the columns to the correct format in Power bi. 

4. Customers - The customers table contains information address,company,country,country code,date of birth,email,full name,join date and telephone.
The data transformed here as follows: join first name and last name and create a new column with full name, deleted irrelevant columns and re-named the columns to the correct format in power bi.

### Create a data model and relationship between data tables

Power bi time intelligence and Dax functions enable the date to be continuously calculated at different periods of time so that you can query year end, month end and so on. 
To make use of Power bi time intelligence, a date table is created and is used so that it captures different points in time so that the data can be compared with each other for example sales last year to this year. 

#### How to create a date table 

1.A date table is created to store the time intelligence columns so we can start creating the table.
The DAX functions have been included here and can be used with any dataset you have, you just change the name of the columns.

DAX function that creates the earliest date to the latest date.

Date Table = 
VAR MinDate = CALCULATE(MIN(Orders[Order Date]), ALL(Orders))
VAR MaxDate = CALCULATE(MAX(Orders[Shipping Date]), ALL(Orders))
RETURN
CALENDAR(EOMONTH(MinDate, -1) + 1, EOMONTH(MaxDate, 0) + 1)

2. Add columns to the date table

•	Day of Week
•	Month Number (i.e. Jan = 1, Dec = 12 etc.)
•	Month Name
•	Quarter
•	Year
•	Start of Year
•	Start of Quarter
•	Start of Month
•	Start of Week
 
DAX function for Day of the Week:

Day of the week = WEEKDAY([Date], 2) // 2 means Monday = 1, Sunday = 7

DAX function for End of Quarter:

End of Quarter = ENDOFQUARTER('Date Table'[Date])

DAX function for Month Name:

Month name = FORMAT([Date], "mmmm")

DAX function for Month Number:

Month number = MONTH([Date])

DAX function for Month Name:

Month name = FORMAT([Date], "mmmm")

DAX function for Quarter

Quarter = QUARTER('Date Table'[Date]) // This is similar to month number function 

DAX function for Year

Year = YEAR('Date Table'[Date])

DAX function of Start of year

Start of year = STARTOFYEAR('Date Table'[Date])

DAX function of start of Month

Start of Month = STARTOFMONTH('Date Table'[Date])

DAX function of start of week

Start of week = 'Date Table'[Date] - WEEKDAY('Date Table'[Date], 2) + 1

### Create relationships between the data 

3.In this dataset, the following forms a star schema:

The way to create relationships between the data, we copy the column in each table and it creates a one-to-many relationship.

Orders[product_code] to Products[product_code]
Orders[Store Code] to Stores[store code]
Orders[User ID] to Customers[User ID]
Orders[Order Date] to Date[date]
Orders[Shipping Date] to Date[date]

### Organising the data by creating a new measure table 

4.The data will need to organised, so create a new measure table. This is helpful if you keep your calculations in a table so they can be easily accessible. 

- Create a new table in the model view in Power editor,go to enter data on the home ribbon, name it measure table and load. 

- Create the key measures in this table. 

DAX function for Total orders:

Total orders = COUNT(Orders[Product Quantity])

DAX function for Total revenue:

Total Revenue = SUMX(Orders, Orders[Product Quantity] * RELATED(Products[Sale price]))

DAX function for Total profit:

Total Profit = SUMX(Orders, (RELATED(Products[Sale price]) - RELATED(Products[Cost price])) * Orders[Product Quantity])

DAX function for Total customers:

Total customers = DISTINCTCOUNT(Orders[User ID])

DAX function for Total quantity:

Total Quantity = SUM(Orders[Product Quantity])

DAX function for Profit YTD:

Profit YTD = CALCULATE(SUM('Orders'[Product Quantity]), DATESYTD('Date Table'[Date]))

DAX function for Revenue YTD:

Revenue YTD = CALCULATE(SUMX(Orders, Orders[Product Quantity] * RELATED(Products[Sale price])), DATESYTD('Date Table'[Date]))


## Date and Geography Hierachy 

Hierarchies allow the ability for filters to be added to the data so that it can drilled down within a line chart.
 
 Date hierarchy

 * Start of Year
 * Start of Quarter
 * Start of Month
 * Start of Week

Geography hierarchy

* Region
* Country
* Country Region


A new column for the full country name

Geography = Stores[Region] & ", " & Stores[Country]

Create a new calculated column created so that it will take 'GB' and switch it to 'United Kingdom'

Dax function 

Country = 
    SWITCH (
        Stores[Country Code],
        "GB", "United Kingdom",
        "US", "United States",
        "DE", "Germany",
        Stores[Country Code]
    )



The following change the data category by going to the table view, in column tools change the data category from the drop down menu. 

World Region : Continent
Country : Country
Country Region: State or Province

## Building reports within Power bi 

There are many ways to add analysis to your report that use many different types of visuals. The following gives a good example of how you can create useful dashboard for managers. 

1. Customer Analysis report

Customer dashboard (PowerbiProject4)

- In the bottom ribbon, add a new tab and name it customer detail. 
- In the measure table go to the Total customers table, change the name to the Unique customers instead for the report view. 
- Create a new measure that calculates revenue per customer:

DAX function for revenue per customer:

Revenue Per Customer = DIVIDE(SUM('Orders'[Total Revenue]),('Measure table'[Unique Customers]))

DAX function for Top customer by revenue:

Total Revenue Top Customer = MAXX(TOPN(1,SUMMARIZE(Orders, Customers[Full name], "Total Revenue", [Revenue per Customer]), 
[Total Revenue], DESC),[Total Revenue])

DAX customer for Top customer:

Top Customer = MAXX(TOPN(1, VALUES(Customers[Full name]),[Total Revenue Top Customer],DESC),Customers[Full name])

DAX function for orders by Top customer: 

Number of Orders by Top Customer = MAXX(TOPN(1, SUMMARIZE(Orders, Customers[Full name], "Total Orders", COUNT(Orders[Product Quantity])), [Total Orders], DESC), [Total Orders])


- Insert new visual in the ribbon, find the card visual from the dropdown menu.

- Create two cards, one for Unique customers from the measure table and the second Revenue per customer.

- Insert new visual in the ribbon, find the donut chart and add customers[Country] in the legend and Unique customers in the values.

- Insert new visual in the ribbon, find the column chart and add Products[Category] in the y axis and Unique customers in the X axis 

- Insert new visual in the ribbon, find the line chart  and add Unique customers in the Y axis and Date hierarchy in the x axis, take out date, start of the week leave start of quarter,start of month and start of year. 
In this line chart, as you set up the line chart, go straight to visual and go to forecast, switch it on, forecast 10 with 95% interval.

- Insert new visual, create a table for the top 20 customers by revenue. In the column section, add Full name,Revenue per customer,Total Orders. 

- Insert new visual, create 3 cards, one that contains the top customer, no of orders per customer, total revenue generated per top customer.

-  Finally, add a date slicer, go to slicer settings in  the format visual pane and choose in between.

You can now edit interactions so that the visuals will work together, by double clicking a visual on the page and choosing the graph symbol above the visual, click on them all for now. This is a good time to set your colour theme for the project. 

2. Executive summary 

Executive summary (PowerbiProject5)

To save time, when you have already created a report, you can, right click and copy from the visuals from the previously created customer detail. This will copy the colours and format for you and save time, it also gives your reports consistency. This can be done throughout this summary so if any need to be created, copy from the customer detail and change the values. 

- Create 3 cards and from your measure table, add the following, Total revenue,Total Orders and Total profit.

DAX functions for Total Revenue: 

Total Revenue = SUMX('Orders', 'Orders'[Product Quantity] * RELATED('Products'[Sale price])) 

DAX function for Total Orders:

Total Orders = SUM(Orders[Product Quantity])  

DAX function for Total Profit:

Total Profit = SUMX(Orders, (RELATED(Products[Sale price]) - RELATED(Products[Cost price])) * Orders[Product Quantity]) 

- Before you create a revenue trend chart, create a measure for Total Revenue Date:

Total Revenue Date = 
CALCULATE(
    SUMX('Orders', 'Orders'[Product Quantity] * RELATED('Products'[Sale price])),
    FILTER(
        ALL('Orders'),
        'Orders'[Order Date] >= DATE(2010, 01, 1) && 'Orders'[Order Date] <= DATE(2023, 09, 31)
    )
)

- Add a revenue trending line chart

In the x Axis, use the date hierachy, start of year, start of quarter, start of month
In the y Axis, Total revenue Date. 

- Create 2 donuts, add Total revenue  by Store[Country] and Store[Country]

- Add a clustered bar chart by Products[Category] and Total Orders from the measure table.

- Create 3 KPI cards. This part is tricky because you have to create columns out of the measure table DAX functions so that it will work for all 3 columns chosen. Otherwise, you will get BLANK in your visuals.

- This is done in two parts, first in the measure table, create a new measure for Previous Quarter Profit, Previous Quarter Revenue and Previous Quarter Orders, Targets, equal to 5% growth in each measure compared to the previous quarter.

- Create a new column in Products:

DAX function for Row Profit

Row Profit = 'Products'[Sale price] - 'Products'[Cost price] 

- Create calculated columns in Orders:

- Total Revenue,Total Orders and Total Profit, previously as measures.

- Create 3 new measures in the measure table: 

DAX function for Previous Quarter Profit:

The reason why the extra daily profit has been created is because Total profit was just giving the same value in the column, this way if it's calculated daily, the DAX function takes each row and works out the daily profit and sums up the previous quarter and is more accurate. Sometimes, the data, can be empty,this could be due to the previous quarter having no sales.

Previous Quarter Profit = CALCULATE(SUM('Products'[Row Profit]), PREVIOUSQUARTER('Date Table'[Date]))

or

Previous Quarter Profit = CALCULATE(SUM('Orders'[Total Profit]),PREVIOUSQUARTER('Date Table'[Date]))

DAX function for Previous Quarter Revenue:

Previous Quarter Revenue = CALCULATE([Total Revenue], PREVIOUSQUARTER('Date Table'[Date]))

DAX function for Previous Quarter Orders:

Previous Quarter Orders = CALCULATE(SUM('Orders'[Product Quantity]), PREVIOUSQUARTER('Date Table'[Date]))

- Create the targets for each previous quarter increase by 5%.

DAX function for Target Revenue:

Target Revenue = [Previous Quarter Revenue] * 0.05 

DAX function for Target Profit: 

Target Profit = [Previous Quarter Profit] * 0.05

DAX function for Target Orders:

Target Orders = [Previous Quarter Orders] * 0.05

Now add the 3 visual KPI cards: 

- Value : Total Revenue, Axis x: Date Hierachy: Start of Quarter, Target: Target Profit
- Value : Total Orders, Axis x: Date Hierachy: Start of Quarter, Target: Target Profit 
- Value : Total Profit, Axis x: Date Hierchhy: Start of Quarter, Target: Target Profit

Format so that it shows the trend axis as Direction : High is Good,Bad Colour : red,Transparency : 15%, set the callout 
value to that is show to 1 decimal place. 

You can now edit interactions, this enables the report page to link with each visual, double click on the page
and go to the ribbon,edit interations, then click the graph symbol to enable the links.
 

3. Product detail report

Product Detail report (PowerbiProject6)

- Create a new measure in Date Table:

Quarter = FORMAT('Date Table'[Date],"\QTR q")

- Create the following Dax measures in the Measure table:

DAX function for Current Quarter Orders:

Current Quarter Orders = CALCULATE(SUM('Orders'[Product Quantity]),'Date Table'[Year] = YEAR(TODAY()),'Date Table'[Start of Quarter] = "Q" & QUARTER(TODAY()))

Dax function for Current Quarter Profit:

Current Quarter Profit = VAR __Quarter = "Q" & QUARTER (TODAY ()) VAR __Result = Calculate (SUM (Orders[Total Profit])/12, FILTER ('Date Table','Date Table' [Year]=2023 && 'Date Table' [Quarter]=__Quarter)) RETURN __Result

Dax function for Current Quarter Revenue:

Current Quarter Profit = VAR __Quarter = "Q" & QUARTER (TODAY ()) VAR __Result = Calculate (SUM ('Orders'[Total Revenue])/12, FILTER ('Date Table','Date Table' [Year]=2023 && 'Date Table' [Quarter]=__Quarter)) RETURN __Result

Dax function for Current Quarter Orders Target:

Current Quarter Orders Target = [Current Quarter Orders] * 0.10

Dax function for Current Quarter Profit:

Current Quarter Profit Target = [Current Quarter Profit] * 0.10

Dax function for Current Quarter Revenue:

Current Quarter Revenue Target = [Current Quarter Revenue] * 0.10

Set the callout value in the gauge Axis for the gauges to show if the target is met and use red and your normal colours for the rest. 

- Create two rectangle shapes with your chosen colour theme. These will be used for slicers.

- Create a new calculated column in Orders:

Profit per Order = (RELATED('Products'[Sale price]) - RELATED('Products'[Cost price])) * 'Orders'[Product Quantity]

- Add an area chart and build a visual, Axis x: Date Hierachy: Start of Quarter, Axis y: Total Revenue, Category:Legend

- Add a table and add the following, Description,Total Revenue,Total Customers,Total Orders,Profit per Order. Disp;ay the 
top 5 Products.

- Create a calculated column in Orders:

Profit per Item = CALCULATE(SUM('Products'[Row Profit])) / CALCULATE(SUM('Orders'[Product Quantity]))

- Find the scatter chart, add the following to it, Values should be Products[Description],Axis x: should be Products[Profit per Item],Axis Y, should be Products[Total Quantity] and Legend should be Products[Category]. Correct the title appropriately.

Sometimes, in report dashboards, it might be a good idea to be able to hide a side bar with the slicers inside so that, it can be used when needed. 

- This can be tricky! The shape that is needed to create this side bar, can get in the way! you can try the following, 
Create a side bar, the same size as your slicer width, so it shows the values. Click on the shape and edit interactions, put the shape to the front. Now you can add two slicers that are vertical lists, one for Products[Category] to select all and one for Stores[Country].
Put them both inside the side bar and edit interations and put to the front. 

- Create a button that opens the side bar, in selection, make sure all a visable. Go to format, Action and choose bookmark slicer open and in the action text, Open slicer panel. Bookmark Side Slicer open

- Create a back button that closes the side bar, in selection, make sure 2 slicers and shape is not visable. Go to format,Action, choose bookmark slicer closed and in the action text, Slicer bar closed.

To access the open and close buttons, press ctrl and click. 

4. Create a Stores Map

Stores Map (PowerbiProject7)

- Go to the visual ribbon, go to maps, choose Arcgis maps for powerbi, format map tools and make sure zoom is clicked on. 

- Add the following location: Geography, Stores[Latitude] and Stores[longitude], size profit ytd and tooltips store code.

- Add a tile slicer  for Stores [Country] that includes select all.

5. Create a Stores drilldown

- Create a new tab and call it Stores drilldown. In the page information, name the page drilldown and choose Stores[Country] and Stores[Region] for the bits that will drilldown. Choose Used as category for the drill through from. 

- Create new measures for Profit Goal:

Profit Goal = 
VAR Profit_LastYear = CALCULATE([Profit YTD], SAMEPERIODLASTYEAR('Date Table'[Date]))
RETURN Profit_LastYear * 1.20

- Create new measures for Revenue Goal:

Revenue Goal = 
VAR Revenue_LastYear = CALCULATE([Revenue YTD], SAMEPERIODLASTYEAR('Date Table'[Date]))
RETURN Revenue_LastYear * 1.20

Use previously created measures for Profit YTD and Revenue YTD. 

- Create a gauge to represent Profit YTD, Target , Profit Goal
- Create a guage to represent Revenue YTD, Target, Revenue Goal

- Add a table, displaying the top 5 products by revenue, include Description, Profit YTD, Total Orders, Total Revenue.

- Add a column chart, Axis x: Category, Axis y: Total orders, Legend: Store code 

- A Card visual showing the currently selected store, Choose Stores[Store code]

Finally, create a new ToolTips TAB, add the Profit YTD and Profit goal gauge and set the page information to tooltips and select show tooltip on, Profit YTD, Profit Goal, Country,Region, Geography,Latitude and longitude. Show Tooltip when Profit YTD is summerized,Profit Goal is summerized,Country,Region,Geography,Latitude and Longitude is Used as category.

5. ## Cross filtering and Navigation 

Cross filtering 

In order for the data to be appropriately filtered, the filters that can be applied as follows:

* Executive Summary Page

Product Category bar chart and Top 10 Products table should not filter the card visuals or KPIs
Top 10 Products table should not affect any other visuals

* How to edit interactions. 

- Click on the Product Category bar chart.
- Go to the Format tab and select Edit Interactions.
- For each card visual or KPI, click the ‘none’ filter icon (it looks like a slashed circle).
- Repeat the steps for the Top 10 Products table.

* Customer Detail Page

Top 20 Customers table should not filter any of the other visuals
Total Customers by Product Donut Chart should not affect the Customers line graph
Total Customers by Country donut chart should cross-filter Total Customers by Product donut Chart

- Click on the Top 20 Customers table.
- Go to the Format tab and select Edit Interactions.
- For each visual, click the ‘none’ filter icon.
- Repeat the steps for the Total Customers by Product Donut Chart.
- For the Total Customers by Country donut chart, select the ‘filter’ icon (it looks like a funnel) on the Total Customers by Product donut Chart.

* Product Detail Page

Orders vs. Profitability scatter graph should not affect any other visuals

- Click on the Orders vs. Profitability scatter graph.
- Go to the Format tab and select Edit Interactions.
- For each visual, click the ‘none’ filter icon.

Page Navigation

- Add the Buttons: In the sidebar of the Executive Summary page, add four new blank buttons.

- Set Button Style: Go to the Format > Button Style pane, make sure the Apply settings to field is set to Default, and set each button icon to the relevant white png in the Icon tab. Go to icon, custom and then find the white png. 

- Set Hover Style: For each button, go to Format > Button Style > Apply settings to and set it to On Hover, and then select the alternative colourway of the relevant button under the Icon tab.

- Set Button Action: For each button, turn on the Action format option, and select the type as Page navigation, and then select the correct page under Destination.

- Group and Copy Buttons: Finally, group the buttons together and copy accross all pages and additionally add back buttons for the rest of the pages aswell. 

## Troubleshooting in the project  

1. Always check your data is sound before you continue, if you do upload the wrong data tables into your analysis. Here is what you can do. This project did have this problem and here is how you fix it.

2. Import the data again and transform the data, in this case it was the Orders table that was uploaded incorrectly. Once uploaded, you will need to then go over your functions and make sure they are correct, otherwise you will face errors. 

3. After importing the data and correcting any function errors, add and commit. This project had to do this for for PowerBiProject,PowerbiProject2,PowerbiProject4. Then started again from here. 

4. If you need to divide, move from the measure table and create a column in the Orders table and use that. 

5. In the stores map, when i put the data in longitude and latitude, although it says its in America, its actually in dubai and damscus! 

## Postgresql Queries

In this section, it will look at a Postgres database server that is hosted on Microsoft Azure. To connect to the server and run queries from VSCode, you will need to install the SQLTools extension. Go to VSCode, find the extentions search bar and type in SQL tools, download it and then go to new connection. 

2.Once you have done this, you can connect to the server and the credentials needed to log in are as follows:

HOST: 
PORT: 
DATABASE: 
USER:
PASSWORD:

3. Postgres Queries 

The following are  5 examples of queries that could be given for a dataset. 

* Question 1 - How many staff are there in all of the UK stores?

SELECT SUM(staff_numbers) AS StaffCount
FROM dim_store
WHERE country = 'UK';

*Question 1 Answer
"staffcount"
"13273"

* Question 2 - Which month in 2022 has had the highest revenue?

SELECT month_name, 
       SUM(sale_price - cost_price) AS revenue
FROM forview
WHERE DATE_PART('year', TO_TIMESTAMP(dates, 'YYYY-MM-DD HH24:MI:SS.MS')) = 2022
GROUP BY month_name
ORDER BY revenue DESC
LIMIT 1;

* Question 2 Answer

"month_name","revenue"
"Oct",7567.2753646583715


* Question 3 -  Which German store type had the highest revenue for 2022?

SELECT store_type, 
       SUM(sale_price - cost_price) AS revenue
FROM forview
WHERE DATE_PART('year', TO_TIMESTAMP(dates, 'YYYY-MM-DD HH24:MI:SS.MS')) = 2022 AND country = 'Germany'
GROUP BY store_type
ORDER BY revenue DESC
LIMIT 1;

* Question 3 Answer

"store_type","revenue"
"Local",17568.605977253213


* Question 4 -  Create a view where the rows are the store types and the columns are the total sales, percentage of total sales and the count of orders

CREATE VIEW sales_view AS
SELECT percentage_of_sales, 
       sale_price, 
       cost_price, 
       product_quantity
FROM forview;

* Question 4 Answer

"percentage_of_sales","sale_price","cost_price","product_quantity"
"0",42.99,26.304749208751986,"3"
"0",12.99,7.672220446328534,"3"
"0",18,9.319705476516887,"3"
"0",22,13.376214330434756,"3"
"0",24.99,14.99396233412083,"3"
"0",12.99,7.6972012327626,"3"
"0",7.99,3.600020637159497,"3"
"0",30.99,18.216741163899115,"3"
"0",1,0.5602533140859068,"3"
"0",1,0.5004862211029891,"3"
"0",2,0.8427333329685183,"3"
"0",1.25,0.4839913735742831,"3"
"0",6,2.844051445855293,"3"
"0",8,3.802772293162091,"3"
"0",20,7.701393002538382,"3"
"0",1,0.447101086457238,"3"
"0",21.99,13.078433636903377,"3"
"0",2.5,1.616842776697874,"3"
"0",20,9.25834491531736,"3"
"0",25,15.036561948806275,"3"
"0",30,17.39092404946517,"3"
"0",2.5,0.800371860749492,"3"
"0",3.99,2.3288610857922767,"3"
"0",50,23.515702381023637,"3"
"0",2.69,1.2968022019079677,"3"
"0",25,16.00208739709855,"3"
"0",19.99,12.21421328464054,"3"
"0",25,11.3769209269751,"3"
"0",45,26.214477942661222,"3"
"0",8,3.617644701420836,"3"
"0",22,13.142684218462916,"3"
"0",19.99,11.45541470036036,"3"
"0",18,8.25774552578017,"3"
"0",2.99,1.4642237160792453,"3"
"0",4.49,1.7150104319562816,"3"
"0",4.49,1.862104541106284,"3"
"0",70,41.62106472541996,"3"
"0",12,6.95763617811022,"3"
"0",22,12.496534483621392,"3"
"0",1,0.422533702941546,"3"
"0",22,13.376214330434756,"3"
"0",8,3.0221968706837856,"3"
"0",15,9.134181446057944,"3"
"0",8,4.887051539237564,"3"
"0",1,0.5047797905755371,"3"
"0",4,2.075331142016557,"3"
"0",3.99,1.584622200931556,"3"
"0",10.99,5.164931336028458,"3"
"0",0.69,0.3318863903000733,"3"
"0",12.99,7.902362315948595,"3"


* Question 5 -  Which product category generated the most profit for the "Wiltshire, UK" region in 2021?

SELECT category
FROM forview
WHERE DATE_PART('year', TO_TIMESTAMP(dates, 'YYYY-MM-DD HH24:MI:SS.MS')) = 2021 AND full_region = 'Wiltshire, UK'
GROUP BY category
ORDER BY SUM(sale_price - cost_price) DESC
LIMIT 1 ;

* Question 5 Answer 

"category"
"homeware"



















