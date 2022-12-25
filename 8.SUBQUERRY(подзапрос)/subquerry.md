## Subquery (подзапрос)
```
select first_name,last_name,salary 
from employees
where salary>(select AVG(salary)from employees);
```
- подзапрос- это запрос в запросе.

- первый в данном примере **select** еще называют **outer query**,второй **select**-**inner query**

- !! **subquery** всегда срабатывает перед тем, как срабатывает основной select.\ (сначала inner query,потом outer query)

- **subquery** всегда надо обрачивать круглыми скобками, иначе запрос не сработает. 

- в любом subquery должен быть мимнимум **select** и **from**.

- подзапросов может быть сколько угодно

```
select (select MIN(min_salary) from jobs) min_salary,
(select MAX(length(first_name))from employees) max_length_first_name
from dual;
```



