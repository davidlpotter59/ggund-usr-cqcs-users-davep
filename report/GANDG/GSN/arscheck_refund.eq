include "startend.inc"

where arscheck:check_cleared_date => l_starting_date and 
      arscheck:check_cleared_date <= l_ending_date 

list
/nobanner
/domain="arscheck"
/hold="arscheck_refund"
/nodetail 

sorted by arscheck:policy_no 

end of arscheck:policy_no 
  arscheck:policy_no/keyelement=1/mask="999999999"/name="policy_no"
  arscheck:check_amount/name="check_amount"
