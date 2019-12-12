include "startend.inc"

include "prscollect.inc"
and prsmaster:trans_code < 17

list
/nobanner
/domain="prsmaster"
/nodetail 

prsmaster:agent_no 
prsmaster:premium/mask="(ZZZ,ZZZ,ZZZ.99)"

sorted by prsmaster:agent_no 

end of prsmaster:agent_no 
box/noblanklines/noheadings 
   prsmaster:agent_no 
   total[prsmaster:premium]
xob
