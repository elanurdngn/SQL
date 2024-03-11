select product_name, quantity_per_unit from products;

select product_id , product_name, discontinued from products where discontinued = '0';

select product_id as ProductID, product_name as ProductName, discontinued  from products where discontinued = '1';

select product_id, product_name, unit_price from products where unit_price < 20;

select product_id, product_name, unit_price from products where unit_price between 15 and 25;

select product_name, units_on_order , units_in_stock from products where units_on_order > units_in_stock;

select * from products where product_name like  'a%' ;

select * from products where product_name like '%i';

select product_name, unit_price , sum(unit_price +(unit_price * 0.18)) as UnitPriceKDV from products group by product_name, unit_price;

select Count(*) from products where unit_price < 30;

select Lower(product_name) as productName ,unit_price from products order by unit_price desc;

select concat(first_name,' ', last_name) as ename from employees;

select count(*) from suppliers where region isnull;

select count(*) from suppliers where region notnull;

select upper(concat('TR',product_name)) as productName from products;

select concat('TR ',product_name) from products where unit_price < 20;

select product_name, unit_price from products order by unit_price DESC;

select product_name, unit_price from products order by unit_price desc limit 10;

select product_name,unit_price from products where unit_price > (select avg(unit_price)from products);

select product_name ,units_in_stock, unit_price , sum(units_in_stock * unit_price) from products where units_in_stock >0 group by product_name,units_in_stock, unit_price;

select count(*)from products where units_in_stock > 0 and discontinued = 0;

select p.*, c.category_name from products as p
inner join categories as c on p.category_id = c.category_id;

select c.category_name, avg(p.unit_price)  from products as p
inner join categories as c on p.category_id = c.category_id
group by c.category_name;

select p.product_id, p.unit_price, c.category_name from products as p 
inner join categories as c on p.category_id = c.category_id
order by unit_price desc limit 1;

select p.product_name,c.category_name,s.company_name from order_details as od
inner join products AS p ON od.product_id = p.product_id
inner join suppliers AS s ON p.supplier_id = s.supplier_id
inner join categories AS c ON p.category_id = c.category_id
group by p.product_id,c.category_name,s.company_name
order by sum(od.quantity)desc limit 1;



