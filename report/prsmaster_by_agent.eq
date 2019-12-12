INCLUDE "STARTEND.INC"

define string l_prog_number ="Agent's Growth"

wdate l_ending_date2 = dateadd(01.01.0000,00,year(l_ending_date)) -1
wdate l_starting_date2 = dateadd(01.01.0000,00,year(l_ending_date2))
                    
wdate l_prior_starting_date = 01.01.1900 
-- this is to keep the logic the same for record selection
wdate l_prior_ending_date   = l_starting_date2 - 1

define signed ascii number l_current_year_premium = if
((prsmaster:trans_date < l_starting_date and
 prsmaster:trans_eff => l_starting_date and
 prsmaster:trans_eff <= l_ending_date) or

/* TRANSACTED WITHIN THE START DATE and THE END DATE WITH
   EFFECTIVE DATES NOT > THE l_ending_date */

(prsmaster:trans_date => l_starting_date and
 prsmaster:trans_date <= l_ending_date and
 prsmaster:trans_eff <= l_ending_date))

and

prsmaster:trans_eff <> prsmaster:trans_exp

and

 prsmaster:premium <> 0
then prsmaster:premium 
else 0.00

define signed ascii number l_allowed_premium = if sfsline2:exclude_from_contingent <> 1 then
prsmaster:premium 
else 0.00

define signed ascii number l_excluded_premium = if sfsline2:exclude_from_contingent = 1 then 
prsmaster:premium 
else 0.0

define signed ascii number l_prior_year_premium = if
((prsmaster:trans_date < l_starting_date2 and
 prsmaster:trans_eff => l_starting_date2 and
 prsmaster:trans_eff <= l_ending_date2) or

/* TRANSACTED WITHIN THE START DATE and THE END DATE WITH
   EFFECTIVE DATES NOT > THE l_ending_date */

(prsmaster:trans_date => l_starting_date2 and
 prsmaster:trans_date <= l_ending_date2 and
 prsmaster:trans_eff <= l_ending_date2))

and

prsmaster:trans_eff <> prsmaster:trans_exp

and

 prsmaster:premium <> 0
then prsmaster:premium 
else 0.00

--
define signed ascii number l_current_year_premium_allowed = if
((prsmaster:trans_date < l_starting_date and
 prsmaster:trans_eff => l_starting_date and
 prsmaster:trans_eff <= l_ending_date) or

/* TRANSACTED WITHIN THE START DATE and THE END DATE WITH
   EFFECTIVE DATES NOT > THE l_ending_date */

(prsmaster:trans_date => l_starting_date and
 prsmaster:trans_date <= l_ending_date and
 prsmaster:trans_eff <= l_ending_date))

and

prsmaster:trans_eff <> prsmaster:trans_exp

and

 prsmaster:premium <> 0
then l_allowed_premium 
else 0.00

define signed ascii number l_current_year_prem_not_allowed = if
((prsmaster:trans_date < l_starting_date and
 prsmaster:trans_eff => l_starting_date and
 prsmaster:trans_eff <= l_ending_date) or

/* TRANSACTED WITHIN THE START DATE and THE END DATE WITH
   EFFECTIVE DATES NOT > THE l_ending_date */

(prsmaster:trans_date => l_starting_date and
 prsmaster:trans_date <= l_ending_date and
 prsmaster:trans_eff <= l_ending_date))

and

prsmaster:trans_eff <> prsmaster:trans_exp

and

 prsmaster:premium <> 0
then l_excluded_premium 
else 0.00

define signed ascii number l_prior_year_premium_allowed = if
((prsmaster:trans_date < l_starting_date2 and
 prsmaster:trans_eff => l_starting_date2 and
 prsmaster:trans_eff <= l_ending_date2) or

/* TRANSACTED WITHIN THE START DATE and THE END DATE WITH
   EFFECTIVE DATES NOT > THE l_ending_date */

(prsmaster:trans_date => l_starting_date2 and
 prsmaster:trans_date <= l_ending_date2 and
 prsmaster:trans_eff <= l_ending_date2))

and

prsmaster:trans_eff <> prsmaster:trans_exp

and

prsmaster:premium <> 0
then l_allowed_premium  
else 0.00

define signed ascii number l_prior_year_premium_not_allowed = if
((prsmaster:trans_date < l_starting_date2 and
 prsmaster:trans_eff => l_starting_date2 and
 prsmaster:trans_eff <= l_ending_date2) or

/* TRANSACTED WITHIN THE START DATE and THE END DATE WITH
   EFFECTIVE DATES NOT > THE l_ending_date */

(prsmaster:trans_date => l_starting_date2 and
 prsmaster:trans_date <= l_ending_date2 and
 prsmaster:trans_eff <= l_ending_date2))

and

prsmaster:trans_eff <> prsmaster:trans_exp

and

 prsmaster:premium <> 0
then l_excluded_premium  
else 0.00


--
where prsmaster:trans_code < 17
and prsmaster:agent_no one of 150

list
/nobanner
/domain="prsmaster"
/nodetail 

sfsagent:agent_master_code/column=1/heading="Agent-Master-Number"
l_current_year_premium/column=60/heading="Current-Period-Premium"
l_current_year_prem_not_allowed /column=80/heading="Current-Period-Excluded"
l_current_year_premium_allowed/column=100/heading="Current-Period-Included"
l_prior_year_premium/column=120/heading="Prior-Period-Premium"
l_prior_year_premium_not_allowed/column=140/heading="Prior-Period-Excluded"
l_prior_year_premium_allowed/column=160/heading="Prior-Period-Included"
""/column=190/heading="Total-Percent-Change"
""/column=210/heading="Included-Percent-Change"


sorted by sfsagent:agent_master_code 

end of sfsagent:agent_master_code 
if total[l_current_year_premium] <> 0 or 
   total[l_prior_year_premium] <> 0 then 
{
box/noblanklines/noheadings 
    sfsagent:agent_master_code/column=1
    sfsagent:name[1]/column=10/width=40
    total[l_current_year_premium]/column=60
    total[l_current_year_prem_not_allowed]/column=80
    total[l_current_year_premium_allowed]/column=100
    total[l_prior_year_premium]/column=120
    total[l_prior_year_premium_not_allowed]/column=140
    total[l_prior_year_premium_allowed]/column=160
    round((((total[l_current_year_premium] - total[l_prior_year_premium]) divide total[l_current_year_premium]) * 100),2)
    /column=190/mask="ZZZ.99 %"
    round((((total[l_current_year_premium_allowed] - total[l_prior_year_premium_allowed]) divide total[
    l_current_year_premium_allowed ]) * 100),2)/column=210/mask="ZZZ.99 %"

xob
}

top of page  
L_prog_number                    /heading="Report No      "/column=1/newline 
trun(sfscompany:name[1])/heading="Company Name   "/column=1/newline  
trun(str(l_starting_date,"MM/DD/YYYY") + " - " + str(l_ending_date,"MM/DD/YYYY"))/column=1/heading="Report Period  "/newline
