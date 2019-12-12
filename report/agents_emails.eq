viewpoint native;

define l_yes_no = if sfsagent:email_address = "" then 0 else 1

where 
  sfsagent:status = 
    0

list/nobanner/domain="sfsagent"
  sfsagent:agent_no 
  sfsagent:name [1]
  sfsagent:email_address

sorted by l_yes_no sfsagent:agent_no
