1.
select * from employees where length(first_name) =  (select MAX(length(first_name))from employees);


2.
select * from employees where salary> (select AVG(salary)from employees);


3
select city,sum(salary) sum from employees e 
join departments d on (e.department_id=d.department_id)
join locations l on (l.location_id=d.location_id)
where ???????????????
group by city;


4.
select first_name,last_name,salary,
(select salary from employees e2 where (e1.manager_id=e2.employee_id)) "manager's_salary",
(select first_name from employees e2 where (e1.manager_id=e2.employee_id)) "manager's_name"
from employees e1
where (select salary from employees e2 where (e1.manager_id=e2.employee_id))>15000;


5.
select * from departments d  left join employees e using (department_id) // альтернативное решение с join
where employee_id is null;

select * from departments d where department_id  not in (select department_id from employees where department_id is not null); 


6.
select * from employees e1
where employee_id not in (select manager_id from employees e2 where manager_id is not null);


7.
select * from employees e1
where employee_id  in (select manager_id from employees e2 where manager_id is not null) 
and employee_id in (select manager_id from employees having count(*)>6
group by manager_id);

select count(*) manager_id from employees group by manager_id; //группировка по менеджерам



8.
select * from employees where department_id in (select department_id from departments where department_name like UPPER('%IT%'));

9.//заменил 2005 год для наглядности 1989 годом 
select * from employees e1 where to_char(hire_date,'yyyy')<2005
and manager_id in (select employee_id from employees e1 where employee_id in  (select manager_id
from employees e2)and to_char(hire_date,'yyyy')=1989);

10.
select * from employees e1 
where manager_id in 
(select employee_id from employees e1 where employee_id in (select manager_id from employees e2 )and to_char(hire_date,'MM')LIKE'01')
and employee_id in (select employee_id from job_history where job_id in (select job_id from jobs where length(job_title)>15));