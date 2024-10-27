--Production Analysis

--1.Product Trends:

--Which product categories and brands are the most popular?
--popular category
select top 1 c.category_name,sum(o.quantity) as 'total_orders'
from order_items o 
inner join products p
on o.product_id=p.product_id
inner join categories c
on p.category_id=c.category_id
group by c.category_name
order by total_orders desc

--popular brand
select top 1 b.brand_name,sum(o.quantity) as 'total_orders'
from order_items o 
inner join products p
on o.product_id=p.product_id
inner join brands b
on p.brand_id=b.brand_id
group by b.brand_name
order by total_orders desc

--How does the model year of products correlate with their list price?

select product_name,model_year,list_price
from products
order by model_year desc,list_price desc

--What are the top products based on list price, and which categories have the most expensive products?

select top 10 product_name,list_price
from products
order by list_price desc

select top 5 c.category_name,ROUND(avg(p.list_price),2)as average_price
from products p
inner join categories c
on p.category_id = c.category_id
group by c.category_name
order by average_price desc--2.Inventory and Stock Management:--Which products have the highest stock levels in each store?select p.product_name,s.store_id,sum(s.quantity) as 'Stocks'from products pinner join stocks son p.product_id=s.store_idgroup by p.product_name,s.store_idorder by stocks desc--Are there any stores with low stock levels for popular items, indicating potential restocking needs?select p.product_name,count(o.product_id) as number_of_orders,sum(s.quantity) as 'Stocks'
from order_items o inner join products p
on o.product_id=p.product_id
inner join stocks s
on p.product_id=s.product_id
group by p.product_name
order by number_of_orders desc,stocks

--3.Category Analysis:
--What is the average list price per product category?
select top 5 c.category_name,ROUND(avg(p.list_price),2)as average_price
from products p
inner join categories c
on p.category_id = c.category_id
group by c.category_name
order by average_price desc

--Which categories generate the most revenue?
SELECT TOP 5 c.category_name,SUM(o.quantity) AS total_orders, Round(SUM(o.quantity * o.list_price * (1 - o.discount)),2) AS total_revenue
from  order_items o
inner join products p 
on o.product_id = p.product_id
inner join categories c
on p.category_id = c.category_id
group by c.category_name
order by total_revenue DESC;
