SELECT  P.firstName, P.lastName, A.city,A.state
FROM  Person AS p
LEFT JOIN ADDRESS AS A on 
P.personId = A.personId;