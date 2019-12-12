viewpoint native;

where 
  sfpname:status = 
    "CURRENT"
 -- and sfpname:agent_no = 
 --   173
  and sfpname:line_of_business one of
    8
  and sfpname:eff_date >= 
    1.oct.2018

list/nobanner/domain="sfpname"
  sfpname:policy_no 
  sfpname:trans_date 
  sfpname:eff_date 
  sfpname:status 
  sfpname:line_of_business 
  sfpname:policy_type
  sfpname:agent_no
