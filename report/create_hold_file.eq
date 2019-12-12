include "startend.inc"

include "prscollect.inc"
and with sfsline:stmt_lob one of 17
and prsmaster:trans_code < 17


list
/nobanner
/domain="prsmaster"
/nodetail 
/hold="policycount"

sorted by prsmaster:policy_no trans_code 

end of prsmaster:trans_code 
   prsmaster:policy_no 
   sfpname:name[1]
   prsmaster:trans_code 
   total[prsmaster:premium]
