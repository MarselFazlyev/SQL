

select * from employees where length(first_name)>10;

select * from employees where MOD(salary,1000)=0;

select phone_number,substr(phone_number,0,3) 
from employees 
where phone_number like '___.___.____';

select * from employees 
where first_name like '%m' 
and length(first_name)>5;

select next_day(sysdate,5) next_friday from dual;

select * from employees where months_between(sysdate,hire_date)>150;

select  replace(phone_number,'.','-') from employees;

select UPPER(first_name),LOWER(email),INITCAP(job_id) from employees;

select concat(first_name,salary)from employees;

select hire_date,round(hire_date,'MM'),trunc(hire_date,'yyyy') from employees;

select rpad(first_name,10,'$'),lpad(last_name,15,'!') from employees;

select first_name, INSTR(first_name,'a',1,2) from employees;

select '!!!HELLO!!MY FRIEND!!!!!!!!',TRIM('!'from '!!!HELLO!!MY FRIEND!!!!!!!!')FROM DUAL;

select salary,salary*3.1415,round(salary*3.1415),trunc(salary*3.1415,-3)\1000 from employees;

select hire_date, add_months(hire_date,6),last_day(hire_date)from employees; 
