include "startend.inc"

define file sfslinea = access sfsline, set sfsline:company_id= prsmaster:company_id, 
                                           sfsline:line_OF_BUSINESS= prsmaster:line_of_business,
                                           sfsline:lob_subline= prsmaster:lob_subline 

include "prscollect.inc"
and with prsmaster:trans_code < 17
and SFSAGENT:AGENT_MASTER_CODE  one of 111
--and prsmaster:lob_subline one of "40"

list
/nobanner
/domain="prsmaster"
--/nodetail 

prsmaster:policy_no 
prsmaster:trans_date 
prsmaster:trans_eff
prsmaster:trans_exp
prsmaster:bill_plan 
prsmaster:comm_rate 
prsmaster:line_of_business 
prsmaster:lob_subline 
sfsline:description [1,20]
prsmaster:premium 

sorted by prsmaster:agent_no prsmaster:policy_no

end of prsmaster:agent_no 
box/noblanklines/noheadings 
prsmaster:agent_no /column=1
total[prsmaster:premium]/column=15/mask="ZZZ,ZZZ,ZZZ.99-"
xob

TOP OF PAGE 
SFSAGENT:NAME[1]/NEWLINE
