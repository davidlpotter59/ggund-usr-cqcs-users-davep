include "startend.inc"

include "prscollect.inc"
and with prsmaster:trans_code < 17
and with prsmaster:line_of_business = 09

list
/nobanner
/domain="prsmaster"
/nodetail 

prsmaster:policy_no /name="Policy_number"
--prsmaster:eff_date /name="Effective_Date"
sfpname:name[1]/name="Name"
prsmaster:premium /name="Premium"

sorted by prsmaster:policy_no --prsmaster:eff_date 

end of prsmaster:policy_no 
box/noblanklines/noheadings 

 prsmaster:policy_no/align=policy_number 
--   prsmaster:eff_date/align=effective_date
  sfpname:name[1]/align=name  
   total[prsmaster:premium]/align=premium/mask="(ZZZ,ZZZ,ZZZ.99)"
xob
/*
end of prsmaster:eff_date 
box/noblanklines/noheadings 
   prsmaster:policy_no/align=policy_number 
   prsmaster:eff_date/align=effective_date 
   total[prsmaster:premium]/align=premium/mask="(ZZZ,ZZZ,ZZZ.99)"
xob

*/
