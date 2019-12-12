include "startend.inc"

where arsbilling:trans_date => l_starting_date and 
      arsbilling:trans_date <= l_ending_date 
and with arsbilling:trans_code one of 50, 62, 68, 70 

list/nobanner/domain="arsbilling"
  arsbilling:policy_no /keyelement=1 
  arsbilling:trans_code /name="trans_code"
  arsbilling:installment_amount /name="fee_amount

/*
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

*/
