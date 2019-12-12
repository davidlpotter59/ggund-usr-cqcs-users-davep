include "startend.inc"

include "prscollect.inc"
and with prsmaster:trans_code < 17
and sfsline:stmt_lob one of 171 --193, 194

list
/nobanner
/domain="prsmaster"

prsmaster:policy_no 
prsmaster:trans_date 
prsmaster:trans_code
prsmaster:line_of_business 
prsmaster:lob_subline 
sfsline:description 
prsmaster:premium 

sorted by prsmaster:line_of_business 
          prsmaster:lob_subline /total/newlines 
          prsmaster:policy_no
