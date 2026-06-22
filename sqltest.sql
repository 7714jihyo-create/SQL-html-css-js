use my_shop;
select * from customers;
DELETE FROM customers
WHERE customer_id=1;

insert into orders(customer_id,product_id,quantity)
value (1,1,10);

select * from orders;