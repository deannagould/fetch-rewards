-- This query does not satisft the current need for most recent month with scanned receipts (March) and the month before that (February)
-- This is because there are null values for brand in those receipts, which is a data quality issue and highlighted in the Readme file

-- The query below is how I would answer the question, but used this query to answer for January's top brand by scanned receipts

-- Count distinct receipts per brand from items table
with Rcpt_count AS (
  SELECT
    receiptId,
    brandCode,
    COUNT(DISTINCT receiptId) AS receipt_count
  FROM `fetch-takehome-451217.Fetch_data.items` 
  WHERE receiptId IS NOT NULL
  GROUP BY brandCode, receiptId
),

-- Pulling brand info needed
brands AS (
  SELECT
    brandCode,
    name,
    topBrand
  FROM `fetch-takehome-451217.Fetch_data.brands`
  where brandCode is not null
),

final AS (
  select
  brands.name as brand_name
  , date_trunc(date(rcpts.dateScanned), MONTH) as report_month
  , sum(Rcpt_Count.receipt_count) as total_scanned_receipts

  from `fetch-takehome-451217.Fetch_data.receipts` rcpts
  left join Rcpt_Count 
  ON rcpts._id = Rcpt_Count.receiptId 
  left join brands on Rcpt_Count.brandCode = brands.brandCode
  where brands.name is not null
  group by 1,2
  order by 3 desc
)

SELECT * FROM final
left join final as b
on final.brand_name = b.brand_name
and final.report_month = date_sub(final.report_month, interval 1 month)
order by final.total_scanned_receipts desc
limit 5
