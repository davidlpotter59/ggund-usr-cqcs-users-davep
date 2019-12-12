where prsmaster:trans_code < 18
and year(prsmaster:trans_date) => 2017

sum
/nobanner 
/domain="prsmaster"

prsmaster:premium /mask="(ZZZ,ZZZ,ZZZ.99)"

across prscode:description 

by
year(prsmaster:trans_date )
month(prsmaster:trans_date)/noheading 
monthname(prsmaster:trans_date)/heading="Month"
