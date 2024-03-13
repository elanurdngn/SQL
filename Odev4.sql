--- 26 Stokta bulunmayan ürünlerin ürün listesiyle birlikte tedarikçilerin ismi ve iletişim numarasını (`ProductID`, `ProductName`, `CompanyName`, `Phone`) almak için bir sorgu yazın.
select p.product_id,p.product_name,s.company_name,s.phone from products as p   
Inner join suppliers as s on s.supplier_id = p.supplier_id 
where p.units_in_stock = 0;

---27 1998 yılı mart ayındaki siparişlerimin adresi, siparişi alan çalışanın adı, çalışanın soyadı
select e.first_name,e.last_name,o.ship_address , o.order_date from orders as o
inner join employees as e on e.employee_id = o.employee_id 
where to_char(order_date,'YYYY-MM')='1998-03';

---28 1997 yılı şubat ayında kaç siparişim var?
select Count(*) from orders where to_char(order_date,'YYYY-MM')='1997-02';

---29 London şehrinden 1998 yılında kaç siparişim var?
select count(*) from orders where to_char(order_date,'YYYY')='1998' and ship_city = 'London';

---30 1997 yılında sipariş veren müşterilerimin contactname ve telefon numarası
select cs.contact_name,cs.phone from orders as o
inner join customers as cs on cs.customer_id = o.customer_id
where to_char(o.order_date,'YYYY')='1997';

---31 Taşıma ücreti 40 üzeri olan siparişlerim
select * from orders where freight >40;

---32 Taşıma ücreti 40 ve üzeri olan siparişlerimin şehri, müşterisinin adı
select o.ship_city,cs.contact_name from orders as o 
inner join customers as cs on cs.customer_id = o.customer_id
where freight >40;

---33 1997 yılında verilen siparişlerin tarihi, şehri, çalışan adı -soyadı ( ad soyad birleşik olacak ve büyük harf),
select upper(concat(e.first_name, ' ',e.last_name))as name_surname,o.order_date,o.ship_city from orders as o
inner join employees as e on e.employee_id = o.employee_id
where to_char(o.order_date,'YYYY')='1997';

---34 1997 yılında sipariş veren müşterilerin contactname i, ve telefon numaraları ( telefon formatı 2223322 gibi olmalı )
select cs.contact_name,regexp_replace(cs.phone, '\D', '', 'g')as phone from orders as o
inner join customers as cs on cs.customer_id = o.customer_id
where to_char(o.order_date,'YYYY')='1997';

---35 Sipariş tarihi, müşteri contact name, çalışan ad, çalışan soyad
select o.order_date,cs.contact_name,e.first_name,e.last_name from orders as o
inner join customers as cs on cs.customer_id= o.customer_id
inner join employees as e on e.employee_id= o.employee_id;

---36 Geciken siparişlerim?
select * from orders where shipped_date > required_date;

---37 Geciken siparişlerimin tarihi, müşterisinin adı
select o.order_date,cs.contact_name from orders as o
inner join customers as cs on cs.customer_id = o.customer_id
where o.shipped_date > o.required_date;

---38 10248 nolu siparişte satılan ürünlerin adı, kategorisinin adı, adedi
select p.product_name,ct.category_name,od.quantity from order_details as od
inner join products as p on p.product_id = od.product_id
inner join categories as ct on ct.category_id = p.category_id 
where order_id = 10248;

---39 10248 nolu siparişin ürünlerinin adı , tedarikçi adı
select p.product_name, s.contact_name from order_details as od
inner join products as p on p.product_id = od.product_id
inner join suppliers as s on s.supplier_id = p.supplier_id
where od.order_id = 10248;

---40 3 numaralı ID ye sahip çalışanın 1997 yılında sattığı ürünlerin adı ve adeti
select p.product_name, od.quantity from orders as o
inner join order_details as od on od.order_id = o.order_id
inner join products as p on p.product_id = od.product_id
where o.employee_id = 3 and to_char(o.order_date,'YYYY')='1997';

---41 1997 yılında bir defasinda en çok satış yapan çalışanımın ID,Ad soyad
select e.employee_id,e.first_name, sum(od.unit_price * od.quantity) ,o.order_id from orders as o 
inner join order_details as od on od.order_id = o.order_id
inner join employees as e on e.employee_id = o.employee_id
where to_char(o.order_date,'YYYY')='1997' 
group by o.order_id,e.employee_id,e.first_name 
order by sum desc limit 1;

