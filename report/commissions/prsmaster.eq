include "startend.inc"
define signed ascii number l_comm  = round((prsmaster:premium)*prsmaster:comm_rate * 0.001,2)
include "prscollect.inc"
and trans_code < 17
and comm_rate <> 0

list
/nobanner
/domain="prsmaster"
/nodetail 

prsmaster:policy_no 
prsmaster:comm_rate 
prsmaster:premium 
l_comm

sorted by prsmaster:policy_no 

end of policy_no 
box/noblanklines/noheadings 

policy_no 
total[prsmaster:premium]
xob
