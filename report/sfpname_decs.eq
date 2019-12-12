where sfpname:status = "CURRENT"
and sfpname:eff_date => 06.01.2018
and sfpname:line_of_business not one of 2, 5, 6, 7, 8, 11, 15, 50
list
/nobanner
/domain="sfpname"

sfpname:policy_no 
sfpname:name[1]
sfpname:eff_date 
sfpname:line_of_business 
sfsline_heading:description 

sorted by sfpname:line_of_business /newlines 
          sfpname:policy_no
