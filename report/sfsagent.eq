--where sfsagent:agent_no one of 153,128
list
/nobanner
/domain="sfsagent"
/title="Agent's Master List"

sfsagent:agent_no 
sfsagent:name[1]/column=10
sfsagent:address[1]/column=65
sfsagent:city/column=120
sfsagent:str_state/column=155
sfsagent:str_zipcode /column=160/newline 

sfsagent:name[2]/column=10/noheading 
sfsagent:address[2]/column=65/noheading /newline 

sfsagent:name[3]/column=10/noheading 
sfsagent:address[3]/column=65/noheading /newline 

box/noblanklines 
sfsagent:contact[1]/column=10/noheading /newline 

if sfsagent:contact[2] <> "" then 
{
  sfsagent:contact[2]/column=10/noheading /newline 
}

if sfsagent:contact[3] <> "" then 
{
sfsagent:contact[3]/column=10/noheading /newline 
}

if sfsagent:contact[4] <> "" then 
{
  sfsagent:contact[4]/column=10/noheading /newline 
}

if sfsagent:contact[5] <> "" then 
{
  sfsagent:contact[5]/column=10/noheading /newline 
}
end box

sfsagent:telephone[1]/mask="999-999-9999"/column=10/noheading /newline 
--sfsagent:telephone[2]/column=10/noheading/newline 
sfsagent:email_address /column=10/newline 

sorted by sfsagent:agent_master_code /newlines

top of sfsagent:agent_master_code 
box/noblanklines 
sfsagent:agent_master_code 
sfsagent:name[1]/newline 
xob
