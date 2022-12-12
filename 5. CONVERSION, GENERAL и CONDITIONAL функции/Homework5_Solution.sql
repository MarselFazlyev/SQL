select * from employees 
where INSTR(LOWER(first_name),'b')>0;

select * from employees
where INSTR(LOWER(first_name),'a',1,2)> 0;