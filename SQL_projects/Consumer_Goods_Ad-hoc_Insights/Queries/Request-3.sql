--  3.  Provide a report with all the unique product counts for each  segment  and sort them in descending order of product counts. The final output contains 
-- 2 fields, columns
-- segment 
-- product_count


select segment,
		COUNT(DISTINCT product_code) as products_count
from dim_product
group by segment
order by products_count desc;