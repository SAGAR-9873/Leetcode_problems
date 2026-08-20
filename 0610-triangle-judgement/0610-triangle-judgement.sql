SELECT x,y,z,
CASE 
    WHEN x+y > z and  
    y+z > x and 
     x+z > y then "Yes"
     else "No" 
     end as triangle  
FROM Triangle 