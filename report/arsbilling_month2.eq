define wdate l_ending_date = parameter 

define signed ascii number l_90_days = if l_ending_date  - arsbilling_month:due_date => 90 then 
(arsbilling_month:installment_amount - arsbilling_month:write_off_amount - arsbilling_month:total_amount_paid) else 0/decimalplaces=2

where --arsbilling_month:policy_no one of 600000629

trans_code one of 15
and l_90_days <> 0

list
/nobanner
/domain="arsbilling_month"

arsbilling_month:policy_no 
arsbilling_month:trans_date 
arsbilling_month:trans_eff 
arsbilling_month:trans_code 
arsbilling_month:due_date 
arsbilling_month:installment_amount/total  
arsbilling_month:write_off_amount/total  
arsbilling_month:total_amount_paid/total 
arsbilling_month:disbursement_amount /total  
(arsbilling_month:installment_amount - arsbilling_month:write_off_amount - arsbilling_month:total_amount_paid)/heading="Net-Amount-Due"
l_90_days/heading="Over-90"

sorted by arsbilling_month:trans_date /total/newlines
