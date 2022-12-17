1.
select count(*),r.region_id 
from employees e
join departments d on (e.department_id=d.department_id)
join locations l on (d.location_id=l.location_id)
join countries c on (l.country_id =c.country_id)
join regions r on (c.region_id=r.region_id)
where r.region_id is not  null
group by r.region_id;

2.
select first_name,last_name,NVL(department_name,'NO DEPARTMENT'),
NVL(street_address,'NO ADDRESS'),NVL(postal_code,'NO POSTAL CODE'),
NVL(city,'NO CITY'),NVL(state_province,'NO STATE'),
NVL(country_name,'NO COUNTRY'),NVL(region_name,'NO REGION')
from employees e 
left outer join departments d on (e.department_id=d.department_id) 
left outer join locations l on (d.location_id=l.location_id)
left outer join countries c on (c.country_id=l.country_id)
left outer join regions r on (r.region_id=c.region_id);

3.
select e2.first_name "manager name", count(*) employees
from employees e1 join employees e2 on (e1.manager_id=e2.employee_id)
group by e2.first_name
having count(*) >6
order by 2;

4.
select department_name,count(*) 
from departments
join employees using (department_id)
group by department_name
having count(*)>30;

5.
select department_name from departments d
LEFT OUTER JOIN employees e using (department_id)
where employee_id is null;

6. Комментарий (в 2005 году не устраивался ни один менеджер,
 поэтому был взят самый распространненный год устройства на работу -1997)

select * from employees e1
join employees e2 on (e1.manager_id=e2.employee_id)
where to_char(e2.hire_date,'yyyy') = '1997' and to_char (e1.hire_date,'yyyy')<1997;

7.
select country_name,region_name 
from countries natural join regions;

8.
select first_name,last_name,salary,min_salary+1000
from employees e join jobs j on (e.job_id=j.job_id and e.salary<min_salary+1000);

9.
select distinct first_name,last_name,country_name from employees
left outer join departments using (department_id)
left outer join locations using (location_id)
full outer join countries using (country_id);

10.
select first_name,last_name, country_name from 
employees CROSS JOIN countries;

11.

select count(*),r.region_id 
from employees e,departments d,locations l,countries c,regions r  
where e.department_id=d.department_id 
and d.location_id=l.location_id 
and l.country_id =c.country_id 
and c.region_id=r.region_id
and r.region_id is not  null
group by r.region_id;

12.

select department_name 
from departments d,employees e 
where d.department_id=e.department_id(+)
and employee_id is null;