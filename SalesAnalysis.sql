--Sales Analysis
--1.Customer Purchase Patterns:

--What is the average number of orders per customer?

select (count(o.order_id)/count(c.customer_id)) as 'Avg Order per Customer'
from customers c 
inner join orders o
on c.customer_id=o.customer_id

--What is the most common order status, and which customers have the highest frequency of orders?

select top 1 order_status,number_of_order_status
from 
(select order_status,count(order_status) as number_of_order_status
from orders
group by order_status)
AS order_counts
order by number_of_order_status desc

select top 1 concat (c.first_name,' ',c.last_name) as 'Customer_Name',count(o.order_id) AS order_count
from customers c 
inner join orders o
on c.customer_id=o.customer_id
group by c.first_name, c.last_name
order by order_count desc

--What is the distribution of orders across different states or cities?

select c.city,c.state,count(o.order_id) as total_orders
from customers c 
inner join orders o
on c.customer_id=o.customer_id
group by c.city,c.state

--2.Staff Performance:

--Which staff members handle the most orders?

select top 1 o.staff_id,count(o.order_id) as 'total_handled_orders',concat (s.first_name,' ',s.last_name) as 'Staff_Name'
from staffs s
inner join orders o
on o.staff_id=s.staff_id
group by o.staff_id,s.first_name,s.last_name
order by total_handled_orders desc

--What is the average time taken by each staff member to ship an order from the order date?

select staff_id,AVG(DATEDIFF(day,order_date,shipped_date)) as 'AVG_Order_Processing_day'
from orders
group by staff_id

--How does staff performance vary across different stores?
select o.staff_id,AVG(DATEDIFF(day,o.order_date,o.shipped_date)) as 'AVG_Order_Processing_day',concat (sf.first_name,' ',sf.last_name) as 'Staff_Name',st.store_name,st.city
from orders o 
inner join staffs sf
on o.staff_id=sf.staff_id inner join stores st on sf.store_id = st.store_id
group by o.staff_id,sf.first_name,sf.last_name,st.store_name,st.city

--3.Order and Item Trends:

--What are the top-selling products based on the number of items ordered?

select top 10 o.product_id,p.product_name,count(o.product_id) as number_of_orders
from order_items o inner join products p
on o.product_id=p.product_id
group by o.product_id,p.product_name
order by number_of_orders desc

--Which orders have the highest discounts, and how does this affect order quantity?

select  o.order_id,count(oi.quantity) as quantityOrdered,(oi.discount*100) as discountpct
from orders o inner join order_items oi
on o.order_id=oi.order_id
group by o.order_id,oi.discount
order by discountpct desc

--4.Store Performance:

--Which stores have the highest total sales
select top 1 o.store_id,s.store_name,count(o.order_id) as 'totalSales'
from orders o inner join stores s
on o.store_id=s.store_id
group by o.store_id,s.store_name
order by totalSales desc

--How does the performance (sales volume) differ between stores in different locations?

select s.store_name,count(o.order_id) as 'totalSales',s.city,s.state
from orders o inner join stores s
on o.store_id=s.store_id
group by s.store_name,s.city,s.state
order by totalSales desc




