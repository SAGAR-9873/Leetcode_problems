select s1.sample_id , s1.dna_sequence , s1.species,
 case 
    when s1.dna_sequence like "ATG%" then 1
    else 0 end as has_start, 
case 
    when s1.dna_sequence like "%TAA" 
    or s1.dna_sequence like "%TAG" 
    or s1.dna_sequence like "%TGA" then 1
    else 0 end as has_stop,
case 
    when s1.dna_sequence like "%ATAT%" then 1 
    else 0 end as has_atat,
case 
    when s1.dna_sequence like "%GGG%" then 1 
    else 0 end as has_ggg
from Samples s1 left join Samples s2 
on s1.sample_id = s2.sample_id
