## Conversion,General и Conditonal функции

### Conversion functions

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


