

define wdate l_starting_date = parameter 
define wdate l_ending_date = parameter 

include "prscollect.inc"
and with prsmaster:trans_code < 17
and dateadd(prsmaster:trans_exp,0,-1) => 05.01.2010 
and dateadd(prsmaster:trans_exp,0,-1) <= 04.30.2011
--and year(prsmaster:eff_date) = 2009
--and sfsline:line_of_business one of 9


list
/nobanner
/domain="prsmaster"
/nodetail 

prsmaster:policy_no 
prsmaster:trans_eff 
prsmaster:trans_exp 
dateadd(prsmaster:trans_exp,0,-1)/mask="MM/DD/YYYY"/heading="Eff-Date"
prsmaster:line_of_business 
prsmaster:lob_subline 
sfsline:description 
prsmaster:trans_code 
prsmaster:premium/total/mask="(ZZZ,ZZZ,ZZZ.99)"

sorted by prsmaster:policy_no
