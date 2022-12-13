select * from employees 
where INSTR(LOWER(first_name),'b')>0;

select * from employees
where INSTR(LOWER(first_name),'a',1,2)> 0;

select department_name,substr(department_name,1,instr(department_name,' ')-1) result 
from departments
where substr(department_name,1,instr(department_name,' ')-1) is not null;

select first_name,substr(first_name,2,length(first_name)-2) from employees;

select * from employees
where length(substr(job_id,instr(job_id,'_')+1))>2
and substr(job_id,instr(job_id,'_')+1) != 'CLERK' ;

select * from employees where to_number(to_char(hire_date,'dd'))=1;

select * from employees where to_number(to_char(hire_date,'yyyy'))=2008;

select 'Tomorrow is '||to_char(sysdate+1,'dd')||' day of '|| to_char(sysdate+1,'Month') from dual;

select salary, to_char(salary*1.2,'$99,999.99') "salary*20%" from employees;

select  to_char(to_date
((to_char(sysdate,'yy')+1||
(case
when to_number(to_char(sysdate,'mm')+1)>=12 
then to_char(sysdate,'mm') 
else to_char(to_number(to_char(sysdate,'mm'),'99')+1,'99') 
end)
||
to_char(sysdate,'dd')+1||
to_char(sysdate,'hh24')+1||
to_char(sysdate,'mi')+1||
to_char(sysdate,'ss')+1),'yymmddhh24miss'),'dd-Mon-RR hh24:mi:ss') new_date
from dual;

select first_name,salary,
to_number('$12,345.55','$99,999.99')+salary
"new salary" from employees;

select first_name,hire_date,
ROUND(MONTHS_BETWEEN (to_date('SEP, 18:45:00 18 2009','MON, HH24:mi:ss dd yyyy'),hire_date)) as new_date from employees;

select first_name,hire_date,
ROUND(MONTHS_BETWEEN (to_date('SEP, 18:45:00 18 2009','MON, HH24:mi:ss dd yyyy'),hire_date)) as new_date from employees;


select first_name,last_name, 
NVL2(NULLIF(length(first_name),length(last_name)),'Different Length','Same Length')
from employees;

select * from employees;
select first_name,commission_pct,NVL2(commission_pct,'yes','no') commission_status from employees;

select first_name,COALESCE(commission_pct,manager_id,salary)from employees;

select first_name,salary,
case
when salary<5000 then 'Low level'
when salary between 5000 and 9999 then 'Normal level'
when salary >=10000 then 'High level'
else 'No information'
end
from employees;


select country_name, DECODE(region_id,1,'Europe',2,'America',3,'Asia',4,'Africa','Incorrect input')
region from countries;

select country_name,case(region_id)
when 1 then 'Europe'
when 2 then 'America'
when 3 then 'Asia'
when 4 then 'Africa'
else 'incorrect input'
end
as region 
from countries


select first_name,salary,commission_pct,case
when salary <10000 and commission_pct is null then 'Bad'
when salary between 10000 and 14999 or commission_pct is not null then 'Normal'
when salary > 15000 then 'Good'
end
condition
from employees;






