include "startend.inc"

define string l_prog_number = "Premloss Dump"

--define unsigned ascii number l_agent_no[4]=parameter 

where prspremloss_flat:start_date_yyyy = year(l_starting_date) 
and   prspremloss_flat:start_date_mm   = month(l_starting_date)
and   prspremloss_flat:end_date_yyyy   = year(l_ending_date)
and   prspremloss_flat:end_date_mm     = month(l_ending_date)
--and   prspremloss_flat:agent_no        = l_agent_no 

/*
and (prspremloss_flat:loss_reserve_prior <> 0 or
     prspremloss_flat:loss_reserve_current <> 0 or
     prspremloss_flat:loss_paid_current <> 0 or
     prspremloss_flat:loss_paid_prior <> 0)
*/

list
/nobanner
/domain="prspremloss_flat"

prspremloss_flat:agent_no 
prspremloss_flat:policy_no 
prspremloss_flat:loss_paid_current
prspremloss_flat:loss_reserve_prior 
prspremloss_flat:loss_reserve_current/total 
prspremloss_flat:ulae_reserve_prior /total 
prspremloss_flat:ulae_reserve_current/total 
prspremloss_flat:alae_reserve_prior /total 
prspremloss_flat:alae_reserve_current/total 

sorted by --prspremloss_flat:agent_no
         -- prspremloss_flat:line_of_business /newlines/total /heading="@" 
          prspremloss_flat:policy_no
