INCLUDE "STARTEND.INC"

INCLUDE "PRSCOLLECT.INC"

--where prsmaster:misc not one of "CONVERT" --and prsmaster:trans_code < 17 

list
/nobanner
/domain="prsmaster"
/nodetail 

prsmaster:policy_no 
prsmaster:trans_date 
prsmaster:trans_code 
prsmaster:trans_eff 
prsmaster:trans_exp
prsmaster:premium /mask="ZZZ,ZZZ,ZZZ,ZZZ.99-"


--sorted by prsmaster:policy_no/total/newlines

end of report
total[prsmaster:premium]
count[prsmaster:policy_no]
