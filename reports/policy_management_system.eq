viewpoint native;

--where policy_MANAGEMENT:agent_master_code one of 173
--and run_date => todaysdate -1

where policy_management:Policy_no one of 600000812

list/nobanner/domain="policy_management"
  policy_management:policy_no 
  policy_management:pol_year 
  policy_management:end_sequence 
  policy_management:sub_code 
  policy_management:agent_master_code 
  policy_management:agent_no 
  policy_management:line_of_business 
  policy_management:transaction_type 
  policy_management:search_name 
  policy_management:eff_date 
  policy_management:location_city 
  policy_management:location_state 
  policy_management:state_name 
  policy_management:action_type 
  policy_management:trans_code 
  policy_management:document_name 
  policy_management:run_date 
  policy_management:policy_exp_date 
  policy_management:copy_name

sorted by policy_management:policy_no/newlines 
          policy_management:transaction_type
