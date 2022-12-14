## Group functions (multiply row functions) - агрегирующие функции
могут быть вложены максимум 2 раза, так как вторая вложенность приводит уже к одной результирующей цифре 
```
select department_id,Min(sum(avg(salary))) //exception "group function is nested too deeply"
from employees 
group by department_id; 
 
select sum(avg(salary)) 
from employees 
group by department_id;
```

- **COUNT**
- **SUM**
- **AVG**
- **MAX**
- **MIN**

### **COUNT** - считает количеситво всех строк
**не считает(пропускает) null !!!**
часто в связке используется **DISTINCT**
``` 
select COUNT(*) from employees;
select COUNT(*) from employees where salary>5000;
select COUNT(commission_pct) from employees //null не посчитался
select COUNT(NVL(commission_pct,0)) from employees;
select COUNT(DISTINCT(commission_pct)) from employees;
select COUNT(DISTINCT(first_name)),first_name from employees;
select COUNT(DISTINCT(first_name)),COUNT(first_name) from employees;
```
мы не можем писать в Select какие то столбцы радом с group functions
```
select count(commission_pct),first_name from employees; // не сработает
```
### **SUM** - принимает в параметры только число
Любые арифметический действия с null пиводят к null, пожтому **sum** игнорирует null;
```
select 5+null from dual; //будет null
```
```
Примеры
select sum(salary) from employees;
select sum(distinct(commission_pct)) from employees;
select sum(sysdate-hire_date) from employees;
select round(sum(sysdate-hire_date)) from employees;
```

### **AVG** - среднее арифметическое 
Любые арифметический действия с null пиводят к null, пожтому **avg** игнорирует null; 
**ТИП ДАННЫХ - СТРОГО Number**
 ```
 select round(AVG(salary)) from employees;
 select sum(salary)/count(salary) from employees;
 select AVG(salary) from employees where job_id = 'IT_PROG';
 select AVG(DISTINCT(salary)) from employees;
 select COUNT(*) a,SUM(salary) b,AVG(commission_pct) c from employees;
 select avg(sysdate-hire_date)/365 from employees;

 ```

 ### **MIN и MAX** - работают и с числами, и с датами, и с текстом
 ```
select MIN(salary),MAX(salary) from employees where department_id = 50;
select MIN(hire_date),MAX(hire_date) from employees;
select MIN(first_name),MAX(first_name) from employees;
select COUNT(salary),sum(salary),avg(salary),min(salary),max(salary) from employees;
select MAX(length(first_name)),MIN(length(first_name)) from employees;
 ```

 ## GROUP BY statement
 по алиасу нельзя группировать, можно сортировать
 ```
 select job_id, sum(salary) from employees group by job_id;
 // информация сумм по всем работникам сгруппирована по полю job_id, поэтому в select-листе можно вывести колонку вместе с агрегирующей функцией sum

select job_id,round(avg(salary)) avg,min(salary) myMIn,max(salary)
from employees
where length(first_name)>4 and salary>5000
group by job_id
order by myMIn;

select max(hire_date),min(first_name),count(*),round(avg(salary))avg,sum(employee_id)
from employees group by department_id;

select to_char(hire_date,'Month'), count(*) from employees group by to_char(hire_date,'Month');

select job_id,TO_CHAR(hire_date,'yyyy')year,sum(salary)
from employees
where job_id in('ST_CLERK','SA_REP','SH_CLERK') and employee_id>115
group by job_id,TO_CHAR(hire_date,'yyyy')
order by job_id,year ;
```

### Having - используется при наличии **GroupBy** для задания условия.Аналогичен **where**
оператор **where** не сработает при задании условия для групповой функции.Для этого нужно использовать **having**
Примечание (**Having** может работать без **Group by**,но он будет работать с одним множеством и просто не нужен)\
**where** отсеивает строки, а **having**- группы

```
select department_id,count(*),round(avg(salary))from employees
where length(first_name)>4
group by department_id
having count(*)>3 and round(avg(salary))>5000
order by department_id ;
//выбери айди департамента,всех рабочих,округленную среднюю зарплату где длина имени рабочегоу  больше 4 знаков,
  сгруппируй по айди департамента, 
  выбери те группы, где рабочих больше 3 , 
  отсортируй по айди департамента 

select ROUND(SUM(AVG(LENGTH(UPPER(last_name))))) from employees
group by department_id;  
```



