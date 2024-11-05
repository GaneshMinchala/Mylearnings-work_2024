-- 4.  Follow-up: Which segment had the most increase in unique products in 
-- 2021 vs 2020? The final output contains these fields, 
-- columns- segment, product_count_2020, product_count_2021 
-- difference
with pc_20 as 
(
	select p.segment,
			COUNT(DISTINCT p.product_code) as products_count_2020
	from dim_product p 
		JOIN fact_sales_monthly f
		USING(product_code)
	where fiscal_year = 2020
	group by segment
),
pc_21 as
(
	select p.segment,
			COUNT(DISTINCT p.product_code) as products_count_2021
	from dim_product p 
			JOIN fact_sales_monthly f
			USING(product_code)
	where fiscal_year = 2021
	group by segment
)
SELECT segment,
		pc_20.products_count_2020,
        pc_21.products_count_2021,
        products_count_2021 - products_count_2020 as difference
FROM pc_20 JOIN pc_21 USING(segment)
order by difference desc;
