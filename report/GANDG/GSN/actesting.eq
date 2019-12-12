include "startend.inc"

access arspremium, set arspremium:policy_no= arschksu:policy_no 

where arschksu:trans_date => l_starting_date and 
      arschksu:trans_date <= l_ending_date 

list/nobanner/domain="arschksu"
  arschksu:policy_no 
  arschksu:trans_date 
  arschksu:trans_eff 
  arschksu:check_amount
  arspremium:premium
