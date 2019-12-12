include "startend.inc"

define wdate l_as_of_trans_date = parameter/prompt="Enter last Trans Date to use"

define file sfslinea = access sfsline, set sfsline:company_id= prsmaster:company_id, 
                                           sfsline:line_OF_BUSINESS= prsmaster:line_of_business,
                                           sfsline:lob_subline= prsmaster:lob_subline 

include "prscollect.inc"
 
and prsmaster:trans_date < 09.01.2014 
and prsmaster:trans_code < 17
and prsmaster:agent_no one of 262, 276
--and year(prsmaster:eff_date) one of 2014 --,2012,2013,2014
--and prsmaster:trans_code one of 11 

list
/nobanner
/domain="prsmaster"
--/nodetail 

prsmaster:policy_no 
prsmaster:trans_date 
prsmaster:trans_eff
prsmaster:trans_exp
prsmaster:trans_code 
prsmaster:bill_plan 
prsmaster:comm_rate 
prsmaster:line_of_business 
prsmaster:lob_subline 
sfsline:description [1,20]
prsmaster:premium 

sorted by year(trans_date)
          month(trans_date)/total/heading="@"
          prsmaster:agent_no prsmaster:policy_no

/*
end of prsmaster:agent_no 
box/noblanklines/noheadings 
prsmaster:agent_no /column=1
total[prsmaster:premium]/column=15/mask="ZZZ,ZZZ,ZZZ.99-"
xob
*/
