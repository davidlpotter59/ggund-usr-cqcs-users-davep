--define file arschksua = access arschksu, set arschksu:check_no = arsbilling:check_no, using fifth index
where arsbilling:status <> "O"

list
/nobanner
/domain="arsbilling"

arsbilling:policy_no 
arsbilling:check_no 
--arschksua:check_no 
arsbilling:billing_ctr 
arsbilling:installment_amount 
arsbilling:total_amount_paid 
arsbilling:write_off_amount 
arsbilling:due_date 
arsbilling:billed_date 
arsbilling:status 
arsbilling:status_date 

sorted by arsbilling:policy_no /newlines 
          arsbilling:billing_ctr
