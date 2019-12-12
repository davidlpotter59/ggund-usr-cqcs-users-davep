include "startend.inc"
define string l_prog_number = "Period Policy Premium - Version 7.20"

define date l_starting_date1 = dateadd(l_starting_date,0,-1)
define date l_ending_date1   = dateadd(l_ending_date,0,-1)

define unsigned ascii number l_agent_no = parameter/prompt="Enter Agent Number"

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
  prsmaster:trans_eff <= l_ending_date) or 
 (prsmaster:trans_Date < l_starting_date and 
  prsmaster:trans_eff => l_starting_date and 
  prsmaster:trans_eff <= l_ending_date )) then prsmaster:premium 
else 0.00

where prsmaster:agent_no = l_agent_no
and prsmaster:trans_code < 17

list
/nobanner
/domain="prsmaster"
/nodetail 
/noreporttotals 013

prsmaster:policy_no/column=1 
l_prior_premium/heading="Prior Written-Premium Period"/column=20 
l_current_premium/heading="Current Written-Premium Period"/column=40

sorted by prsmaster:policy_no

end of prsmaster:policy_no 
box/noblanklines/noheadings 
  if total[l_prior_premium] <> 0 or total[l_current_premium] <> 0 then 
  {
  prsmaster:policy_no /column=1
  total[l_prior_premium]/column=20
  total[l_current_premium]/column=40
}
xob


include "reporttop.inc"
""/newline
"This report is comparing the current period of " + trun(str(l_starting_date,"MM/DD/YYYY")) + " through " + trun(str(l_ending_date,"MM/DD/YYYY"))/newline
""/newline
"To the previous period of " + trun(str(l_starting_date1,"MM/DD/YYYY")) + " through " + trun(str(l_ending_date1,"MM/DD/YYYY"))/newline

end of report
""/newline=3
"To view policy detail run a policy status report in SCIPS"/centre
