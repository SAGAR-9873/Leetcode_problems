SELECT actor_id , director_id
FROM (
SELECT actor_id , director_id, count(timestamp) AS C 
FROM ActorDirector
group by actor_id,director_id) AS T 
WHERE C >= 3;
