create database Employee_Department_Analysis;
use employee_department_analysis;

create table dept (
deptno int primary key,
dname varchar(50),
loc varchar(50)
);

create table employee (
empno int primary key not null,
ename varchar(50),
job varchar(50) default 'CLERK',
mgr int,
hiredate date,
sal decimal (10, 2) check (sal > 0),
comm decimal (10, 2),
deptno int,
foreign key (deptno) references dept(deptno)
);


insert into employee (empno, ename, job, mgr, hiredate, sal, comm, deptno) values
(7369, 'SMITH', 'CLERK', 7902, '1890-12-17', 800.00, null, 20),
(7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600.00, 300.00, 30),
(7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250.00, 500.00, 30),
(7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975.00, null, 20),
(7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250.00, 1400.00, 30),
(7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850.00, null, 30),
(7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450.00, null, 10),
(7788, 'SCOTT', 'ANALYST', 7566, '1987-04-19', 3000.00, null, 20),
(7839, 'KING', 'PRESIDENT', null, '1981-11-17', 5000.00, null, 10),
(7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500.00, 0.00, 30),
(7876, 'ADAMS', 'CLERK', 7788, '1987-05-23', 1100.00, null, 20),
(7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950.00, null, 30),
(7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000.00, null, 20),
(7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300.00, null,10);

#1)
select * from employee;

INSERT INTO dept (deptno, dname, loc) VALUES (10, 'OPERATIONS', 'BOSTON'), (20, 'RESEARCH', 'DALLAS'), (30, 'SALES', 'CHICAGO'), (40, 'ACCOUNTING', 'NEW YORK');


#2)
select * from dept;


#3)
select ename, sal
from employee
where sal > 1000;


#4)
select * from employee
where hiredate < '1981-10-01';


#5)
select ename
from employee
where ename like '_I%';


#6)
select ename as "Employee Name",
sal as "Salary",
(sal * 0.40) as "Allowances",
(sal * 0.10) as "P.F.",
(sal + (sal * 0.40) - (sal * 0.10)) as "Net Salary"
from employee;


#7)
select ename as "Employee Name" ,job as "Designation"
from employee
where mgr is null;


#8)
select empno as "Employee Number", ename as "Employee Name", sal as "Salary"
from employee
order by sal asc;


#9)
select count(distinct job) as "Number of Jobs"
from employee;


#10)
select sum(sal) as "Total Payable Salary"
from employee 
where job = 'salesman';


#11)
select deptno as "Departmnet Number",
job as "Job Title",
format(round(avg(sal),2),2) as "Average Monthly Salary"
from employee
group by deptno, job;


#12)
select e.ename as "EMPNAME",
e.sal as "SALARY",
d.dname as "DEPTNAME"
from employee e
join dept d on e.deptno = d.deptno;


#13)
create table grade(
grade char(1) primary key not null,
lowest_sal int not null,
highest_sal int not null );

insert into grade (grade, lowest_sal, highest_sal) values
('A', 0, 999),
('B', 1000, 1999),
('C', 2000, 2999),
('D', 3000, 3999),
('E', 4000, 5000);

select * from grade;


#14)
select e.ename as "Last Name",
e.sal as "Salary",
g.grade as "Grade"
from employee e
join grade g on e.sal between g.lowest_sal and g.highest_sal;


#15)
select e1.ename as "Emp",
e2.ename as "Mgr"
from employee e1
left join employee e2 on e1.mgr = e2.empno;


#16)
select ename as "Empname",
(sal + coalesce(comm, 0)) as "Total Sal"
from employee;


#17)
select ename as "Empname",
sal as "Salary"
from employee
where mod(empno, 2)<>0;


#18)
select ename as "Empname",
sal as "Salary",
rank() over (order by sal desc) as "Org Rank",
rank() over (partition by deptno order by sal desc) as "Dept Rank"
from employee;


#19)
select ename as "Empname",
sal as "Salary"
from employee
order by sal desc
limit 3;


#20)
select e.ename as "Empname",
e.sal as "Salary",
e.deptno as "Department"
from employee e
join ( select deptno, max(sal) as Max_Sal
from employee
group by deptno
) Max_salaries
on e.deptno = Max_salaries.deptno and e.sal = Max_salaries.max_sal;