## Power bi Project

Greetings! This is a project that is based in Power bi that transforms and cleans a dataset and create relationships within the data model view. This will be a guide to the project,documenting each process and any troubleshooting you could encounter along the way, if any.

### Table of contents

* Description of file types
* Power bi - How do you get the data?
* Data transform/cleaning
* Create a data model and relationship between data tables
* How to create a date table
* Create relationships between the data
* Organising the data by creating a new measure table
* Date and Geography Hierachy 



### Description of file types

Text.csv - this is a text file and that the text is seperated by commas(csv). The csv stands for comma seperated values.

Local folder - this is a folder that is stored on your computer.Files stored on your desktop works best for easy access in Power bi's get data

Microsoft Azure - Depending on which system you run depends on whether you need to use Azure for this project.                                                                         
However, if you have a mac or are a linux user, then you need to create a virtual machine in Azure by creating a new account and following instructions on how to set one up. This could incur costs so be mindful of your time you spend on this project or using the virtual machine. Azure do offer a $200 credit upon opening your account but this is time limited. Here is the link to the doc on how to set that up https://learn.microsoft.com/en-us/azure/virtual-machines/windows/quick-create-portal. You can pay for the subscription of $85 a month, but that is only if you feel it would be beneficial for your usage and is not needed for this project. 

Power bi - If you use windows, you can download Power bi here for direct source                                                                                                https://powerbi.microsoft.com/en-gb/landing/free-account/?ef_id=_k_c86f5521357318286277304a9325acff_k_&OCID=AIDcmmmhj6wa7w_SEM__k_c86f5521357318286277304a9325acff_k_&msclkid=c86f5521357318286277304a9325acff

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
The data transformed here as follows: Deleted the card number column, this is because the data should be kept private, split the order data and shipping date into two seperate columns and re-named them, filled in any nulls in order date. Re-named all the columns to the correct format in Power bi.

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

Day of the week = WEEKDAY([Date], 2)// 2 means Monday = 1, Sunday = 7

DAX function for Month Number:

Month number = MONTH([Date])

DAX function for Month Name:

Month name = FORMAT([Date], "mmmm")

DAX function for Quarter

Quarter = QUARTER('Date Table'[Date])

DAX function for Year

Year = YEAR('Date Table'[Date])

DAX function of Start of year

Start of year = STARTOFYEAR('Date Table'[Date])

DAX function of Quarter

Quarter = QUARTER('Date Table'[Date])

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

4.The data will need to organised, so create a new measure table that captures our calculations. 

- Create a new table in the model view in Power editor,go to enter data on the home ribbon, name it measure table and load. 

- Create the key measures in this table. 

DAX function for Total orders

Total orders = COUNT(Orders[Product Quantity])

DAX function for Total revenue 

Total Revenue = SUMX(Orders, Orders[Product Quantity] * RELATED(Products[Sale price]))

DAX function for Total profit

Total Profit = SUMX(Orders, (RELATED(Products[Sale price]) - RELATED(Products[Cost price])) * Orders[Product Quantity])

DAX function for Total customers

Total customers = DISTINCTCOUNT(Orders[User ID])

DAX function for Total quantity

Total Quantity = SUM(Orders[Product Quantity])

DAX function for Profit YTD

Profit YTD = CALCULATE(SUM('Orders'[Product Quantity]), DATESYTD('Date Table'[Date]))

DAX function for Revenue YTD

Revenue YTD = CALCULATE(SUMX(Orders, Orders[Product Quantity] * RELATED(Products[Sale price])), DATESYTD('Date Table'[Date]))

DAX function for Top customer by revenue 

Total Revenue Top Customer = MAXX(TOPN(1,SUMMARIZE(Orders, Customers[Full name], "Total Revenue", [Revenue per Customer]), 
[Total Revenue], DESC),[Total Revenue])

DAX customer for Top customer

Top Customer = MAXX(TOPN(1, VALUES(Customers[Full name]),[Total Revenue Top Customer],DESC),Customers[Full name])

DAX function for orders by Top customer 

Number of Orders by Top Customer = MAXX(TOPN(1, SUMMARIZE(Orders, Customers[Full name], "Total Orders", COUNT(Orders[Product Quantity])), [Total Orders], DESC), [Total Orders])


## Date and Geography Hierachy 

Hierarchies allow the ability for filters to be added to the data so that it can drilled down within a line chart.
 
 Date hierarchy

 * Start of Year
 * Start of Quarter
 * Start of Month
 * Start of Week

Geography hierarchy

* World Region
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
Region : State or Province

## Building reports within Power bi 

There are many ways to add analysis to your report that use many different types of visuals. The following gives a good example of how you can create useful dashboard for managers. 

5. Customer Analysis report

Customer dashboard

- In the bottom ribbon, add a new tab and name it customer detail. 
- In the measure table go to the Total customers table, change the name to the Unique customers instead for the report view. 
- Create a new measure that calculates revenue per customer:

DAX function for revenue per customer 

Revenue per Customer = CALCULATE('Measure table'[Total Revenue]/ 'Measure table'[Unique Customers])

- Insert new visual in the ribbon, find the card visual from the dropdown menu.

Create two cards, one for Unique customers from the measure table and the second revenue per customer.

- Insert new visual in the ribbon, find the donut chart and add customers[Country] in the legend and Unique customers in the values.

- Insert new visual in the ribbon, find the column chart and add Products[Category] in the y axis and Unique customers in the X axis 

- Insert new visual in the ribbon, find the line chart  and add Unique customers in the Y axis and Date hierarchy in the x axis, take out date, start of the week leave start of quarter,start of month and start of year. 
In this line chart, as you set up the line chart, go straight to visual and go to forecast, switch it on, forecast 10 with 95% interval.

- Insert new visual, create a table for the using the measure Top Customers and rename it Top 20 customers, filter by revenue oer customer, descending. 

- Insert new visual, create 3 cards, one that contains the top customer, no of orders per customer, total reveu generated per top customer.

-  Finally, add a date slicer, go to slicer settings in  the visual pane and choose in between.



















