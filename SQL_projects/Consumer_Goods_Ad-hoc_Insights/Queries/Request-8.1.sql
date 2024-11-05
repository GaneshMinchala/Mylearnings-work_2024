-- 8.  In which quarter of 2020, got the maximum total_sold_quantity? The final output contains these fields sorted by the total_sold_quantity, 
-- Quarter 
-- total_sold_quantity 

with cte as
(
SELECT 	date,
		monthname(date) as Month,
		month(DATE_ADD(date, interval 4 month)) as fy,
		sum(sold_quantity) as Total_quantity,
        if(month(date)in (9,10,11) , 'Q1', 
								if(month(date) in (12,1,2), 'Q2', 
													if(month(date) in (3,4,5), 'Q3','Q4')
									)
			) as Quarter
FROM fact_sales_monthly
where fiscal_year = 2020
group by Month
)
select 	Quarter,
		concat(Month, '[ ', year(date), ' ]') as Month,
		Total_quantity
		-- sum(total_quantity) over(partition by Quarter) as cummulative_total_quantity_per_quarter
from cte;
-- group by quarter;
