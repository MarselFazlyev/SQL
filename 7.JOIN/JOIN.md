### JOIN
- **Inner Join(natural Join)** - объединение таблиц по одинаковому критерию
- **Outer Join**
- **Cross Join** 
- **Equi Join**
- **Nonqui Join**
- **Oracle Join**(не относится к стандарту SQL)

### Inner Join (Natural Join)
Cуществует три типа использования Inner Join:
1) Cам Natural Join
2) с использованием **Using**
3) с использованием **On**

Нередеко первую таблицу для объединения называют **source**, вторую-**target**
select column(s)
from table_1
Natural Join
table_2

### Natural Join - объединяет таблицы по столбцам с одинаковыми именами.
```
select * from regions natural join countries;
// к regions присоединилась таблица countries по общему столбцу region_id; 
```
Natural join не дает возможность объединить таблицы по критерию, который мы хотим, объединяет только по общемц столбцу с одинаковым названием в обеих таблицах.
этот столбец нельзя привязывать к конкретной таблице с полным названием, он общий. Если таблица была названа каким либо алиасом, то полное обращение к ее столбцам осуществляется только по алиасу.

**Общий столбец (объединительный - обращение  только по короткому имени!!!**
```
select country_name,country_id,region_id,region_name // столбцы с коротким именем
from regions r NATURAL JOIN countries c;

select c.country_name,c.country_id, region_id,r.region_name // столбцы с полным  именем (region_id - общий столбец для обеих таблиц)
from regions r NATURAL JOIN countries c;
```

Примеры объединения по нескольким столбцам:
```
select first_name,last_name,salary,department_name,department_id,manager_id 
from employees NATURAL JOIN departments; //таблицв объединились по столбцам department_id,manager_id
//строки  в обеих таблицах, где равны и department_id  и manager_id
```
Минусы **natural Join**:
- не предоставляется возможность выбрать столбцы для объединения, **natural join** всегда объединяет таблицы по столбцам с одинаковыми названиями(будет 1 столбец с одинаковыми названиями в обеих таблицах- объединит по нему, будет 3 - объединит по трем одинаковым столбцам и т.д.).
- могут быть столбцы с разными названиями, по которым надо объединить таблицы,**natural join** не поддерживает такую функциональность.
- иногда **natural join** выдает чушь - столбцы могут иметь одно название, но информация в них- разного рода.
- стоолбцы, по которым **natural join** объединяет, могут быть разного типа данных, вылетит ошибка.

### Natural join with USING - позволяет сделать **natural join**,выбрав столюец (также с одинаковым именем) для объединения.
SELECT column(s) 
FROM table_1
JOIN
table_2
USING(column(s));

- общий столбец пишется строго по короткому имени\
- если объединение таблиц происходит без участия одного или нескольких общих столбцов, то такие столбцы пишутся с обязательным уточнением, по полному имени.
```
select first_name,last_name,salary,department_name,department_id,e.manager_id 
from employees e JOIN departments d using (department_id);
```

```
select * from countries join regions using (region_id);

select first_name,last_name,jh.job_id, start_date,end_date
from employees join job_history jh using(employee_id);
```
данный join лучше,чем natural join, так как более нагляден. И если в таблицах будут совпадать имена других столбцов, то natural join будет объединять и по ним тоже, а **join с Using** будет по прежнему объединять только по выбранному столбцу.

Плюсы\
- По сравнению с **natural join** позволяет выбрать столбец объединения\
Минусы\
- По-прежнему, объединениие происходит по имени столбца, а это неудобно

### Natural join with ON 

select * from regions r 
join
countries c
on(r.region_id=c.region_id);

Если нужно сделать join по столбцам с разным именем, рекомендуется использовать **join with on**\
В отличие от **natural join** и **join with using**, в natural **join with on** столбец объединения надо конкретизировать (хотя они полностью равны)
```
select first_name,last_name,jh.job_id, start_date,end_date,employees.employee_id,jh.employee_id
from employees join job_history jh on (employees.employee_id = jh.employee_id);

select * from regions join departments
on (region_id*10=department_Id);

select first_name,last_name,jh.job_id, start_date,end_date,employees.employee_id,jh.employee_id
from employees join job_history jh 
on (employees.employee_id = jh.employee_id and employees.department_id = jh.department_id)
where salary >10000; // объединение по двум столбцам
```  
Вообще рекомендуется из всех трех **Inner Join** применять только **Join on**

### Объединение трех и более таблиц с помощью Inner Join-ов.
```
select * from locations NATURAL JOIN countries NATURAL JOIN regions; //сначала объединятся  "locations" и "countries" по столбцу "country_id"
// затем объединенная таблица и таюлица "regions" по столбцу 

select * from locations JOIN countries USING (country_id) JOIN regions USING(region_id) // вариант объединения с использованием JOIN USING

select first_name, last_name, jh.job_id, start_date, end_date, department_name
from employees e join job_history jh on (e.employee_id=jh.employee_id)
join departments d on (jh.department_id=d.department_id);

select department_name,min(salary),max(salary)
from employees e JOIN departments d ON (e.department_id=d.department_id)
group by department_name order by department_name DESC;
``` 
### NonEquiJoin with ON - объединение происходит по условию неравенства столбцов 
SELECT column(s)
from table_1
JOIN table_2
on(column_1{оператор неравенства}column_2);

```
select first_name,last_name,salary,min_salary,max_salary 
from employees e JOIN jobs j ON (e.job_id = j.job_id AND salary*2<max_salary);

select first_name,last_name,salary,min_salary,max_salary 
from employees e JOIN jobs j ON (e.job_id = j.job_id AND salary between min_salary+2000 and max_salary -3000);
```

### Self Join - объединение данных из одной и той же таблицы
таблица разбивается на две мнимые таблицы и делается **JOIN ON**
```
select emp1.employee_id,emp1.first_name,
emp2.manager_Id,emp2.first_name manager_name
from employees emp1 JOIN employees emp2 ON (emp1.manager_id=emp2.employee_id);
```

### Outer Join
Делится на:
 - **LEFT OUTER JOIN**(выводится информация по Inner Join и потом прибавляется информация по всем строкам из левой таблицы,для которых условие объединения   не было удовлетворено. )
 - **RIGHT OUTER JOIN**(выводится информация по Inner Join и потом прибавляется информация по всем строкам из правой  таблицы,для которых условие объединения   не было удовлетворено.)
 - **FULL OUTER JOIN**(выводится информация по Inner Join и потом прибавляется информация по всем строкам из левой таблицы,для которых условие объединения   не было удовлетворено,прибавляется информация по всем строкам из правой  таблицы,для которых условие объединения не было удовлетворено)

 ### LEFT OUTER JOIN

 SELECT column(s) FROM 
 table_1 LEFT OUTER JOIN table_2
 ON (column_1=column_2);

  ```
select first_name, last_name,salary,department_name
from employees e LEFT OUTER JOIN departments d ON (e.department_id = d.department_id)
where department_name LIKE '%i%'; // условие where работает для всех строк итогового output

select first_name,last_name,salary,min_salary,max_salary 
from employees e LEFT OUTER JOIN jobs j ON (e.job_id = j.job_id AND salary*2<max_salary);
//выведется inner join+инфа из левой таблицы,не удовлетворяющая условию объединения.

select department_name,d.department_id,first_name 
from departments d LEFT OUTER JOIN employees e on (d.department_id=e.department_id)
where first_name is null ;
  ```

