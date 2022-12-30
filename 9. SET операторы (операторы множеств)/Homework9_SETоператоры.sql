1. 
select manager_id,to_char(null) job_id, to_number(null) department_id,sum(salary) from employees group by manager_id
UNION 
select to_number(null),job_id,to_number(null),sum(salary) from employees group by job_id
UNION 
select to_number(null),to_char(null),department_id,sum(salary) from employees group by department_id;


2.
select department_id from employees where manager_id =100
minus 
select department_id from employees where manager_id  in (145,201)
order by 1;

3.
select first_name,last_name,salary from employees
where first_name like '_a%'
intersect 
select first_name,last_name,salary from employees
where lower(last_name)  like ('%s%')
order by salary DESC;

4.

select location_id,postal_code,city from locations 
where country_id in (select country_id from countries where country_name in ('Germany','Italy'))
UNION ALL
select location_id,postal_code,city from locations
where to_char(postal_code) like '%9%';

5.

select country_id id ,country_name country,region_id region from countries where length(country_name)>8
UNION
select country_id,country_name,region_id from countries where region_id not in (select region_id from regions where region_name ='Europe')
order by country DESC;

