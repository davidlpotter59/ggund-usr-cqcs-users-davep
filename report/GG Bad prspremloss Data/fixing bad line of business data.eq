
description * Updated - Earned to Incurred Report by Agent and Line of Business - Select LAE or No LAE in Incurred Number ;

include "startend.inc"
define string l_prog_number = "PRSPR1069 - Version 7.22"

define signed ascii number l_prior_direct_unearned = prspremloss:unearned_premium_prior 
define signed ascii number l_current_premium       = prspremloss:written_premium 
define signed ascii number l_direct_unearned       = prspremloss:unearned_premium_current 

define signed ascii number l_direct_earned = 
(l_prior_direct_unearned + l_current_premium) - l_direct_unearned 

define signed ascii number l_incurred = prspremloss:loss_reserve_current + 
prspremloss:loss_paid_current - prspremloss:loss_reserve_prior 

define signed ascii number l_incurred_lae = 
(prspremloss:alae_reserve_current + prspremloss:alae_paid_current - prspremloss:alae_reserve_prior) +
(prspremloss:ulae_reserve_current + prspremloss:ulae_paid_current - prspremloss:ulae_reserve_prior)

define signed ascii number l_incurred_total = l_incurred + l_incurred_lae 

define unsigned ascii number l_incurred_option = parameter/prompt="Enter Ratio Type:<NL>1 - No LAE<NL>2 - Including LAE(Paid and Reserve)"
error "Option must be either 1 or 2" if l_incurred_option not one of 1,2

define signed ascii number l_incurred_ratio = if l_incurred_option = 1 then
l_direct_earned divide l_incurred
else
l_direct_earned divide l_incurred_total 

define unsigned ascii number l_multiplier[3]=100/decimalplaces=0

define file sfpnamea = access sfpname, set sfpname:policy_no= prspremloss:policy_no, generic, one to many 

define string l_status = if sfpnamea:status_date => l_starting_date and 
                            sfpnamea:status_date <= l_ending_date then sfpname:status 
else "None"
    
where (prspremloss:start_date_yyyy = year(l_starting_date) and
       prspremloss:start_date_mm   = month(l_starting_date) and
       prspremloss:end_date_yyyy   = year(l_ending_date) and
       prspremloss:end_date_mm     = month(l_ending_date) and
       prspremloss:agent_no        > 0)

--and prspremloss:agent_no one of 106 
--and sfsline:stmt_lob  <> 999
and prspremloss:claim_no <> 0 
and prspremloss:line_of_business = 0

list
/nobanner 
/duplicates 

prspremloss:agent_no 
prspremloss:claim_no 
prspremloss:policy_no 
prspremloss:agent_no 
prspremloss:line_of_business 
prspremloss:lob_subline 
sfsline:description 
sfsline:stmt_lob 
prspremloss:loss_reserve_prior /total 
prspremloss:loss_reserve_current /total 
prspremloss:loss_paid_current/total 
prspremloss:alae_Paid_current /total 
--prspremloss:alae_reserve_current/total 
--prspremloss:ulae_paid_current/total 
--prspremloss:ulae_reserve_current /total 

sorted by prspremloss:agent_no/total/newlines
