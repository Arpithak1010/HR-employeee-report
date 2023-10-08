create database projects1; 
use projects1;
select * from hr;

ALTER table hr
change column ï»¿id emp_id varchar(20)
describe hr;
set sql_safe_updates=0;
update hr
set birthdate= case
when birthdate  like '%/%' then  date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
when birthdate  like '%-%' then  date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
else null
end;


alter table hr 
modify birthdate date;
update hr
set hire_date= case
when hire_date  like '%/%' then  date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
when hire_date  like '%-%' then  date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
else null
end;
alter table hr 
modify hire_date date;
update hr
set termdate = date(str_to_date(termdate,  '%Y-%m-%d %H:%i:%s UTC'   ))
where termdate is not null and termdate!='';
 
 update hr
 set termdate = null
 where termdate ='';
 select * from hr;

alter table hr
add column age int;
update hr
set age = timestampdiff(YEAR,birthdate,curdate())
select max(age),min(age) from hr;
select gender, count(*)  from hr
where termdate is null
group by gender
select race, count(*)  from hr
where termdate is null
group by race

select 
case 
when age>=18 and age<=24 then '18-24'
when age>=25 and age<=34 then '25-34'
when age>=35 and age<=44 then '35-44'
when age>=45 and age<=54 then '45-54'
when age>=55 and age<=64 then '55-64'
else '64+'
end age_grp ,
count(*) as no from hr
 where termdate is null
 group by age_grp
 order by count(*);

select*from hr;
select location,count(*) from hr
where termdate is null 
group by location

select round(avg(year(termdate)-year(hire_date)),0)as tenure from hr
where termdate is not null and termdate<=curdate()
SELECT department,jobtitle,gender,count(*)from hr
where termdate is null
group by  department,jobtitle,gender;
select*from hr


select location_city,count(*) from hr
where termdate is null
group by location_city

select year,hires,terminations,hires-terminations as net_change,(terminations/hires)*100 as change_rate
from 
(select year(hire_date)as year,count(*) as hires,
sum(case when termdate is not null and termdate<=curdate() then 1 end) as terminations from hr group by year(hire_date)) as subquery
group by year
order by year ;





