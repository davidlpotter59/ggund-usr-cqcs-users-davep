where prspremloss:agent_no = 100 and 
      prspremloss:start_date_yyyy = 2011 and 
      prspremloss:start_date_mm   = 01 and 
      prspremloss:end_date_yyyy   = 2011 and 
      prspremloss:end_date_mm     = 05

and prspremloss:line_of_business = 0

list
/nobanner
/domain="prspremloss"
/duplicates 

sfsline:description/duplicates  
prspremloss:policy_no 
prspremloss:claim_no 
prspremloss:line_of_business 
prspremloss:lob_subline 
prspremloss:agent_no 
prspremloss:written_premium 
prspremloss:unearned_premium_current 
prspremloss:unearned_premium_prior 
prspremloss:loss_paid_prior 
prspremloss:loss_paid_current 
prspremloss:loss_reserve_prior 
prspremloss:loss_reserve_current 

sorted by sfsline:description
