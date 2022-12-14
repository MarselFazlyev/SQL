1.
select department_id, min(salary),max(salary),min(hire_date),max(hire_date),count(*) 
from employees
group by department_id
order by count(*) desc;

2.
select substr(first_name,1,1) first_word,count(substr(first_name,1,1)) "count employees" 
from employees
group by substr(first_name,1,1) 
having count(substr(first_name,1,1))>1
order by "count employees";

3.
select department_id,salary,count(*) from employees
group by department_id,salary;
 
4.
select to_char(hire_date,'Day') day, count(*) from employees
group by to_char(hire_date,'Day');

5.
select department_id from employees
group by department_id
having count(*)>30 and sum(salary)>300000;

6.
select region_id,sum(length(country_name)) from countries group by region_id ;

select region_id from countries
group by region_id
having sum(length(country_name))>50;

7.
select job_id , round(avg(salary)) from employees
group by job_id;

8.
select department_id from employees
group by department_id
having count(distinct job_id)>1;

9.
select department_id,job_id,min(salary),max(salary) from employees
group by department_id,job_id
having avg(salary)>10000;

10.
select manager_id  from employees
where commission_pct is null
group by manager_id 
having avg(salary) between 6000 and 9000;

11.
select Round(MAX(AVG(salary)),-3) from employees
group by department_id;