include "startend.inc"

include "prscollect.inc"
and with prsmaster:trans_code < 17
and sfsline:stmt_lob not one of 999
and prsmaster:agent_no = 761

list
/nobanner
/domain="prsmaster"

prsmaster:policy_no 
prsmaster:trans_date 
prsmaster:trans_code 
prsmaster:trans_eff 
prsmaster:trans_exp
prsmaster:premium/mask="(ZZZ,ZZZ,ZZZ.99)"

sorted by prsmaster:agent_no/newlines/total/heading="@" 
          prsmaster:policy_no
