viewpoint native;
define wdate l_starting_date = todaysdate 
define wdate l_ending_date   = todaysdate 

where 
  sfsagent:status one of
    0

list/nobanner/domain="sfsagent"
  sfsagent:agent_no /column=10
  sfsagent:name [1]
 -- sfsagent:contact [1]
  sfsagent:agent_master_code 
  sfsagent:email_address

sorted by sfsagent:agent_master_code/newlines  
          sfsagent:agent_no 

top of sfsagent:agent_master_code 
box/noheadings/noblanklines 
   str(sfsagent:agent_master_code,'ZZZZ') + ' ' + trim(sfsagent:name[1])
end box
""/newline 

include "reporttop.inc"
