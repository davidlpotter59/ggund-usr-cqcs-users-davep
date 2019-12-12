include "startend.inc"

where sfqname:agent_no not one of 0,9999
and (sfqname:trans_date => l_starting_date and 
      sfqname:trans_date <= l_ending_date)
list
/domain="sfqname"
/hold="applications_hold"
/append 

sfqname:app_no 
sfqname:quote_no 
sfqname:policy_no 
sfqname:trans_date 
sfqname:eff_date 
sfqname:exp_date
sfqname:line_of_business
sfqname:agent_no
