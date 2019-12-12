include "startend.inc"

where arsbilling:trans_date => l_starting_date and 
      arsbilling:trans_date <= l_ending_date 
and with arsbilling:trans_code one of 50, 62, 68, 70 

list
/nobanner
/domain="arsbilling"
/nodetail 
/hold="arsaccountcurrent_fees"

sorted by arsbilling:policy_no 

end of arsbilling:policy_no 
  arsbilling:policy_no /keyelement=1 /mask="999999999"/name="policy_no"
  arsbilling:trans_code /name="trans_code"
  arsbilling:installment_amount /name="fee_amount"
