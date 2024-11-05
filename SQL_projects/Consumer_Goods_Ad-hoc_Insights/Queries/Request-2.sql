
-- 2.  What is the percentage of unique product increase in 2021 vs. 2020? The final output contains these fields, 
-- unique_products_2020, unique_products_2021, percentage_chg

-- Trail -2
with upc_20 as (
select
        COUNT(DISTINCT product_code) as unique_products_2020
    
    from gdb023.fact_sales_monthly 
    where fiscal_year=2020
),
upc_21 as (
	select
			COUNT(DISTINCT product_code) as unique_products_2021
		
		from gdb023.fact_sales_monthly 
		where fiscal_year=2021
        )
select 
		c20.unique_products_2020,
        c21.unique_products_2021,
        (unique_products_2021-unique_products_2020)/unique_products_2020 as change_pct
FROM upc_20 as c20 join upc_21 as c21;