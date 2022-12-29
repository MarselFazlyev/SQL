1.
select * from employees where length(first_name) = (select MAX(length(first_name))from employees);


2.
select * from employees where salary> (select AVG(salary)from employees);


3
select city,sum(salary) from employees e 
join departments d on (e.department_id=d.department_id)
join locations l on (l.location_id=d.location_id)
having sum(salary) = (select min(sum(salary)) from employees e 
join departments d on (e.department_id=d.department_id)
join locations l on (l.location_id=d.location_id) group by city)
group by city;

4.
My first solution

select first_name,last_name,salary,
(select salary from employees e2 where (e1.manager_id=e2.employee_id)) "manager's_salary",
(select first_name from employees e2 where (e1.manager_id=e2.employee_id)) "manager's_name"
from employees e1
where (select salary from employees e2 where (e1.manager_id=e2.employee_id))>15000;

Second solution

select * from employees where manager_id in (select employee_id from employees where salary >15000);

5.
select * from departments d  left join employees e using (department_id) // альтернативное решение с join
where employee_id is null;

select * from departments d where department_id  not in (select department_id from employees where department_id is not null); 


6.
select * from employees e1
where employee_id not in (select manager_id from employees e2 where manager_id is not null);


7.
First Solution

select * from employees e1
where employee_id  in (select manager_id from employees e2 where manager_id is not null) 
and employee_id in (select manager_id from employees having count(*)>6
group by manager_id);

select count(*) manager_id from employees group by manager_id; //группировка по менеджерам

Second solution

select * from employees e
where (select count(*) from employees where manager_id = e.employee_id)>6;


8.
select * from employees where department_id in (select department_id from departments where department_name like UPPER('%IT%'));
 
9.//заменил 2005 год для наглядности 1989 годом 
First solution

select * from employees e1 where to_char(hire_date,'yyyy')<2005
and manager_id in (select employee_id from employees e1 where employee_id in  (select manager_id
from employees e2)and to_char(hire_date,'yyyy')=1989);

Second solution

select * from employees where manager_id in (select employee_id from employees where to_char(hire_date,'yyyy')='1989')
and hire_date < to_date('01012005','DDMMYYYY');



10.
select * from employees e where manager_id in 
(select employee_id from employees where to_char(hire_date,'MM')='01')
and (select length(job_title) from jobs where e.job_id=jobs.job_id)>15;