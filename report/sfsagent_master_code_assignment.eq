--where sfsagent:agent_master_code one of 104, 106, 107, 111, 114, 129, 145,
--        159, 161, 165, 168, 177, 182, 184, 200, 207, 210, 211, 262

list
/nobanner
/domain="sfsagent"

agent_master_code
sfsagent:agent_no 
name[1]

sorted by agent_master_code /newlines
          agent_no

top of page
"Program Name: " + trun(enquiryname) /noheading /newline 
"Company:         " + trun(sfscompany:name[1])/newline =2
