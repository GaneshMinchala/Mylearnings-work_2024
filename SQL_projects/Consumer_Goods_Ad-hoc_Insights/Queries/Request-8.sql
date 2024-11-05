
-- 8.  In which quarter of 2020, got the maximum total_sold_quantity? The final output contains these fields sorted by the total_sold_quantity, 
-- Quarter 
-- total_sold_quantity 

SELECT
        if(month(date)in (9,10,11) , 'Q1', 
								if(month(date) in (12,1,2), 'Q2', 
													if(month(date) in (3,4,5), 'Q3','Q4')
									)
			) as Quarter,
            
            ROUND( sum(sold_quantity), 2) as total_sold_quantity
            
FROM fact_sales_monthly
where fiscal_year = 2020
group by Quarter
order by total_sold_quantity desc;