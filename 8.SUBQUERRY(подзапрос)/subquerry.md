## Subquery (подзапрос)
### типы subquery

1) **SINGLE ROW** - subquery,который возвращает лишь одну строку
2) **MULTIPLE ROW**  - subquery,который возвращает множество строк
3) **SCALAR** - частный случай **single row subquery**,который возвращает одну строку и один столбец (одно значение)
```
select salary from employees where employee_id=113;
```
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

select first_name,last_name from employees
where employee_id IN (select manager_id from employees); // Найти имя фамилию всех менеджеров 

select department_name,MIN(salary),MAX(salary)
from (select salary,department_name from employees e
join departments d on (e.department_id=d.department_id))
group by department_name
having MAX(salary)>(select 2*5000 from dual)
and MIN(salary)<(select salary from employees where employee_id=113);
```
### SINGLE ROW subqueries
```
select * from employees where salary <0.2*(select MAX(salary) from employees);

select * from employees 
where salary>(select avg(salary)from employees);

select * from employees 
where salary >= (select salary from employees where employee_id=180 );
```
когда мы исрользуем неравенство, то subquery должен быть именно **scalar**, иначе будет выброшена ошибка,что слищком много аргументов, с чем сравнивать.
```
select job_title from jobs j join employees e on (j.job_id=e.job_id)
where salary = (select max(avg(salary)) from employees
group by job_id);
```

### MULTIPLE ROW subqueries
вместо неравенств можно использовать ключевые слова **IN**,**ANY**,**ALL**
```
select * from employees
where job_id in (select job_id from jobs where min_salary>8000);

select * from employees e join jobs j on (e.job_id=j.job_id)
where min_salary >8000; //альтернативное решение через JOIN
```
**ANY**
```
select first_name,last_name,salary from employees
where salary > ANY(select salary from employees where department_id =100);
// зарплата должна быть больше любой зарплаты из списка подзапроса
```
**ALL**
```
select first_name,last_name,salary from employees
where salary > ANY(select salary from employees where department_id =100);
// зарплата должна быть больше каждой зарплаты из списка подзапроса
```

```
Примеры:
select distinct(department_name) from departments d left outer  join employees e on (d.department_id=e.department_id)
where employee_id is not null;

select department_name from departments
where department_id IN  (select distinct department_id from employees);
```

### CORRELATED SUBQUERIES (подзапрос,связанный с внешним запросом)

```
select e1.first_name,e1.last_name,e1.salary from employees e1
where e1.salary>(select AVG(e2.salary) from employees e2
where e1.department_id=e2.department_id);
```
минус CORRELATED SUBQUERIES - очень долгий запрос,необходимо прибегать в случае отсутствия других возможностей.

### Пример nested subquery (альтернатива join)
```
select first_name,last_name,salary from employees 
where department_id IN (select department_id from departments where location_id IN
(select location_id from locations where country_id in 
(select country_id from countries where country_name = 'Germany')));
```