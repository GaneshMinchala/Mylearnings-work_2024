 -- 9. Which channel helped to bring more gross sales in the fiscal year 2021 and the percentage of contribution?  The final output  contains these fields, 
		-- channel 
		-- gross_sales_mln 
		-- percentage 


-- This is the correct on for 9th question
with cte as
(				
					select c.channel,
							Round(sum(fsm.sold_quantity * gp.gross_price)/1000000,2) as Gross_sales_mln
							
					FROM 	fact_sales_monthly as fsm
									INNER JOIN fact_gross_price as gp
                                    USING(product_code,fiscal_year)
									
									INNER JOIN dim_customer c 
									USING(customer_code)

					where
							fsm.fiscal_year = 2021
					GROUP BY c.channel
)
SELECT *,
		Gross_sales_mln*100/sum(Gross_sales_mln) over() as percentage
FROM cte
order by Gross_sales_mln desc;