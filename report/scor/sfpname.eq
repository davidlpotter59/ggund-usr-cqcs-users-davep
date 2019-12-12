where sfpname:trans_date => 11.15.2018

list
/nobanner
/domain="sfpname"

sfpname:line_of_business 
--sfsline:description 
sfpname:policy_no 
sfpname:previous_policy_no
sfpname:status
sfpname:trans_date 
sfpname:eff_date 
sfpname:exp_date 
dateadd(sfpname:exp_date,0,1)

sorted by sfpname:line_of_business /newlines 
          sfpname:policy_no
