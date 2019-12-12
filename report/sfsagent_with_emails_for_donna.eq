viewpoint native;

where 
  sfsagent:status one of
    0

list/nobanner/domain="sfsagent"
  sfsagent:agent_no 
  sfsagent:name [1]
  sfsagent:name[2]/noheading 
  sfsagent:agent_master_code 
  sfsagent:email_address

sorted by sfsagent:agent_master_code/newlines=2
          sfsagent:agent_no 

top of sfsagent:agent_master_code 
box/noheadings/noblanklines 
   "Master Agent Information"
   sfsagent:agent_master_code
   sfsagent:name[1]
end box 
""/newline 
"-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
""/newline
