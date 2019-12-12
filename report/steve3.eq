 
include "startend.inc"

include "prscollect.inc"
and with prsmaster:trans_code < 17
and prsmaster:agent_no = 173

list
/nobanner
/domain="prsmaster"
/title="Premiums by Agent Code"
--/nodetail 

prsmaster:agent_no 
prsmaster:premium/column=20
prsmaster:trans_EFF  

sorted by prsmaster:agent_no PRSMASTER:TRANS_EFF 

end of prsmaster:agent_no
box/noheadings/noblanklines 
   prsmaster:agent_no 
   total[prsmaster:premium]/column=20/mask="(ZZZ,ZZZ,ZZZ.99)"
xob

top of page

l_starting_date/heading="Starting Date "/column=1/mask="MM/DD/YYYY"/newline 
l_ending_date/heading="Ending Date"/column=1/mask="MM/DD/YYYY"/newline=2
