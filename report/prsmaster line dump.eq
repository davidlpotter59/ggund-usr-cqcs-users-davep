include "startend.inc"
--where prsmaster:line_of_business <> sfsline:line_of_business 
--where sfsline:stmt_lob = 0
include "prscollect.inc"
--and prsmaster:agent_no one of 100
--and val(lob_subline) = 2 
--and prsmaster:line_of_business one of 2
--and sfsline:lob_subline <> prsmaster:lob_subline 
and prsmaster:trans_code < 17
and prsmaster:line_of_business one of 7

list
/nobanner
/domain="prsmaster"
/duplicates  

prsmaster:policy_no 
prsmaster:line_of_business
prsmaster:lob_subline 
sfsline:description 
sfsstmt:description 
prsmaster:agent_no 
prsmaster:comm_rate 
prsmaster:premium 

sorted by sfsline:description /total/newlines 
          prsmaster:line_of_business /newlines/total 
          prsmaster:lob_subline
