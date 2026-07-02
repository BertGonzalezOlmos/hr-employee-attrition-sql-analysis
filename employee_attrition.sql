create database hr_employee_analytics;

#1. Departamento con mayor rotación
select
   department,
   count(*) as total_employees,
   sum(case when attrition = "Yes" then 1 else 0 end) as employees_left,
   round(sum(case when attrition = "Yes" then 1 else 0 end) / count(*) * 100, 2) as attrition_rate_pct
from employee_attrition
group by department 
order by attrition_rate_pct desc;

#2. Rotación según horas extra
select
   overtime,
   count(*) as total_employees,
   sum(case when attrition = "Yes" then 1 else 0 end) as employees_left,
   round(sum(case when attrition = "Yes" then 1 else 0 end) / count(*) * 100,2 ) as attrition_rate_pct
from employee_attrition
group by overtime
order by attrition_rate_pct desc;

#3. Cargos con salario promedio mas alto
select
    job_role,
    count(*) as total_employees,
    round(avg(monthly_income),2) as avg_monthly_income
from employee_attrition
group by job_role
order by avg_monthly_income desc;

#4. Rotación según satisfacción laboral
select
    job_satisfaction,
    count(*) as total_employees,
    sum(case when attrition = "Yes" then 1 else 0 end) as employees_left,
    round(sum(case when attrition = "Yes" then 1 else 0 end) / count(*) * 100,2 ) as atrittion_rate_pct
from employee_attrition
group by job_satisfaction
order by job_satisfaction;

#5. Antiguedad promedio según rotación
select
   attrition,
   count(*) as total_employees,
   round(avg(years_at_company),2) as avg_years_at_company,
   round(avg(total_working_years),2) as avg_total_working_years
from employee_attrition
group by attrition;

#6. Ingreso promedio por nivel de puesto
select
   job_level,
   count(*) as total_employees,
   round(avg(monthly_income),2) as avg_monthly_income
from employee_attrition
group by job_level
order by job_level;

#7. Diferencia salarial entre departamentos
select
    department,
    count(*) as total_employees,
    round(avg(monthly_income), 2) as avg_monthly_income,
    min(monthly_income) as min_income,
    max(monthly_income) as max_income
from employee_attrition
group by department
order by avg_monthly_income desc;

#8. Caracteristicas promedio de empleados que renuncian vs permanecen
select
    attrition,
    count(*) as total_employees,
    round(avg(age), 2) as avg_age,
    round(avg(monthly_income),2) as avg_income,
    round(avg(distance_from_home),2) as avg_distance_from_home,
    round(avg(years_at_company),2) as avg_years_at_company,
    round(avg(job_satisfaction),2) as avg_job_satisfaction,
    round(avg(work_life_balance),2) as avg_work_life_balance
from employee_attrition
group by attrition;

#9. Rotación por cargo
select  
   job_role,
   count(*) as total_employees,
   sum(case when attrition = "Yes" then 1 else 0 end) as employees_left,
   round(sum(case when attrition = " Yes" then 1 else 0 end) / count(*) * 100,2 ) as attrition_rate_pct
   from employee_attrition
   group by job_role
   order by attrition_rate_pct desc;
   
# 10. Rotación por rango de edad
select
    case
        when age < 25 then 'menor de 25'
        when age between 25 and 34 then '25-34'
        when age between 35 and 44 then '35-44'
        when age between 45 and 54 then '45-54'
        else '55 o más'
    end as age_group,
    count(*) as total_employees,
    sum(case when attrition = 'Yes' then 1 else 0 end) as employees_left,
    round(sum(case when attrition = 'Yes' then 1 else 0 end) / count(*) * 100, 2) as attrition_rate_pct
from employee_attrition
group by age_group
order by attrition_rate_pct desc;

#11. Rotación por distancia al trabajo
select
    case
        when distance_from_home <= 5 then '0-5 km'
        when distance_from_home <= 10 then '6-10 km'
        when distance_from_home <= 20 then '11-20 km'
        else 'más de 20 km'
    end as distance_group,
    count(*) as total_employees,
    sum(case when attrition = 'Yes' then 1 else 0 end) as employees_left,
    round(sum(case when attrition = 'Yes' then 1 else 0 end) / count(*) * 100, 2) as attrition_rate_pct
from employee_attrition
group by distance_group
order by attrition_rate_pct desc;

#12. Rotación según work life balance
select
    work_life_balance,
    count(*) as total_employees,
    sum(case when attrition = 'Yes' then 1 else 0 end) as employees_left,
    round(sum(case when attrition = 'Yes' then 1 else 0 end) / count(*) * 100, 2) as attrition_rate_pct
from employee_attrition
group by work_life_balance
order by work_life_balance;

#13. Empleados con mayor riesgo de renuncia según variables clave
select
    employee_number,
    age,
    department,
    job_role,
    monthly_income,
    overtime,
    job_satisfaction,
    work_life_balance,
    years_at_company,
    distance_from_home,
    attrition,
    case
        when overtime = 'Yes'
             and job_satisfaction <= 2
             and work_life_balance <= 2 then 'riesgo alto'
        when overtime = 'Yes'
             or job_satisfaction <= 2 then 'riesgo medio'
        else 'riesgo bajo'
    end as attrition_risk_level
from employee_attrition
order by attrition_risk_level, monthly_income;


#14. Salario promedio de empleados que renuncian vs permanecen por departamento
select
    department,
    attrition,
    count(*) as total_employees,
    round(avg(monthly_income), 2) as avg_monthly_income
from employee_attrition
group by department, attrition
order by department, attrition;

#15. Ranking de cargos con mayor rotación y menor salario promedio

select
    job_role,
    count(*) as total_employees,
    sum(case when attrition = 'Yes' then 1 else 0 end) as employees_left,
    round(sum(case when attrition = 'Yes' then 1 else 0 end) / count(*) * 100, 2) as attrition_rate_pct,
    round(avg(monthly_income), 2) as avg_monthly_income
from employee_attrition
group by job_role
having count(*) >= 10
order by attrition_rate_pct desc, avg_monthly_income asc;