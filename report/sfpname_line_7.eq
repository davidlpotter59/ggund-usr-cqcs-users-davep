viewpoint native;

where 
  sfqname:line_of_business one of
    7
  and sfpname:status = 
    "CURRENT"
and sfpname:pol_year => 2018

list/nobanner/domain="sfpname"
  sfpname:policy_no 
  sfpname:pol_year 
  sfpname:end_sequence 
  sfpname:name[1]

sorted by sfpname:policy_no
