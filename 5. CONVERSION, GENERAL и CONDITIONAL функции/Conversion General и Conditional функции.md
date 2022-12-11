## Conversion ,General и Conditonal функции

### Conversion functions (функции ковертации)

- **TO_CHAR(number to char)** *(number,format mask,nls_parameters)* - конвертирует число или дату в текст.\
	**nls_parameters**(national language parameters) - настройки парметров языка,могут различаться форматы дат и прочее..\

#### Примеры различных форматов текстов для числа:

```
	select TO_CHAR (18,'99999') from dual; //максимальный размер текста - 5 символов в данном примере
	select TO_CHAR (18,'09999') from dual; // заполнение нулями в начале числа
	select TO_CHAR (18.35,'09999.999') from dual; //формат десятичного числа
	select TO_CHAR (18.35,'09999D999') from dual; // альтернативная запись,результат аналогичен предыдущему
	select TO_CHAR (1234567,'99,999,999') from dual;
 	select TO_CHAR (18,'$0999') from dual;
 	select TO_CHAR (18,'L09999') from dual;//локальная валюта
 	select TO_CHAR (-18,'9999MI') from dual; //для отрицательного числа ( текст 0018-)
 	select TO_CHAR (-18,'099999PR') from dual; //для отрицательных чисел второй варинант (текст <000018> )
 	select TO_CHAR (18,'S9999') from dual; //явное указание знака (перед числом будет либо "+",либо "-")
```
#### Примеры различных форматов текстов для даты:

**применение оператора "fm"срезает все лишние пробелы**\
**если добаввить к формату оператор sp,то число будет прочитано**
select to_char(sysdate,'yyyysp') from dual; 
```
Y- последняя цифра года 
select  TO_CHAR(sysdate, 'Y') from dual; 
select TO_CHAR('20-SEP-83','Y') from dual; - //будет ошибка,oracle не понимает, что это дата.
YY- посление 2 цифры года
YYY- посление 3 цифры года
YYYY- год целиком
RR- год в формате 2 цифр
YEAR - буквенное написание года (Case sensitive-чувствительны к регистру)
select  TO_CHAR(sysdate, 'YEAR') from dual;
MM - месяц в формате двух цифр
MON - 3 буквы из названия месяца (case sensitive)
MONTH - ,буквенное написание месяца
Если нужно представить на русском языке то нужно использовать русский язык

D - день недели
DD - день месяца
DDD - день года
DY - 3 буквы из названия дня недели
DAY - полное название дня недели
W- неделя месяца
WW -неделя года
Q -квартал года 
СС - век

```
```
select TO_CHAR('23-SEP-22') from dual;
select TO_CHAR(SYSDATE,'Month')from dual;
select hire_date, TO_CHAR(hire_date,'Month')from employees;
select hire_date, TO_CHAR(hire_date,'Month','NLS_DATE_LANGUAGE=RUSSIAN') FROM employees;

select hire_date, TO_CHAR(hire_date,'Month') || 'hello' FROM EMPLOYEES; // пример без оператора "fm"
select hire_date, TO_CHAR(hire_date,'fmMonth') || 'hello' FROM EMPLOYEES; //применение оператора "fm"срезает все лишние пробелы
select first_name,hire_date from employees where to_char(hire_date,'fmMonth')='August';

select to_char(sysdate,'d')from dual; / день недели по счету
select to_char(sysdate,'dd')from dual; / день месяца
select to_char(sysdate,'ddd')from dual; /день года
select to_char(sysdate,'CC') from dual;
select to_char(sysdate,'q')from dual;

```
#### Примеры различных форматов текстов для времени:
```
Элемент               Описание                    Текст

AM,PM A.M. и P.M.     Индикатор                   PM

HH,HH12 И HH24        Формат времени              04,04,16

MI                    Минуты                      17

SS                    Секунды                     18

SSSSS                 Секунды после полуночи      0082

-/.,?#!               Пунктуация: 'ММ/YY'         09.19      

"Любой текст"         '"Quarter" Q "of" Year'     Quarter 3 of Twenty Twenty two

TH                    'DDth "of" Month'           20TH of September

SP                    Буквенное написание(spell)  Nine September Two Thousand Nineteen
                      'MmSP Month Yyyysp'   

THSP или SPTH         Комбинация: 'hh24SpTh'      sixteenth
```
```
select to_char(sysdate,'"Quarter" Q "of" Year')from dual;
select to_char(sysdate,'DDth "of" Month')from dual;
select to_char(sysdate,'Day ?Month/yyyy') from dual;
select to_char(sysdate,'DD "of" Month') from dual;
select to_char(sysdate,'yyyysp ddsp ') from dual;
select 'my collegue with ID = '|| employee_id || ' and job_id ='|| job_id || ' joined us on '|| to_char(hire_date,'fmDay "the " ddTH "of" fmMonth yyyy') from employees;
```

