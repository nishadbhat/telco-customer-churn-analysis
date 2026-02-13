-- Churn rate 

Select 
	ROUND(SUM(CASE WHEN churn='Yes' THEN 1 
	ELSE 0
	END)/COUNT(*) :: decimal ,2)*100 churn_rate
from customer_churn

-- Segmented churn

Select 
    contract,
	ROUND(SUM(CASE WHEN churn='Yes' THEN 1 
	ELSE 0
	END)/COUNT(*) :: decimal ,2)*100 churn_rate
from customer_churn
group by contract


-- Revenue Impact

Select 
	contract,
	SUM(monthly_charges) revenue_lost
from 
	customer_churn
where churn ='Yes'
group by contract


-- customers with declining spending

Select 
	customer_id,
	contract,
	monthly_charges,
	RANK() OVER(PARTITION BY contract ORDER BY monthly_charges Asc) lowest_spend_rank
from 
	customer_churn