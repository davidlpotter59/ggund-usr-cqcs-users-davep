include "startend.inc"

include "prscollect.inc"
and prsmaster:lob_subline = "69" 
and prsmaster:trans_code one of 10, 14

list
/nobanner
/domain="prsmaster"
/wks

prsmaster:policy_no 
prsmaster:line_of_business
sfsline_heading:description  
prsmaster:lob_subline 
prsmaster:trans_date
prsmaster:trans_eff
prsmaster:trans_code 
prsmaster:limit
prsmaster:premium 

sorted by prsmaster:line_of_business 
          month(prsmaster:trans_date)
          month(prsmaster:trans_eff)
          prsmaster:limit 
          prsmaster:policy_no 