---42 1997 yılında en çok satış yapan çalışanımın ID,Ad soyad ****
select e.employee_id ,e.first_name, sum(od.unit_price * od.quantity) from orders as o 
inner join order_details as od on od.order_id = o.order_id
inner join employees as e on e.employee_id = o.employee_id
where to_char(o.order_date,'YYYY')='1997' 
group by e.employee_id,e.first_name
order by sum desc limit 1;

---43 En pahalı ürünümün adı,fiyatı ve kategorisin adı nedir?
select p.product_name, c.category_name,p.unit_price from products as p
inner join categories as c on c.category_id = p.category_id
order by unit_price desc limit 1;

---44 Siparişi alan personelin adı,soyadı, sipariş tarihi, sipariş ID. Sıralama sipariş tarihine göre
select o.order_id,e.first_name, e.last_name, o.order_date  from orders as o
inner join employees as e on e.employee_id = o.employee_id
order by o.order_date ;

---***45 SON 5 siparişimin ortalama fiyatı ve orderid nedir?
select o.order_id, avg(od.unit_price) as avg_price
from orders o
inner join order_details as od ON o.order_id = od.order_id
group by o.order_id
ORDER BY o.order_id DESC
LIMIT 5;

---46 Ocak ayında satılan ürünlerimin adı ve kategorisinin adı ve toplam satış miktarı nedir?
select p.product_name,c.category_name , sum(od.quantity)from order_details as od
inner join products as p on p.product_id = od.product_id
inner join orders as o on o.order_id = od.order_id
inner join categories as c on c.category_id= p.category_id
where to_char(o.order_date,'MM')= '03'
group by p.product_name,c.category_name;

---47 Ortalama satış miktarımın üzerindeki satışlarım nelerdir?
SELECT * 
FROM order_details
WHERE quantity > (SELECT AVG(quantity) FROM order_details);

---48*** En çok satılan ürünümün(adet bazında) adı, kategorisinin adı ve tedarikçisinin adı
select p.product_name,c.category_name,s.contact_name from order_details as od
inner join products as p on p.product_id = od.product_id
inner join categories as c on c.category_id=p.category_id
inner join suppliers as s on s.supplier_id = p.supplier_id
order by od.quantity desc limit 1;

---49 Kaç ülkeden müşterim var
select count(distinct country) from customers;

---50 3 numaralı ID ye sahip çalışan (employee) son Ocak ayından BUGÜNE toplamda ne kadarlık ürün sattı?
select sum(od.unit_price * quantity) from orders as o
inner join order_details as od on od.order_id =o.order_id
where employee_id = 3 and (order_date >= '2024-01-01' AND order_date <= CURRENT_DATE);

---63 Hangi ülkeden kaç müşterimiz var
select country ,count(customer_id) as total_customer from customers 
group by country;

---65 10 numaralı ID ye sahip ürünümden son 3 ayda ne kadarlık ciro sağladım?
select sum(od.unit_price * od.quantity) from order_details as od
inner join orders as o on o.order_id = od.order_id
WHERE od.product_id = 10 and o.order_date >= CURRENT_DATE - INTERVAL '3 months';

---66 Hangi çalışan şimdiye kadar toplam kaç sipariş almış..?
select employee_id, count(order_id) from orders
group by employee_id;

---67 91 müşterim var. Sadece 89’u sipariş vermiş. Sipariş vermeyen 2 kişiyi bulun
select * from customers as c
left join orders o on c.customer_id = o.customer_id
where o.customer_id is null;

---68 Brazil’de bulunan müşterilerin Şirket Adı, TemsilciAdi, Adres, Şehir, Ülke bilgileri
select company_name, contact_name,address,city,country from customers 
where country = 'Brazil';

---69 Brezilya’da olmayan müşteriler
select company_name, contact_name,address,city,country from customers 
where country <> 'Brazil';

---70 Ülkesi (Country) YA Spain, Ya France, Ya da Germany olan müşteriler
select company_name, contact_name,address,city,country from customers 
where country = 'Spain' or country='France' or country = 'Germany';

---71 Faks numarasını bilmediğim müşteriler
select * from customers
where fax is null;

