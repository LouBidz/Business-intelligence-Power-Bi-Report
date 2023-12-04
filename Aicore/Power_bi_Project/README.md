## Power bi Project

Greetings! This is a project that is based in Power bi that transforms and cleans a dataset and create relationships within the data model view. This will be a guide to the project,documenting each process and any troubleshooting you could encounter along the way, if any.

### Table of contents

[Description of file types](https://github.com/LouBidz/data-analytics-power-bi-report417/blob/Power_bi_Project/Aicore/Power_bi_Project/README.md#Description-of-file-types)
[Power bi - How do you get the data?](https://github.com/LouBidz/data-analytics-power-bi-report417/blob/Power_bi_Project/Aicore/Power_bi_Project/README.md#Power-bi-How-do-you-get-the-data?)
[Data transform/cleaning](https://github.com/LouBidz/data-analytics-power-bi-report417/blob/Power_bi_Project/Aicore/Power_bi_Project/README.md#Data-transform/cleaning)



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

