define file sfsagenta = access sfsagent, set sfsagent:company_id= sfsagent:company_id, 
                                             sfsagent:agent_no= sfsagent:agent_master_code 

define file sfsagentb = access sfsagent, set sfsagent:company_id= sfsagenta:company_id, 
                                             sfsagent:agent_no= sfsagenta:agent_master_code 

where sfsagent:agent_master_code  = 103 -- and sfsagent:agent_master_code < 7000

list/nobanner/domain="sfsagent"
  sfsagent:agent_no 
  sfsagent:name[1] 
  sfsagent:agent_master_code
  sfsagenta:name [1]/heading="Master Agent Name"
  sfsagenta:agent_master_code/heading="Points to"
  sfsagentb:name[1]

sorted by sfsagent:agent_master_code /newlines
