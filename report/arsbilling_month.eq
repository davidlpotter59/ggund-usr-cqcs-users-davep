include "startend.inc"

define string l_prog_number = "ARSBILLING_MONTH Dump"

where arsbilling_month:trans_date => l_starting_date and 
      arsbilling_month:trans_date <= l_ending_date and 
      arsbilling_month:disbursement_amount <> 0.00

list
/nobanner
/domain="arsbilling_month"

arsbilling_month:policy_no 
arsbilling_month:trans_date 
arsbilling_month:trans_eff 
arsbilling_month:trans_exp 
arsbilling_month:trans_code 
arsbilling_month:disbursement_amount/total  

sorted by arsbilling:policy_no/newlines/total 

include "reporttop.inc"
