description
Active Agents by Agency Code - sorted by agent master code then agent code;

define file sfsagenta = access sfsagent, set sfsagent:company_id= sfsagent:company_id, 
                                             sfsagent:agent_no  = sfsagent:agent_master_code 

where 
  sfsagent:status = 
    0

list/nobanner/title="ACTIVE AGENTS BY AGENCY CODE" --/xls="Active Agents"
/domain="sfsagent"
  sfsagent:agent_no/left/heading="AGENCY-CODE"/column=1 
  sfsagent:agent_master_code/left/heading="MASTER-AGENT-CODE"/nocommas/column=10 
  
  --SEE BELOW FOR AGENT NAME AND ADDRESS INFORAMATION
  
  sfsagent:TELEPHONE[1]/left/heading="TELEPHONE"/mask="(XXX) XXX-XXXX"/column=90 
  sfsagent:email_address [1]/left/heading="E MAIL"/duplicates/column=110 
  sfscomun:initial/left/heading="COMM-UW"/duplicates/column=200 
  sfsagtappt:initial/left/heading="FIELD-REP"/duplicates/column=210 
  
  --AGENT NAME INFO HERE
  sfsagent:name[1]/heading="AGENT NAME & ADDRESS"/left/column=25/newline 
  if sfsagent:name[2] <> "" then 
  {
    sfsagent:name[2]/noheading/left/column=25/newline
  } 
  sfsagent:address[1]+" "+sfsagent:address[2]/column=25/newline 
  sfsagent:city+','+ sfsagent:str_state+" "+sfsagent:zipcode_5_9+"-"+sfsagent:zipcode_1_4/column=25/newline 
  "MAIL TO: "+sfsagent:contact[2]/duplicates/column=25/newline

sorted by
  sfsagent:agent_master_code /newlines 
  sfsagent:agent_no

top of sfsagent:agent_master_code 
box/noblanklines/noheadings
   "Agent Master Code  " /column=1
   sfsagent:agent_master_code/column=20/newline 
   sfsagent:name[1]/column=1/newline 
   if sfsagent:name[2] <> "" then 
   {
     sfsagent:name[2]/column=1/newline 
   }
   if sfsagent:name[3] <> "" then 
   {
     sfsagent:name[3]/column=1/newline 
   } 
   sfsagent:address[1]/column=1/newline 
   if sfsagent:address[2] <> "" then 
   {
     sfsagent:address[2]/column=1/newline 
   }
   if sfsagent:address[3] <> "" then 
   {
     sfsagent:address[3]/column=1/newline 
   }   
   trim(sfsagent:city) + ", " + sfsagent:str_state + "   " + trim(sfsagent:str_zipcode)/newline 
end box
 
top of report 
  ""/newline
  todaysdate/column=1/heading="Report Date"/mask="MM/DD/YYYY"/newline
  ""/newline

end of report 
  COUNT[sfsagent:agent_no]/heading="TOTAL"/newline
