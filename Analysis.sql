create database if not exists bank_loans ;
use bank_loans ;

select count(id) total_loan_applications
from loans_data ;

select * from loans_data ;

select count(id) MTD_total_loan_applications
from loans_data
where month(issue_date) = (12) ;

select count(id) total_loan_applications
from loans_data
where month(issue_date) = 11 ;

select sum(loan_amount) total_amount_funded
from loans_data 
where month(issue_date) = 12 ;

select sum(loan_amount) total_amount_funded
from loans_data 
where month(issue_date) = 11 ;

select sum(total_payment) total_amount_received
from loans_data 
where month(issue_date) = 12 ;

select sum(total_payment) total_amount_received
from loans_data 
where month(issue_date) = 12 ;

select round(avg(int_rate)*100,2) PM_average_interest_rate
from loans_data 
where month(issue_date) = 12;

select round(avg(int_rate)*100,2) MTD_average_interest_rate
from loans_data 
where month(issue_date) = 11;

select round(avg(dti)*100,2) as PM_average_DTI
from loans_data 
where month(issue_date) = 12 ;

select round(avg(dti)*100,2) as MTD_average_DTI
from loans_data 
where month(issue_date) = 11 ;

-- Good Loan KPIs:

select distinct loan_status from loans_data ;
# GOOD LOAN PERCENT %
select round(count(id) / (select count(id) from loans_data)*100,2) as Good_loan_application_percent 
from loans_data 
where loan_status != "Charged Off" 
;
# GOOD LOAN COUNT
select count(id) as Good_loan_application_count 
from loans_data 
where loan_status != "Charged Off" 
;

select * from loans_data ;

# 3.Good Loan Funded Amount
select sum(loan_amount) as funded_amount
from loans_data
where loan_status != "Charged Off"
;

# 4.Good Loan Total Received Amount
select sum(total_payment) as Total_Received_amount
from loans_data
where loan_status != "Charged Off"
;

-- BAD Loan KPIs:
#  BAD LOAN PERCENT %
select round(count(id) / (select count(id) from loans_data)*100,2) as Good_loan_application_percent 
from loans_data 
where loan_status = "Charged Off" 
;
# BAD LOAN COUNT
select count(id) as Good_loan_application_count 
from loans_data 
where loan_status = "Charged Off" 
;
# 3.BAD Loan Funded Amount
select sum(loan_amount) as funded_amount
from loans_data
where loan_status = "Charged Off"
;

# 4.BAD Loan Total Received Amount
select 
	sum(total_payment) as Total_Received_amount
from loans_data
where loan_status = "Charged Off"
;

select * from loans_data ;
# LOAN STATUS GRID VIEW
select loan_status,
	count(id) as Application_Count,
    sum(loan_amount) as Total_funded_amount,
    sum(Total_payment) as Total_funded_Received,
    round(avg(int_rate)*100,2) as Average_interest_rate,
    round(avg(dti)*100,2) as Average_DTI
from loans_data 
group by loan_status
;

select loan_status,
    sum(Total_payment) as MTD_Total_funded_Received,
    sum(loan_amount) as MTD_Total_funded_amount
from loans_data 
where month(issue_date) = 12
group by loan_status
;

-- DASHBOARD 2 - Overview
select * from loans_data ;
# Monthly Trends by Issue Date
select 
	month(issue_date) as Month_Number,
	monthname(issue_date) as Month_Name ,
    count(id) total_application,
    sum(loan_amount) as 'Total Funded Amount',
    sum(total_payment) as 'Total Amount Received'
from loans_data
group by month(issue_date) , monthname(issue_date)
order by Month_Number
;
# Regional Analysis by State 
select 
	address_state,
    count(id) total_application,
    sum(loan_amount) as 'Total Funded Amount',
    sum(total_payment) as 'Total Amount Received'
from loans_data
group by address_state
;
# Loan Term Analysis
select 
	term,
    count(id) total_application,
    sum(loan_amount) as 'Total Funded Amount',
    sum(total_payment) as 'Total Amount Received'
from loans_data
group by term
order by term
;
# Employee Length Analysis 
select 
	emp_length,
    count(id) total_application,
    sum(loan_amount) as 'Total Funded Amount',
    sum(total_payment) as 'Total Amount Received'
from loans_data
group by emp_length
order by emp_length
;
# Loan Purspose Breakdown
select 
	purpose,
    count(id) total_application,
    sum(loan_amount) as 'Total Funded Amount',
    sum(total_payment) as 'Total Amount Received'
from loans_data
group by purpose
order by total_application desc
;
# Home Ownership Analysis
select 
	home_ownership,
    count(id) total_application,
    sum(loan_amount) as 'Total Funded Amount',
    sum(total_payment) as 'Total Amount Received'
from loans_data
group by home_ownership
order by total_application desc
;