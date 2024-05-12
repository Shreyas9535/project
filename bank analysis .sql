create database db;
use db;

#KPI-1-Year wise loan amount Stats

select right(issue_d,4) as year,
concat(cast(sum(loan_amnt)/100000 as decimal (10,2)),'millions') as totalloanamt
from db2
group by 1
order by 1;


#KPI-2-Grade and sub grade wise revol_bal

select grade,sub_grade,
sum(loan_amnt) as totoalrevol
from db2
group by grade,sub_grade
limit 0,1000;



#KPI-3-Total Payment for Verified Status Vs Total Payment for Non Verified Status

select verification_status,
SUM(case when verification_status = 'Verified' THEN loan_amnt ELSE 0 END) AS total_payment_verified,
SUM(CASE WHEN verification_status != 'Verified' THEN loan_amnt ELSE 0 END) AS total_payment_non_verified
from db2
group by verification_status;


#KPI-4-State wise and last_credit_pull_d wise loan status

SELECT addr_state, loan_status, count(*) AS count
FROM db2
GROUP BY addr_state ,loan_status
ORDER BY addr_state;

#KPI-5-Home ownership Vs last payment date stats

select home_ownership,last_pymnt_d,last_pymnt_amnt from db2 db
inner join finance_2 f2 on db.id=f2.id
group by home_ownership,last_pymnt_d,last_pymnt_amnt
order by home_ownership,last_pymnt_d;
