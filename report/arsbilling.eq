viewpoint native;

--where arsbilling:policy_no one of 600005877
--and arsbilling:status one of "B"

where arsbilling:trans_code one of 18, 50, 52, 68, 70 
and (arsbilling:trans_date => 09.01.2019 and 
     arsbilling:trans_date <= 09.30.2019)

list/nobanner/domain="arsbilling"/pagelength=0
  arsbilling:policy_no 
arsbilling:agent_no 
  arsbilling:end_sequence 
  arsbilling:trans_date 
  arsbilling:trans_exp 
  arsbilling:trans_code 
  arsbilling:line_of_business 
  arsbilling:lob_subline 
  arsbilling:comm_rate 
  arsbilling:billed_date 
  arsbilling:status 
  arsbilling:status_date 
  arsbilling:due_date 
  arsbilling:total_amount_paid 
  arsbilling:installment_amount 
  arsbilling:premium

sorted by arsbilling:status_date 
          arsbilling:policy_no /newlines 
          arsbilling:trans_code
