select

round(avg(totalSpent), 2) as avg_spent,
sum(purchasedItemCount) as total_quantity_purchased,
rewardsReceiptStatus

from `fetch-takehome-451217.Fetch_data.receipts`

-- since there is no rewardsReceiptStatus = 'ACCEPTED'
-- i am making assumption that 'FINISHED' is the same as 'ACCEPTED' which would require stakeholder clarification
where rewardsReceiptStatus = 'FINISHED' or rewardsReceiptStatus = 'REJECTED'

group by rewardsReceiptStatus