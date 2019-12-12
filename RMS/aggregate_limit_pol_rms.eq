define file sfpcurrenta = access sfpcurrent, set sfpcurrent:policy_no= aggregate_limit_pol:policy_no  

define file cppgenerala = access cppgeneral, set cppgeneral:policy_no= aggregate_limit_pol:policy_no,
                                                 cppgeneral:pol_year= sfpcurrenta:pol_year, 
                                                 cppgeneral:end_sequence= sfpcurrenta:end_sequence,
                                                 cppgeneral:prem_no= aggregate_limit_pol:prem_no,
                                                 cppgeneral:build_no= aggregate_limit_pol:build_no, generic, one to many  
list

/domain="aggregate_limit_pol"

company_id policy_no prem_no line_of_business deductible building_limit 
contents_limit business_income_limit casualty_limit casualty_premium/heading="Written-Premium" trans_code
trans_date trans_eff trans_exp other_structures_limit agent_no county eff_date number_of_auto

sfpcurrenta:policy_no pol_year 

cppgenerala:policy_no prem_no build_no