### Char to date
TO_DATE(text,format mask,nls parameters) = D
конвертация текста в дату,используя функцию **to_date**, означает взять текст и объяснить в своем формате, где и как содержится информация об элемнентах даты в вашем тексте.
у функции **to_date** также ,как и у **to_char**, есть modifier **fx**- он явно заставляет соответствовать формату даты, к которому надо привести


```
select to_date ('18:40 2019!17-Sep','HH24:mi yyyy!dd-Mon') from dual;
select to_char (to_date ('28-Sep-22 18:19:20','dd-Mon-RR hh24:mi:ss'),'dd-Mon-RR hh24:mi:ss') as convert from dual;

//пример с применением модификатора fx
select to_date('18-SEP-10','fxDD-Mon-YY') from dual;
select to_date('18-SEP-10','fxDD-Mon-YYYY') from dual; - данный select не сработает,так как формат отличается от текста
select to_char(to_date('09/12?22-21$01/11','hh24/mm?yy-dd$mi/ss'),'dd-mon-yy hh24:mi:ss')from dual; //все равно,какие разделители,главное,соблюдать соответствие их по порядку. 
```

### To_number
**TO_NUMBER(text,format mask,nls_parameters) - N**
Конвертация текста в число, используя функцию **TO_NUMBER**,означет взять текст и объяснить в своем формате, где и как содержится информация об элементаъ числа в вашем тексте.
```
select to_number('#234214.34','#999999999999.99')from dual;
select to_number('<4216>','9999999.99PR') from dual;
```
Есть один момент: в отличие от функции **TO_CHAR**,функция **TO_NUMBER** не может округлить текст и выдать результат в нужном формате.
Пример:
```
select to_char('3.17','9999.9') from dual;
select to_number('3.17','99999.9')from dual; //выкинет ошибку, количество знаков после плавающей точки меньше, чем в тексте 
select to_number('3.17','99999.99')from dual; //сработает корректно
```
### Nested functions (вложенные функции)
select length(SYSDATE)FROM DUAL;
```
select length(SYSDATE)FROM DUAL; //вложенность равна 2
select length(upper(sysdate))from dual; //вложенность равна 3
select first_name,length(first_name),round(123.1233456578689579,length(first_name))from employees;

select first_name,employee_id,length(employee_id),
substr(first_name,length(employee_id)),
length(substr(first_name,length(employee_id)))
from employees;

select to_date('28-04-21','dd-mm-rr'),
to_char(to_date('28-04-21','dd-mm-rr'),'day'),
length(to_char(to_date('28-04-21','dd-mm-rr'),'day'))
from dual;

select first_name,last_name,phone_number,to_number(substr(phone_number,instr(phone_number,'.')+1),'999.9999')*10000 some_alias from employees where employee_id<145;
```
### General functions (функции, упрощающие работу со значениями null)

**NVL**(value,ifNull) - функция,проверяющая значение на null. Если его первое значение не Null, то возвращается первое значение, если null,то возвращается второе значение.
Типы обоих значений должны быть одинаковыми!!
```
select first_name, NVL(commission_pct,0)from employees;

select first_name,NVL(SUBSTR(first_name,6),'name is too short') from employees; // если в имени больше 6 символов, то вернется текст, иначе вернется null и в итоге функция NVL вернет второе значение - 'name is too short'

select first_name,commission_pct,NVL(salary*commission_pct,400) bonus from employees;
```
**NVL2**(value,ifNotNull,ifNull)- всегда определяется по первому параметру(но никога его не возвращает):\
- если первый параметр не null,то возвращается второй параметр
- если первый парметр null, то возвращается третий параметр

```
select NVL2(17,19,18) from dual;
select NVL2(null,19,18) from dual; 
select first_name,commission_pct, NVL2(commission_pct,commission_pct,0)from employees;
```

**NULLIF**(value1,value2) - 
- возвращает null, если первый и второй параметр равны между собой
- возвращает первый параметр, если параметр не равен второму параметру
- второй параметр никогда не возвращает

```
select NULLIF(18,18)from dual;
select NULLIF(17,18)from dual;
select NULLIF(14,1||4) from dual; // выкинет ошибку - разные типы
select NULLIF ('15',15)from dual; // выкинет ошибку - разные типы
select nullif ('18-SEP-19','18?SEP/19') from dual;
select nullif (to_date('18-SEP-19'),to_date('18?SEP/19'))from dual;
```
**COALESCE**(value1,value2,valueN)- возвращает первое значение, не равное null
coalesce c 2 параметрами идентичен функции **NVL(value1,ifNull)**
```
select coalesce(null,12,null)from dual;
select coalesce(null,null,'ok',null)from dual;
select coalesce(null,null,null,null)from dual;
```

### Conditional functions
