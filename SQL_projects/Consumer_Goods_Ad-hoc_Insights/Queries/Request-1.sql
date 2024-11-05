
-- 1  Provide the list of markets in which customer  "Atliq  Exclusive"  operates its 
-- business in the  APAC  region. 

SELECT distinct(market)
FROM gdb023.dim_customer
where region = 'APAC' and customer= 'Atliq Exclusive';
-- order by market;

with cte as(
SELECT distinct(market),
		sum(fsm.sold_quantity) as total_sold_quantity

FROM gdb023.dim_customer c
	join fact_sales_monthly fsm
    on c.customer_code = fsm.customer_code


where region = 'APAC' and customer= 'Atliq Exclusive'

group by c.market
-- order by market;
)
select *,
		sum(total_sold_quantity)/1000000
from cte;