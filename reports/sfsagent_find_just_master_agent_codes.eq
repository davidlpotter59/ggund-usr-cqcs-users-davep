where sfsagent:agent_no <> sfsagent:agent_master_code 

list
/nobanner
/domain="sfsagent"
/nodetail 

sfsagent:agent_no 
sfsagent:agent_master_code 

sorted by sfsagent:agent_master_code-- /newlines 

end of sfsagent:agent_master_code 
box/blanklines /noheadings 
if count[sfsagent:agent_no] > 1 then 
{
   sfsagent:agent_master_code 
}
end box

--box/noheadings/noblanklines 
--  count[sfsagent:agent_no ]
--end box
