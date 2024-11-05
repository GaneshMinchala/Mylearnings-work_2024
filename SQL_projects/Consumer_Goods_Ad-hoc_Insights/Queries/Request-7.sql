USE gdb023;


-- 7. Get the complete report of the Gross sales amount for the customer  “Atliq 
-- Exclusive”  for each month  .  This analysis helps to  get an idea of low and 
-- high-performing months and take strategic decisions. 
--  The final report contains these columns: 
			-- Month 
			-- Year 
			-- Gross sales Amount 


SELECT 
		concat(monthname(fsm.date), '[ ',year(fsm.date),' ]') as month,
        fsm.fiscal_year as f_year,
        ROUND(sum(gp.gross_price * fsm.sold_quantity),2) as Gross_sales

FROM 	fact_gross_price as gp
		JOIN fact_sales_monthly as fsm
		ON gp.product_code = fsm.product_code
		
        JOIN dim_customer as c
        using(customer_code)

WHERE c.customer = 'Atliq Exclusive'
group by Month,fsm.fiscal_year
order by fsm.date, Gross_sales desc;