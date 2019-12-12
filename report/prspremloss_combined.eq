include "startend.inc"

define string l_prog_number = "Premloss Dump"

define unsigned ascii number l_agent_no[4]=parameter 

where prspremloss_combined:start_date_yyyy = year(l_starting_date) 
and   prspremloss_combined:start_date_mm   = month(l_starting_date)
and   prspremloss_combined:end_date_yyyy   = year(l_ending_date)
and   prspremloss_combined:end_date_mm     = month(l_ending_date)
/*
and   prspremloss_combined:agent_no        = l_agent_no 

and (prspremloss_combined:loss_reserve_prior <> 0 or
     prspremloss_combined:loss_reserve_current <> 0 or
     prspremloss_combined:loss_paid_current <> 0 or
     prspremloss_combined:loss_paid_prior <> 0)
*/

list
/nobanner
/domain="prspremloss_combined"

prspremloss_combined:agent_no 
prspremloss_combined:policy_no 
prspremloss_combined:loss_paid_current
prspremloss_combined:loss_reserve_prior 
prspremloss_combined:loss_reserve_current/total 
prspremloss_combined:ulae_reserve_prior/total 
prspremloss_combined:ulae_reserve_current/total 
prspremloss_combined:alae_reserve_prior/total 
prspremloss_combined:alae_reserve_current/total 

sorted by prspremloss_combined:agent_no
          prspremloss_combined:line_of_business /newlines/total /heading="@" 
          prspremloss_combined:policy_no
