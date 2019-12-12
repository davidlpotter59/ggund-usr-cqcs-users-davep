include "startend.inc"

where arscheck:check_cleared_date => l_starting_date and 
      arscheck:check_cleared_date <= l_ending_date 

list
/nobanner
/domain="arscheck"
/hold="arscheck"
  arscheck:policy_no/keyelement=1 
  arscheck:check_amount
