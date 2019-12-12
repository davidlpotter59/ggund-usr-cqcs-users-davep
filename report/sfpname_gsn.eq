where sfpname:line_of_business one of 5 and sfpname:status one of "CURRENT"
and sfpname:eff_date => 09.01.2018

list
/nobanner
/domain="sfpname"

policy_no 
line_of_business sfsline_heading:description sfpname:status
