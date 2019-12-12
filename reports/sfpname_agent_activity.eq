define wdate l_starting_date = parameter/prompt="Enter your starting Date" default todaysdate -1
define wdate l_ending_date = parameter/prompt="Enter your ending Date" default todaysdate 
define unsigned ascii number l_agent_no =parameter/prompt="Enter Agent No"

define file policy_management_system_alt = access policy_management, set policy_management:policy_no= sfpname:policy_no,
                                                                         policy_management:pol_year= sfpname:pol_year,
                                                                         policy_management:end_sequence= sfpname:end_sequence, generic, one to many 


define string l_policy_management_policy_no = if policy_management_system_alt:policy_no= sfpname:policy_no and 
                                                                policy_management_system_alt:action_type = 
                                                                "Policy" then str(policy_management_system_alt:policy_no,"ZZZZZZZZZ")
                                                                else "Invoice"

define string l_policy_management_action_type = if policy_management_system_alt:policy_no= sfpname:policy_no and 
                                                                policy_management_system_alt:action_type = "Policy" then "Policy"
                                                                else   ""

where sfpname:trans_date => l_starting_date and 
      sfpname:trans_date =< l_ending_date  and
      sfppoint:converted <> "N" and sfpname:agent_no = l_agent_no 

list
/nobanner
/domain="sfpname"
/duplicates 
/nototals 

sfpname:policy_no 
sfpname:pol_year 
sfpname:end_sequence 
sfpname:name[1] 
sfpname:agent_no 
sfpname:trans_date

--l_policy_management_policy_no /heading="Policy-Management-Policy Number"
--l_policy_management_action_type/heading="Action-Type"

sorted by sfpname:agent_no
          sfpname:policy_no/newlines 

top of sfpname:agent_no 
box/noblanklines/noheadings 
  str(sfpname:agent_no) + " - " + trim(sfsagent:name[1])
end box
""/newline

include "reporttop.inc"
