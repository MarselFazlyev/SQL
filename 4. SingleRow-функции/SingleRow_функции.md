## Single-Row функции
Функции в SQL бывают 2 видов: 
**single-row**- на каждый input есть output ,
**multiple-row - на много input один output**

могут быть вложены сколько угодно раз

 **single-row**
	1. Character
	2. Numeric
	3. Date
	4. Conversion
	5. General

### Character functions
#### **Case conversion functions** - функции, которые работают с регистром букв.

   - **LOWER(s)**-где s - это строка, текст.Делает все буквы аргумента маленькими.\
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
   - **UPPER(s)** Делает все буквы большими.

``` 
Примеры Upper
select first_name from employees
where UPPER(first_name) like 'JOHN';

select first_name from employees
where UPPER(first_name) like '%T%';
select UPPER ('Privet kak dela? 32') from dual;
```
   - **INITCAP(s)**- делает первую букву заглавной, остальные- прописными.
```
Примеры INITCAP
select INITCAP('PRIVET KAK DELA?') from dual;
select INITCAP('PRIVET '|| 'KAK '||'DELA?') from dual;
select INITCAP ('PRivet,Kak Ti?Chto_xoroshego?Vse po staromu!Ti kak?') from dual;
```
функция воспринимает как разделитель слов не только пробел, но и запятые,underscore и прочие

### **Character manipulation functions** 
    
		- **CONCAT(s,s)** - функция конкатенвции строк, применяют на практике ||, это удобнее
		- **SYSDATE** -возвращает текущую дату, также можно вытянуть текущее время
```
Примеры CONCAT
select CONCAT ('Privet','Drug') from dual;
select CONCAT (55,'Drug') from dual;
select CONCAT (salary*2,hire_date) from employees;
select CONCAT ('privet ' , CONCAT('MOI',' DRUG')) from dual;

Пример CONCAT и SYSDATE
select CONCAT ('today is ',SYSDATE) from dual;

```
- **LENGTH(s)**- функция вычисляет длину строки
```
Пример LENGTH
select first_name,LENGTH(first_name) dlina from employees;
select LENGTH ('VASYA PUPKIN') length from dual;
select LENGTH ('My name is '|| first_name || ' and surname is '|| last_name) from employees;
select LENGTH ('My name is '|| first_name || ' and surname is '|| last_name)length from employees;
select country_name from countries 
where LENGTH(country_name)>5;
```
- **LPAD,RPAD(s,n,p)**- s-строка,n-конечная длина текста, p-текст для заполнения.\
	добавляет символы слева или справа от текста.
	ВНИМАНИЕ!! ЕсЛИ КОНЕЧНУЮ ДЛИНУ ПОСТАВИТЬ МЕНЬШЕ ТЕКСТА, ТО ТЕКСТ УРЕЖЕТСЯ ДО УКАЗАННОЙ ДЛИНЫ!!! 
```	
Пример LPAD,RPAD
select LPAD('MARSEL',10,'#')from dual;
select first_name,RPAD(first_name,22,'$')FROM employees;
select LPAD('privet',5,'!') from dual; //текст урежется до "prive"
select RPAD(first_name,15,' ')||LPAD(salary,8,' ')from employees;
```
- **TRIM** - удаляет символы с начала либо с конца,либо и с конца, и с начала вместе\
       		* trailing - удаление с конца текста,leading
       		* leading - удаление с начала текста
       		* both - удаление и с начала, и с конца (both можно не писать)
    если нужно удалить с обеих сторон имеенно пробелы, то можно просто в аргументах оставить текст\
    функция TRIM удаляет только один символ.
     
```	
Пример TRIM
select TRIM (trailing 'q' from 'Marsel') from dual;
select TRIM (leading '*' from '***Marsel***')from dual;
select TRIM (both '*' from '***Marsel***')from dual;
select TRIM ('*' from '***Marsel***')from dual;
select TRIM(' ' from '     Marsel  ')from dual;
select TRIM(' ' from '     Marsel   Marsel  ')from dual; //пробелы в середине текста затронуты не будут
select TRIM ('    Marsel           ') from dual;

```

- **INSTR**(s,search string,start position,Nth occurence) - s-строка,текст, search string-искомый текст;\
    возвращает позицию нашего текста в искомом тексте,начинает со start position, и выявляет n-ое появление этого элемента
	start position-позиция для начала работы;Nth occurence - N-ое появление; number of characters- количество символов;\
	
```
	пример INSTR
	SELECT INSTR('Marsikus perpetum_mobile','i',2,2)from dual;
	SELECT INSTR('Marsikus perpetum_mobile','mobile')from dual;
```

