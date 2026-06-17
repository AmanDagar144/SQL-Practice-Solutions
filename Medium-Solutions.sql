-- Q.1 Show unique birth years from patients and order them by ascending.

SELECT distinct year(birth_date) as birth_year FROM patients
order by birth_year asc;

-- Q.2 Show unique first names from the patients table which only occurs once in the list.-- For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list. If only 1 person is named 'Leo' then include them in the output.

SELECT first_name FROM patients
group by first_name
having count(*) = 1

-- Q.3 Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long. 

SELECT patient_id,first_name FROM patients
where first_name like 's____%s'

-- Q.4 Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'. Primary diagnosis is stored in the admissions table.

SELECT patients.patient_id,first_name,last_name FROM patients
join admissions on admissions.patient_id = patients.patient_id 
where admissions.diagnosis = 'Dementia'

-- Q.5 Display every patient's first_name. Order the list by the length of each name and then by alphabetically.

select first_name from patients
order by len(first_name),first_name

-- Q.6 Show the total amount of male patients and the total amount of female patients in the patients table. Display the two results in the same row.

select sum(gender = 'M') as male_count,sum(gender = 'F') as female_count
from patients

-- Q.7 Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. Show results ordered ascending by allergies then by first_name then by last_name.

select first_name,last_name,allergies from patients
where allergies = 'Penicillin'
or allergies = 'Morphine'
order by allergies , first_name,last_name;

-- Q.8 Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.

SELECT patient_id, diagnosis
FROM admissions
GROUP BY patient_id, diagnosis
HAVING COUNT(*) > 1;

-- Q.9 Show the city and the total number of patients in the city. Order from most to least patients and then by city name ascending.

select city,count(*) as num_patients from patients
group by city
order by num_patients desc,city asc

-- Q.10 Show first name, last name and role of every person that is either patient or doctor. The roles are either "Patient" or "Doctor"

select first_name,last_name,'Patient' as role from patients
union all
select first_name,last_name,'Doctor' as role from doctors

-- Q.11 Show all allergies ordered by popularity. Remove NULL values from query.

select allergies,count(*) as total_diagnosis from patients
where allergies is not null
group by allergies
order by total_diagnosis desc

-- Q.12 Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.

select first_name,last_name,birth_date from patients
where year(birth_date) between 1970 and 1979
order by birth_date

-- Q.13 We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the first_name in decending order EX: SMITH,jane

select concat(upper(last_name),',',lower(first_name)) as new_name_format
from patients
order by first_name desc

-- Q.14 Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.

select province_id,sum(height) as sum_height from patients
group by province_id
having sum_height >= 7000

-- Q.15 Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'

select max(weight) - min(weight) as weight_delta from patients
where last_name = 'Maroni'

-- Q.16 Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.

select day(admission_date) as day_number,count(*) as number_of_admissions
from admissions
group by day_number
order by number_of_admissions desc

-- Q.17 Show all columns for patient_id 542's most recent admission_date.

select * from admissions
where patient_id = 542
and admission_date = (
  select max(admission_date) from admissions
  where patient_id = 542)

-- Q.18 Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria: 
-- 1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
-- 2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.

SELECT patient_id,attending_doctor_id,diagnosis
FROM admissions
WHERE (patient_id % 2 = 1
        AND attending_doctor_id IN (1,5,19))
   OR (attending_doctor_id LIKE '%2%'
        AND LENGTH(patient_id) = 3);
