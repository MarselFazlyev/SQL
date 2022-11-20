## Single-Row функции
Функции в SQL бывают 2 видов:
- **single-row**
	1. Character
	2. Numeric
	3. Date
	4. Conversion
	5. General

### Character functions
* Case conversion functions - функции, которые работают с регистром букв. 	
	**LOWER(s)**-где s - это строка, текст.Делает все буквы аргумента маленькими.\
	**UPPER(s)** Делает все буквы большими.

```
Примеры LOWER
select first_name, LOWER(first_name) first_name from employees;

select LOWER ('PRIVET, KAK DELA?') FROM DUAL;

select LOWER ('PRIVET ' || 'KAK DELA?') FROM DUAL;

select first_name  from employees 
where LOWER(first_name) = 'david';

select first_name from employees
where LOWER(first_name) like '%en%';
```
```
select first_name from employees
where UPPER(first_name) like 'JOHN';

select first_name from employees
where UPPER(first_name) like '%T%';
select UPPER ('Privet kak dela? 32') from dual;
```




- **multiple-row**