- **SUBSTRING**(s,start position,number of characters) - изымает и возвращает отрывок из текста
	если start position больше длины нашего текста, то вернется null
	если в количестве запрашиваемых симовлов поставить "-",то отсчет старта будет с конца
	number of characters- количество символов;\
```
	пример SUBSTR
select email, SUBSTR(email,4) from employees;
select email, SUBSTR(email,4,2) from employees;
select SUBSTR ('Privet, kak dela?',7,5) from dual;
select hire_date,SUBSTR(hire_date,2,3) from employees;
select hire_date,SUBSTR(hire_date,-4) from employees;
select hire_date,SUBSTR(hire_date,-4,2) from employees;


```
- **Replace**(s,search item,replacement item) -	заменяет item на replacement item
	если replacement item не указать,то item по всему тексту удалится.
	search item - искомый элемент; replacement item - заменяющий элемент.
```
	пример Replace
select REPLACE('Privet, kak dela?','e','U') FROM DUAL;
select REPLACE('Privet, kak dela?','e') FROM DUAL;
select salary, REPLACE(SALARY,1,9) FROM employees;
```
### **Numeric functions** -  функции для работы с числами

- **ROUND**(n,precision) - округляет число (n-число, precision-точность);
	если precision не указать, число округлится до целого
	если precision отрицательный, то округляются разряды целого числа
```
	пример Round
select Round(23.34,1) from dual;
select salary*3.1415,round(salary*3.1415) from employees; //округление до целого числа
select ROUND(3456.123,-1)FROM DUAL;
SELECT round (SYSDATE-hire_date)*employee_id from employees;
```
- **TRUNC**(n,precision) - позож на **ROUND**,но он отсекает, не округляя.
	если отсекается целая часть (precision отрицателен), то данный отсекаемый разряд раен нулю
```
	пример TRUNC
SELECT TRUNC(234.567,2) FROM DUAL; // результатом будет 234.56
SELECT ROUND (234.567,2) FROM DUAL; //результатом будет 234.57

select TRUNC(30582,-2) from dual; // результат 30500
```
- **MOD**(divident,divisor) - возвращает остаток от деления. divident-делимое, divisor-делитель
```
select MOD(5,2)FROM DUAL;
select MOD(3.5,2)FROM DUAL;
select * from employees where MOD(employee_id,2)=0;
```

### Date functions - функции для работы с датами

- **SYSDATE** - возвращает время на database-сервере.Если database на нашем компе, то возвращается время на нашем компе.
```
пример SYSDATE 
select TO_CHAR(sysdate, 'DD-MM-RR hh24:mi:ss') from dual; // время на сервере
select sysdate - hire_date from employees;
select sysdate+5 from employees;
```
- **MONTHS_BETWEEN**(start_date,end_date) - возвращает количество месяцев между датами
```
пример MONTHS_BETWEEN
select employee_id,MONTHS_BETWEEN(end_date,start_date)from job_history;
select MONTHS_BETWEEN('22.11.22','20.01.22')FROM DUAL;

```
- **ADD_MONTHS(date,number_of_months)** - добавляет месяцы к дате
```
пример ADD_MONTHS
select end_date, add_months(end_date,6) from job_history;
```
- **NEXT_DAY**(date,day_of_the_week) - возвращает следуюший соответсвующий одному из дней недели день от введенной даты\
	ВНИМАНИЕ,если отсчет вренени по американской системе, то у них 1- не понедельник, а воскресенье и т.д.!!!
```
пример NEXT_DAY
select NEXT_DAY(sysdate,2) from dual; // вернет следующий вторник от текущей даты.
select NEXT_DAY(sysdate,'четверг') from dual;
select NEXT_DAY(sysdate,'пт') from dual;
select NEXT_DAY('31.12.22',1)-7 from dual; // последний понедельник года
```	
- **LAST_DAY**(date) - возвращает последню дату в введенном месяце. 
```
пример LAST_DAY
select LAST_DAY(SYSDATE) FROM DUAL;
select LAST_DAY('26.12.89') FROM DUAL;
```	
- **ROUND(для даты)** (date,date precision format)** - округляет даты
    date precision format-точность округления
	в зависимости от точности, округление может быть:
	* Век - CC
	* год - YYYY
	* четверть - Q 
	* месяц - MM
	* неделя - W
	* день - DD
	* час - HH
	* минута - MI
```
пример ROUND
select ROUND(hire_date, 'CC') FROM employees;
```	
- **TRUNC(для даты)**(date,date precision format) - обрубает с заданной точностью, не округляя
```
пример ROUND
select ROUND(hire_date, 'CC') FROM employees;
select TRUNC(hire_date,'yyyy')from employees;
select TRUNC(hire_date,'Q')from employees;
```	
