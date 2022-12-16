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

**Natural Join** - объединяет таблицы по столбцам с одинаковыми именами.
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

**Natural join with USING**- позволяет сделать **natural join**,выбрав столюец (также с одинаковым именем) для объединения.
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
```
данный join лучше,чем natural join, так как более нагляден. И если в таблицах будут совпадать имена других столбцов, то natural join будет объединять и по ним тоже, а **join с Using** будет по прежнему объединять только по выбранному столбцу.

