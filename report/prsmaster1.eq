
where prsmaster:policy_no one of 
    21674,
700000007,
900000098,
900000099,
900000150
 and prsmaster:trans_code < 17 
--and prsmaster:trans_eff < 01.01.2008

list
/nobanner
/domain="prsmaster"

prsmaster:policy_no 
prsmaster:trans_date 
prsmaster:trans_code 
prsmaster:trans_eff 
prsmaster:trans_exp
prsmaster:premium 

sorted by prsmaster:policy_no/total/newlines
