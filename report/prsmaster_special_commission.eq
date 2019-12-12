include "startend.inc"

define file special_comma = access special_comm, set special_comm:policy_no= prsmaster:policy_no 

include "prscollect.inc"
and with prsmaster:trans_code < 17 and sfsline:lob_code not one of "BOILER"
and with prsmaster:comm_rate <> special_comma:spec_comm_rate 
and prsmaster:line_of_business <> 5
and prsmaster:lob_subline <> "50"

list
/nobanner
/domain="prsmaster"
--/nodefaults 
--/pagelength= 0
 

if special_comma:spec_comm_rate <> prsmaster:comm_rate then 
{
prsmaster:policy_no 
prsmaster:comm_rate 
prsmaster:line_OF_BUSINESS 
prsmaster:lob_subline 
prsmaster:trans_date 
prsmaster:trans_code 
prsmaster:trans_eff 
prsmaster:trans_exp 
--sfsline:description 
special_comma:spec_comm_rate 
}
