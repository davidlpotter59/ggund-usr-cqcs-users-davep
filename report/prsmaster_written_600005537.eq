define wdate l_starting_date = 12.01.2016
define wdate l_ending_date = 11.30.2019

include "prscollect.inc"
and with prsmaster:trans_code < 17
and prsmaster:policy_no one of 600005537

list
/nobanner
/domain="prsmaster"
/duplicates 
/nodetail 

prsmaster:policy_no 
prsmaster:trans_date 
prsmaster:trans_code
prsmaster:line_of_business 
prsmaster:lob_subline 
sfsline:description 
prsmaster:premium/mask="(ZZZ,ZZZ,ZZZ,ZZZ.99)"/total 

sorted by prsmaster:premium 

end of prsmaster:premium 
box/noblanklines/noheadings 
  prsmaster:policy_no 
  prsmaster:trans_date 
  prsmaster:trans_code
  prsmaster:line_of_business 
  prsmaster:lob_subline 
  sfsline:description 
  total[prsmaster:premium]/align=prsmaster:premium /mask="(ZZZ,ZZZ,ZZZ,ZZZ.99)"
end box

include "reporttop.inc"
