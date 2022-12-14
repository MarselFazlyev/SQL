## Group functions (multiply row functions) - агрегирующие функции

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
Любые арифметический действия с null пиводят к null, пожтому **sum** не суммирует null;
```
select 5+null from dual; //будет null
```
```
Примеры
select sum(salary) from employees;
```
