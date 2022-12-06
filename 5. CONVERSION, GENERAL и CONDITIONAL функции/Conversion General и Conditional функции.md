## Conversion,General и Conditonal функции

### Conversion functions

- **TO_CHAR(number to char)** *(number,format mask,nls_parameters)* - конвертирует число или дату в текст.\
	**nls_parameters**(national language parameters) - настройки парметров языка,могут различаться форматы дат и прочее..\
	```
	Примеры различных форматов текстов
	select TO_CHAR (18,'99999') from dual; //максимальный размер текста - 5 символов в данном примере
	select TO_CHAR (18,'09999') from dual; // заполнение нулями в начале числа
	select TO_CHAR (18.35,'09999.999') from dual; //формат десятичного числа
	select TO_CHAR (18.35,'09999D999') from dual; // альтернативная запись,результат аналогичен предыдущему



	```