-- 5. Get the products that have the highest and lowest manufacturing costs. 
-- The final output should contain these fields, 
-- columns- product_code, product, manufacturing_cost 

SELECT 
		p.product_code,
        p.product,
		fmc.manufacturing_cost
        
FROM fact_manufacturing_cost fmc
		JOIN dim_product p
        USING(product_code)
where fmc.manufacturing_cost = (select MAX(manufacturing_cost)
									from fact_manufacturing_cost)
                                    or
	fmc.manufacturing_cost = (select min(manufacturing_cost)
									from fact_manufacturing_cost)
order by fmc.manufacturing_cost desc;