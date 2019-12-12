where prsmaster:trans_date => 06.11.2010 and 
      prsmaster:trans_date <= 06.11.2010 and 
      prsmaster:trans_code < 17
and sfppoint:converted = "N"

list
/nobanner
/domain="prsmaster"

prsmaster:policy_no 
prsmaster:trans_date 
trans_code 
prsmaster:line_of_business 
prsmaster:lob_subline 
trans_eff 
trans_exp 
premium 
operator_id 
sfppoint:converted

sorted by prsmaster:policy_no /newlines
