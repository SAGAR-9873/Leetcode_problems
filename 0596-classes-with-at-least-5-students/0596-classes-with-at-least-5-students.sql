select class 
from(select class, count(student) as c 
from Courses
group by class) as t
where c >= 5;
