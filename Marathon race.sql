create database d1;

use d1;

select * from Ultracleanedupdata_output;

-- How many states were represented in the race.

select count(distinct(State)) as total_states from Ultracleanedupdata_output;

-- what was the average time of men vs women

select Gender, avg(Total_Minutes) as Total_average
from Ultracleanedupdata_output
group by Gender;

-- what are the youngest and oldest ages in the race
select Gender, MIN(Age) as youngest, max(Age) as oldest
from Ultracleanedupdata_output
group by Gender;

-- what was the average time for each age group

with age_buckets as(
select Total_Minutes,
	case when Age < 30 then 'age_20-29'
	     when Age < 40 then 'age_30-39'
         when Age < 50 then 'age_40-49'
         when Age < 60 then 'age_50-59'
	else 'age_60+' end as age_group
from Ultracleanedupdata_output)
select age_group, avg(Total_Minutes)
from age_buckets
group by age_group;

with cte as(select fullname, Total_Minutes, Gender,rank() over(partition by Gender order by Total_Minutes) as ranks
from Ultracleanedupdata_output)
select * from cte
where ranks <= 3;