---72 Londra’da ya da Paris’de bulunan müşterilerim
select * from customers
where city = 'London' or city = 'Paris';

---73 Hem Mexico D.F’da ikamet eden HEM DE ContactTitle bilgisi ‘owner’ olan müşteriler
select * from customers
where city = 'México D.F.' and contact_title = 'Owner';

---74 C ile başlayan ürünlerimin isimleri ve fiyatları
select product_name, unit_price from products 
where product_name Like 'C%';

---75 Adı (FirstName) ‘A’ harfiyle başlayan çalışanların (Employees); Ad, Soyad ve Doğum Tarihleri
select first_name,last_name,birth_date from employees 
where first_name like 'A%';

---76 İsminde ‘RESTAURANT’ geçen müşterilerimin şirket adları
select company_name from customers 
where company_name like '%Restaurant%';

---77 50$ ile 100$ arasında bulunan tüm ürünlerin adları ve fiyatları
select product_name, unit_price from products
where unit_price between 50 and 100;

---78 1 temmuz 1996 ile 31 Aralık 1996 tarihleri arasındaki siparişlerin (Orders), SiparişID (OrderID) ve SiparişTarihi (OrderDate) bilgileri
select order_id,order_date from orders 
where order_date between '1996-07-01' and '1996-12-31';

---81 Müşterilerimi ülkeye göre sıralıyorum:
select company_name, contact_name, city,country from customers
order by country;

---82 Ürünlerimi en pahalıdan en ucuza doğru sıralama, sonuç olarak ürün adı ve fiyatını istiyoruz
select product_name,unit_price from products 
order by unit_price desc;

---83 Ürünlerimi en pahalıdan en ucuza doğru sıralasın, ama stoklarını küçükten-büyüğe doğru göstersin sonuç olarak ürün adı ve fiyatını istiyoruz
select product_name,unit_price,units_in_stock from products 
order by unit_price desc , units_in_stock asc;

---84 1 Numaralı kategoride kaç ürün vardır..?
select count(*) from products
where category_id = 1;

---85 Kaç farklı ülkeye ihracat yapıyorum..?
select count(distinct ship_country) from orders;

--- 86 a.Bu ülkeler hangileri..?
select distinct ship_country from orders;

---87 En Pahalı 5 ürün
select * from products
order by unit_price desc limit 5;

---88 ALFKI CustomerID’sine sahip müşterimin sipariş sayısı..?
select count(*) from orders
where customer_id = 'ALKFI';

---89 Ürünlerimin toplam maliyeti
select sum(unit_price)as total from products;

---90 Şirketim, şimdiye kadar ne kadar ciro yapmış..?
select s.company_name,sum(od.unit_price* od.quantity) from order_details as od
inner join products as p on p.product_id = od.product_id
inner join suppliers as s on s.supplier_id= p.supplier_id
group by company_name;

---91 Ortalama Ürün Fiyatım
select avg(unit_price) from products;

---92 En Pahalı Ürünün Adı
select product_name, unit_price from products
order by unit_price desc limit 1;

---93 En az kazandıran sipariş
select order_id,sum(unit_price* quantity)as total from order_details
group by order_id
order by total limit 1;

---94 Müşterilerimin içinde en uzun isimli müşteri
select max(contact_name) from customers;

---95 Çalışanlarımın Ad, Soyad ve Yaşları
select first_name,last_name, EXTRACT(YEAR FROM AGE(CURRENT_DATE, birth_date)) AS yas 
from employees;

---96 Hangi üründen toplam kaç adet alınmış..?
select p.product_name,sum(quantity) from order_details as od
inner join products as p on p.product_id = od.product_id
group by p.product_name;

---97 Hangi siparişte toplam ne kadar kazanmışım..?
select order_id,sum(unit_price * quantity) from order_details 
group by order_id;

---98 Hangi kategoride toplam kaç adet ürün bulunuyor..?
select c.category_name,count(p.product_id ) from products as p
inner join categories as c on c.category_id = p.category_id
group by c.category_name;

---99 1000 Adetten fazla satılan ürünler?
select  product_id,sum(quantity)as total from order_details
group by product_id
having sum(quantity) > 1000;

---100 Hangi Müşterilerim hiç sipariş vermemiş..?
select * FROM customers c
left join orders o on c.customer_id = o.customer_id
where o.customer_id is null;
