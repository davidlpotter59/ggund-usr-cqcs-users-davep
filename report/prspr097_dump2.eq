
include "startend.inc"

include "prscollect.inc"
and prsmaster:trans_code < 18
--and sfsline2:exclude_from_contingent = 1

list
/nobanner
/domain="prsmaster"

prsmaster:policy_no company_id 
prsmaster:agent_no 
sfsagent:agent_master_code 
prsmaster:trans_code 
prscode:description 
prsmaster:line_of_business 
prsmaster:lob_subline 
sfsline:description 
prsmaster:premium /total/mask="(ZZZ,ZZZ,ZZZ.99)"

sorted by sfsagent:agent_master_code /total/newlines 

include "reporttop.inc"
