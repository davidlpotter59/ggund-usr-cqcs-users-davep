include "startend.inc"

define string l_prog_number = "Premloss Dump"

--define unsigned ascii number l_agent_no[4]=parameter 

where prspremloss:start_date_yyyy = year(l_starting_date) 
and   prspremloss:start_date_mm   = month(l_starting_date)
and   prspremloss:end_date_yyyy   = year(l_ending_date)
and   prspremloss:end_date_mm     = month(l_ending_date)
--and   prspremloss:agent_no        = l_agent_no 

/*
and (prspremloss:loss_reserve_prior <> 0 or
     prspremloss:loss_reserve_current <> 0 or
     prspremloss:loss_paid_current <> 0 or
     prspremloss:loss_paid_prior <> 0)
*/

list
/nobanner
/domain="prspremloss"

prspremloss:agent_no 
prspremloss:policy_no 
prspremloss:loss_paid_current
prspremloss:loss_reserve_prior 
prspremloss:loss_reserve_current/total 
prspremloss:ulae_reserve_prior /total 
prspremloss:ulae_reserve_current/total 
prspremloss:alae_reserve_prior /total 
prspremloss:alae_reserve_current/total 

sorted by --prspremloss:agent_no
         -- prspremloss:line_of_business /newlines/total /heading="@" 
          prspremloss:policy_no
