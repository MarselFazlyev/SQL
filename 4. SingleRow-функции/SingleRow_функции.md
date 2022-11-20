## Single-Row функции
Функции в SQL бывают 2 видов:
- **single-row**
	1. Character
	2. Numeric
	3. Date
	4. Conversion
	5. General

### Character functions
1. **Case conversion functions** - функции, которые работают с регистром букв. 	
   		- **LOWER(s)**-где s - это строка, текст.Делает все буквы аргумента маленькими.\
		- **UPPER(s)** Делает все буквы большими.
		- **INITCAP(s)- делает первую букву заглавной, остальные- прописными.
	        функция воспринимает как разделитель слов не только пробел, но и запятые,underscore и прочие
2. **Character manipulation functions** 	    
		- **CONCAT(s,s)** - функция конкатенвции строк, применяют на практике ||, это удобнее
		- **SYSDATE** -возвращает текущее число
		- **LENGTH(s)**- функция вычисояет длину строки


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
Примеры Upper
select first_name from employees
where UPPER(first_name) like 'JOHN';

select first_name from employees
where UPPER(first_name) like '%T%';
select UPPER ('Privet kak dela? 32') from dual;
```
```
Примеры INITCAP
select INITCAP('PRIVET KAK DELA?') from dual;
select INITCAP('PRIVET '|| 'KAK '||'DELA?') from dual;
select INITCAP ('PRivet,Kak Ti?Chto_xoroshego?Vse po staromu!Ti kak?') from dual;
```
``` 
Примеры CONCAT
select CONCAT ('Privet','Drug') from dual;
select CONCAT (55,'Drug') from dual;
select CONCAT (salary*2,hire_date) from employees;
select CONCAT ('privet ' , CONCAT('MOI',' DRUG')) from dual;

Пример CONCAT и SYSDATE
select CONCAT ('today is ',SYSDATE) from dual;

```
```
Пример LENGTH
select first_name,LENGTH(first_name) dlina from employees;
select LENGTH ('VASYA PUPKIN') length from dual;
select LENGTH ('My name is '|| first_name || ' and surname is '|| last_name) from employees;
select LENGTH ('My name is '|| first_name || ' and surname is '|| last_name)length from employees;

```

