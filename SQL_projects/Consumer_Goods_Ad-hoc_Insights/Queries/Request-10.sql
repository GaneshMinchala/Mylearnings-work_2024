-- 10.  Get the Top 3 products in each division that have a high total_sold_quantity in the fiscal_year 2021? The final output contains these 
-- 				fields, 
-- 				division 
-- 				product_code 
-- 				codebasics.io 
-- 				product 
-- 				total_sold_quantity 
-- 				rank_order 

with cte as
(
	SELECT 
			p.*,
			sum(sold_quantity) as total_sold_quantity,
			dense_rank() over(partition by p.division order by sum(sold_quantity) desc) as rank_order
	FROM dim_product as p
			JOIN fact_sales_monthly as fsm
			ON p.product_code = fsm.product_code
	where fsm.fiscal_year = 2021
	GROUP BY p.product_code
)
select division,
		product_code,
        concat(product, ' [ ' , variant,' ]') as product,
        total_sold_quantity,
        rank_order
FROM cte
where rank_order < 4;