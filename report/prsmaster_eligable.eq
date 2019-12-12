include "startend.inc"

define unsigned ascii number l_eligable = 
if sfsline2:exclude_from_contingent one of 0 then 
1 else 0

define string l_eligable_str[30] = switch(l_eligable)
case 0 : "Premium Not Eligable"
case 1 : "Premium IS Eligable"

-- WORKERS COMP IS NOT ELIGABLE
-- 
define unsigned ascii number l_eligable_prem = if l_eligable one of 1 then prsmaster:premium 
else 0

define unsigned ascii number l_non_eligable_prem = if l_eligable not one of 1 then prsmaster:premium
else 0

include "prscollect.inc"
and sfsagent:agent_master_code one of 128 --, 150, 173, 224, 262
and prsmaster:trans_code < 17
 --and lob_subline one of "45"

list
/nobanner
/domain="prsmaster"
/duplicates 

prsmaster:agent_no 
prsmaster:policy_no 
prsmaster:line_of_business 
prsmaster:lob_subline 
sfsline:description 

sfsline2:exclude_from_contingent 

l_eligable_prem /heading="Eligable-Prmeium"/total 
l_non_eligable_prem/heading="Non Eligable-Premium"/total 

sorted by sfsagent:agent_master_code/newlines/total/heading="@"
          prsmaster:agent_no/newlines/total  
          l_eligable/total/newlines 
          prsmaster:policy_no 

top of l_eligable
box/noheadings 
   l_eligable_str /column=10/newline 
xob
