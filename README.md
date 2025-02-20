# Fetch Rewards 
Take home assessment for Fetch Rewards Analytics Engineer position.


### Entity Relationship Diagram

Below is the entity relationship diagram (ERD). This ERD includes the data from the three data files provided, which also required a fourth table that I named items.

![ERD](images/ERD_img.png)


### Business Questions

##### What are the top 5 brands by receipts scanned for most recent month?
##### How does the ranking of the top 5 brands by receipts scanned for the recent month compare to the ranking for the previous month?

I wrote my SQL queries in Google BigQuery using Google Standard SQL. For the first two questions, it is difficult to answer because the items that were included on scanned receipts in the most recent month as well as the prior month are null. Normally, I would use the [test_scanned_receipts](https://github.com/deannagould/fetch-rewards/blob/main/sql_queries/test_scanned_receipts.sql) query to return the top 5 brands by receipts scanned for most recent month. However, because of the null values I found, I generated a list of top brands in the month where they were last populated. I've included the [receipt_exploring.sql](https://github.com/deannagould/fetch-rewards/blob/main/sql_queries/receipt_exploring.sql) query to show that there were not any top brands included in scanned receipts in February or March (the most recent month).

Included in the brands table is a column called `topBrand` which is a binary datatype. For this, I assumed that 1 is considered a top brand, and 0's or null values are not a top brand. This would require further clarification.

##### When considering average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?

The SQL query [receipt_status.sql](https://github.com/deannagould/fetch-rewards/blob/main/sql_queries/receipt_status.sql) is what I used to answer the next two questions. For this question, I made the assumption that 'Accepted' is the same as 'Finished' because there was not an 'Accepted' `rewardsReceiptStatus`.  The average spend of items with an 'Accepted' status was $80.85, which is much greater than the $23.33 average spend from 'Rejected' receipt statuses.

##### When considering total number of items purchased from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?

Answering this question relies on the same assumption made in the previous solution. Similarly, the total quantity of 'Accepted' items was much higher than 'Rejected' 8,184 items were accepted compared to the 173 items that had a rejected receipt status. 

### Data Quality Issues

There were a few things in the data provided that raise data quality concerns, and at the very least require clarification from stakeholders. One of the biggest issues was the missing brand name in the receipts that were scanned recently. This can be seen in the [receipt_exploring.sql](sql_queries/receipt_exploring.sql) query linked above, as well as the 

![brands_null](images/brands_null.png)

Another concerning piece of this dataset is the amount of null barcodes in the items dataset. Assuming the barcode is needed to know what brands of items and cpg's are purchased, and the business model relies on understanding consumer behavior, trying to lower the amount of nulls in this table would be very important. One of the questions I have that's related to this data is - 'What does deleted mean?' The deleted column is a boolean datatype, and I would assume that 0 means not deleted, and 1 is deleted, but this would require further clarification. 

![items_null](images/items_null.png)


### Communicating with Stakeholders

Hi Team,

I’ve been analyzing the rewards data (receipts, users, brands) and wanted to share some findings and questions to help improve data quality and optimize analysis.


1. Data Quality Issues
- The items data is nested within receipts, which makes item-level analysis difficult. Is there a separate items table available?
- Many barcode and brandCode values are missing in the items table, making it hard to link items to brands. Do we know why?

2. How These Issues Were Found
- While exploring brand performance, I found that missing barcode/brandCode values prevented complete item-brand mapping.
- The structure of the data made it challenging to query items independently from receipts.

3. What’s Needed to Address This
- Are there alternative data sources that contain complete item-level details?
- Would it make sense to store items separately to improve querying and reporting?

4. Scaling & Performance Considerations
- As the dataset grows, will querying nested structures impact performance?
- Would a separate items table improve efficiency?

Would love your input! Let me know if there’s someone else I should connect with on this. I'm happy to jump on a quick call to elaborate if needed.

Best,

Deanna


