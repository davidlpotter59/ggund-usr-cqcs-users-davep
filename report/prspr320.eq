include "startend.inc"

define date l_starting_date1 = dateadd(l_starting_date,0,-1)
define date l_ending_date1   = dateadd(l_ending_date,0,-1)

--define wdate l_start_date1 = 01.01.2010
--define wdate l_ending_date1 = 01.31.2010

define l_prior_premium = if
((prsmaster:trans_date => l_starting_date1 and 
  prsmaster:trans_date <= l_ending_date1 and 
  prsmaster:trans_eff <= l_ending_date1 ) or 
 (prsmaster:trans_Date < l_starting_date1 and 
  prsmaster:trans_eff => l_starting_date1 and 
  prsmaster:trans_eff <= l_ending_date1 )) then prsmaster:premium 
else 0.00

define l_current_premium = if
((prsmaster:trans_date => l_starting_date and 
  prsmaster:trans_date <= l_ending_date and 
  prsmaster:trans_eff <= l_ending_date1) or 
 (prsmaster:trans_Date < l_starting_date and 
  prsmaster:trans_eff => l_starting_date and 
  prsmaster:trans_eff <= l_ending_date )) then prsmaster:premium 
else 0.00

--where prsmaster:agent_no one of 173
where prsmaster:trans_code < 17

list
/nobanner
/domain="prsmaster"
/nodetail 
/noreporttotals

prsmaster:policy_no/column=1 
prsmaster:agent_no/column=20/heading="Agent-No"
sfpname:name[1]/column=30/heading="Insured's Name"/width=40
prsmaster:trans_date/column=80
prsmaster:trans_eff/column=100
prscode:description /column=120/width=20
l_prior_premium/heading="Prior Written-Premium Period"/column=140 
l_current_premium/heading="Current Written-Premium Period"/column=160

sorted by prsmaster:agent_no/newlines 
          prsmaster:policy_no

end of prsmaster:agent_no  
box/noblanklines/noheadings 
  if total[l_prior_premium] <> 0 or total[l_current_premium] <> 0 then 
  {
  "AGENT TOTAL "/column=125
  total[l_prior_premium]/column=140
  total[l_current_premium]/column=160
}
xob

end of prsmaster:policy_no 
box/noblanklines/noheadings 
  if total[l_prior_premium] <> 0 or total[l_current_premium] <> 0 then 
  {
  prsmaster:policy_no /column=1
  prsmaster:agent_no/column=20
  sfpname:name[1]/column=30/width=30
  prsmaster:trans_date/column=80
  prsmaster:trans_eff/column=100
  prscode:description /column=120/width=20
  total[l_prior_premium]/column=140
  total[l_current_premium]/column=160
}
xob

end of report  
box/noheadings 
  if total[l_prior_premium] <> 0 or total[l_current_premium] <> 0 then 
  {
  ""/newline =2
  "REPORT TOTAL "/column=125
  total[l_prior_premium]/column=140
  total[l_current_premium]/column=160
}
xob
top of page
"This report is comparing the current period of " + trun(str(l_starting_date,"MM/DD/YYYY")) + " through " + trun(str(l_ending_date,"MM/DD/YYYY"))/newline
""/newline
"To the previous period of " + trun(str(l_starting_date1,"MM/DD/YYYY")) + " through " + trun(str(l_ending_date1,"MM/DD/YYYY"))/newline
