viewpoint native;

where aggregate_limit_loc:policy_no => 809000031 and 
      aggregate_limit_loc:policy_no <= 809000039

list/nobanner/domain="aggregate_limit_loc"
  aggregate_limit_loc:policy_no 
  aggregate_limit_loc:str_state 
  aggregate_limit_loc:prem_no 
  aggregate_limit_loc:build_no 
  aggregate_limit_loc:line_of_business 
  aggregate_limit_loc:class_code 
  aggregate_limit_loc:occupancycode
  aggregate_limit_loc:class_code_description 


sorted by aggregate_limit_loc:policy_no/newlines
