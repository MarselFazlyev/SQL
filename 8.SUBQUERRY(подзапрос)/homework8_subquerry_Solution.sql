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

6.??????????????????????
select * from employees e1 where e1.manager_id not in (select e2.employee_id from employees e2 where e1.manager_id = e2.employee_id);
