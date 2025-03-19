#1)
create table Salespeople (
snum int primary key,
sname varchar(50),
city varchar(50),
comm decimal(4, 2));

insert into Salespeople (snum, sname, city, comm) values
(1001, 'Peel', 'London', 0.12),
(1002, 'Serres', 'San Jose', 0.13),
(1003, 'Axelrod', 'New york', 0.10),
(1004, 'Motika', 'London', 0.11),
(1007, 'Rafkin', 'Barcelona', 0.15);

select * from Salespeople;


#2)
create table Cust (
cnum int primary key,
cname varchar(50),
city varchar(50),
rating int,
snum int );

insert into Cust (cnum, cname, city, rating, snum) values
(2001, 'Hoffman', 'London', 100, 1001),
(2002, 'Giovanne', 'Rome', 200, 1003),
(2003, 'Liu', 'San Jose', 300, 1002),
(2004, 'Grass', 'Berlin', 100, 1002),
(2006, 'Clemens', 'London', 300, 1007),
(2007, 'Pereira', 'Rome', 100, 1004),
(2008, 'James', 'London', 200, 1007);

select * from Cust;


#3)
create table Orders (
onum int primary key,
amt decimal(10, 2),
odate date,
cnum int,
snum int);

insert into Orders (onum, amt, odate, cnum, snum) values
(3001, 18.69, '1994-10-03', 2008, 1007),
(3002, 1900.10, '1994-10-03', 2007, 1004),
(3003, 767.19, '1994-10-03', 2001, 1001),
(3005, 5160.45, '1994-10-03', 2003, 1002),
(3006, 1098.16, '1994-10-04', 2008, 1007),
(3007, 75.75, '1994-10-05', 2004, 1002),
(3008, 4723.00, '1994-10-05', 2006, 1001),
(3009, 1713.23, '1994-10-04', 2002, 1003),
(3010, 1309.95, '1994-10-06', 2004, 1002),
(3011, 9891.88, '1994-10-06', 2006, 1001);

select * from Orders;


#4)
select c.cname as "Customer Name",
c.city as "City", 
s.sname as "Salesperson Name"
from Cust c
join Salespeople s on c.city = s.city;


#5)
select c.cname as "Customer Name",
s.sname as "Salesperson Name"
from Cust c
join Salespeople s on c.snum = s.snum;


#6)
select o.onum as "Order Number",
o.amt as "Order Amount",
o.odate as "Order Date",
c.cname as "Customer Name",
c.city as "Customer City",
s.sname as "Salesperson Name",
s.city as "Salesperson City"
from orders o
join Cust c on o.cnum = c.cnum
join Salespeople s on o.snum = s.snum
where c.city <> s.city;


#7)
select o.onum as "Order Number",
c.cname as "Customer Name"
from orders o
join cust c on o.cnum = c.cnum;


#8)
select c1.cname as "Customers Name 1",
c2.cname as "Customers Name 2",
c1.rating as "Rating"
from cust c1
join cust c2 on c1.rating = c2.rating and c1.cnum < c2.cnum;


#9)
select c1.cname as "Customer Name 1",
c2.cname as "Customer Name 2",
s.sname as "Salesperson Name"
from cust c1
join cust c2 on c1.snum = c2.snum and c1.cnum < c2.cnum
join Salespeople s on c1.snum = s.snum;


#10)
select s1.sname as "Salesperson Name 1",
s2.sname as "Salesperson Name 2",
s1.city as "City"
from Salespeople s1
join Salespeople s2 on s1.city = s2.city and s1.snum < s2.snum;


#11)
select o.onum as "Order Number",
o.amt as "Order Amount",
o.odate as "Order Date",
o.cnum as "Customer Number",
o.snum as "Salesperson Number"
from orders o
where o.snum = (select s.snum
				from cust c
				join salespeople s on c.snum = s.snum
				where c.cnum = 2008);


#12)
select o.onum as "Order Number",
o.amt as "Order Amount",
o.odate as "Order Date"
from orders o
where o.amt > (select avg(amt)
				from orders
				where odate = '1994-10-04')
and o.odate = '1994-10-04';


#13)
select o.onum as "Order Number",
o.amt as "Order Amount",
o.odate as "Order Date",
c.cname as "Customer Name",
s.sname as "Salesperson Name",
s.city as "City"
from orders o
join salespeople s on o.snum = s.snum
join cust c on o.cnum = c.cnum
where s.city = 'London';


#14)
select c.cnum as "Customer Number",
c.cname as "Customer Name"
from cust c
where c.cnum > (select s.snum + 1000
				from salespeople s 
                where s.sname = "Serres");
                

#15)
select count(*) as "Numbers of Customers"
from cust c
where c.rating > (select avg(rating)
					from cust
                    where city = "San Jose");
                    
                    
#16)
select s.snum as "Salesperson Number",
s.sname as "Salesperson Name",
count(c.cnum) as "Number of Customers"
from salespeople s 
join cust c on s.snum = c.snum
group by s.snum, s.sname
having count(c.cnum) > 1;