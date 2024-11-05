-- 6. Generate a report which contains the top 5 customers who received an 
-- average high  pre_invoice_discount_pct  for the  fiscal  year 2021  and in the 
-- Indian  market. The final output contains these fields, 
-- customer_code, customer 
-- average_discount_percentage

SELECT 	customer_code, 
		customer, 
        ROUND(avg(pre.pre_invoice_discount_pct),3) as avg_disc_pct

FROM dim_customer as c 
		JOIN fact_pre_invoice_deductions as pre
		USING(customer_code)

where
		pre.fiscal_year = 2021 AND 
        c.market = 'India'
        
GROUP BY c.customer_code
ORDER BY pre.pre_invoice_discount_pct desc
        LIMIT 5;