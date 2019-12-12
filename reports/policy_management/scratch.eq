define wdate l_starting_date = parameter/prompt="Enter your starting Date" default todaysdate -1
define wdate l_ending_date = parameter/prompt="Enter your ending Date" default todaysdate 

where (policy_management:run_date => 01.01.1900 and 
       policy_management:run_date <= l_ending_date and
       policy_management:action_type = "Policy" and
       policy_management:copy_name = "Original")

list
/nobanner
/domain="policy_management"
/hold = "polman"

policy_management:policy_no 
policy_management:run_date 
policy_management:action_type 
--policy_management:copy_name 

sorted by policy_management:policy_no 
          policy_management:action_type 

end of policy_management:action_type 
policy_management:policy_no /keyelement=1/heading="policy_no"
policy_management:run_date/keyelement=2/heading="run_date"
policy_management:action_type /keyelement=3/heading="action_type"
