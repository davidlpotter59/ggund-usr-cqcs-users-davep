include "startend.inc"
define signed ascii number l_comm  = round((arsmaster:premium)*arsmaster:comm_rate * 0.001,2)
include "arscollect.inc"
and trans_code < 17
and comm_rate <> 0

list
/nobanner
/domain="arsmaster"
/nodetail 

arsmaster:policy_no 
arsmaster:comm_rate 
arsmaster:premium 
l_comm

sorted by arsmaster:policy_no 

end of policy_no 
box/noblanklines/noheadings 

policy_no 
total[arsmaster:premium]
xob
