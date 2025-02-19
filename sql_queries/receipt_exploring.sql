with brands as (
  select cast(barcode as string) as barcode,
  name
  from `fetch-takehome-451217.Fetch_data.brands`
)

select dateScanned,
_id as receipt_id,
brands.name
from `fetch-takehome-451217.Fetch_data.receipts` rcpts
left join `fetch-takehome-451217.Fetch_data.items` items
on rcpts._id = items.receiptId
left join brands
on items.barcode = brands.barcode

where brands.name is not null
order by dateScanned desc


