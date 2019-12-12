include "startend.inc"

include "prscollect.inc"
and with prsmaster:trans_code < 17

list
/nobanner
/domain="prsmaster"

prsmaster:policy_no 
prsmaster:agent_no 
prsmaster:comm_rate 
prsmaster:premium
prsmaster:premium * (prsmaster:comm_rate * 0.01)

sorted by prsmaster:policy_no
