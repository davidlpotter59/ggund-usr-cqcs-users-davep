define unsigned ascii number l_agent_no = parameter/prompt="Enter Agent Number"
include "ending.inc"

define wdate l_starting_date99a = dateadd(01.01.0000,0,year(l_ending_date))

define l_different_years = l_ending_date - l_starting_date 
define unsigned ascii number l_minimum_premium = 500000

define wdate l_starting_date1 = dateadd(l_starting_date99a,0,-1)
define wdate l_starting_date2a = dateadd(l_starting_date99a,0,-2)

define wdate l_ending_date1 = dateadd(l_ending_date,0,-1)
define wdate l_ending_date2 = dateadd(l_ending_date,0,-2)


define signed ascii number l_premium = if ((prsmaster_combined:trans_date < l_starting_date99a and 
                                             prsmaster_combined:trans_eff => l_starting_date99a and 
                                             prsmaster_combined:trans_eff <= l_ending_date) or 
                                            (prsmaster_combined:trans_date => l_starting_date99a and 
                                             prsmaster_combined:trans_date <= l_ending_date  and 
                                             prsmaster_combined:trans_eff <= l_ending_date)) then prsmaster_combined:premium else 0.00


define signed ascii number l_premium1 = if ((prsmaster_combined:trans_date < l_starting_date1 and 
                                             prsmaster_combined:trans_eff => l_starting_date1 and 
                                             prsmaster_combined:trans_eff <= l_ending_date1) or 
                                            (prsmaster_combined:trans_date => l_starting_date1 and 
                                             prsmaster_combined:trans_date <= l_ending_date1 and 
                                             prsmaster_combined:trans_eff <= l_ending_date1)) then prsmaster_combined:premium else 0.00

define signed ascii number l_premium2 = if ((prsmaster_combined:trans_date < l_starting_date2a and 
                                             prsmaster_combined:trans_eff => l_starting_date2a and 
                                             prsmaster_combined:trans_eff <= l_ending_date2) or 
                                            (prsmaster_combined:trans_date => l_starting_date2a and 
                                             prsmaster_combined:trans_date <= l_ending_date2 and 
                                             prsmaster_combined:trans_eff <= l_ending_date2)) then prsmaster_combined:premium else 0.00

define file sfslinea = access sfsline, set sfsline:company_id= prsmaster_combined:company_id, 
                                           sfsline:line_OF_BUSINESS= prsmaster_combined:line_of_business,
                                           sfsline:lob_subline= prsmaster_combined:lob_subline 

define signed ascii number l_eligable_premium = if ((prsmaster_combined:trans_date < l_starting_date99a and 
                                             prsmaster_combined:trans_eff => l_starting_date99a and 
                                             prsmaster_combined:trans_eff <= l_ending_date) or 
                                            (prsmaster_combined:trans_date => l_starting_date99a and 
                                             prsmaster_combined:trans_date <= l_ending_date and 
                                             prsmaster_combined:trans_eff <= l_ending_date)) and 
                                             sfsline2:exclude_from_contingent = 0 then l_premium else 0.00

define signed ascii number l_eligable_premium1 = if ((prsmaster_combined:trans_date < l_starting_date1 and 
                                             prsmaster_combined:trans_eff => l_starting_date1 and 
                                             prsmaster_combined:trans_eff <= l_ending_date1) or 
                                            (prsmaster_combined:trans_date => l_starting_date1 and 
                                             prsmaster_combined:trans_date <= l_ending_date1 and 
                                             prsmaster_combined:trans_eff <= l_ending_date1)) and 
                                             sfsline2:exclude_from_contingent = 0 then l_premium1 else 0.00

define signed ascii number l_eligable_premium2 = if ((prsmaster_combined:trans_date < l_starting_date2a and 
                                             prsmaster_combined:trans_eff => l_starting_date2a and 
                                             prsmaster_combined:trans_eff <= l_ending_date2) or 
                                            (prsmaster_combined:trans_date => l_starting_date2a and 
                                             prsmaster_combined:trans_date <= l_ending_date2 and 
                                             prsmaster_combined:trans_eff <= l_ending_date2)) and 
                                             sfsline2:exclude_from_contingent = 0 then l_premium2 else 0.00
define signed ascii number l_not_eligable_premium = if ((prsmaster_combined:trans_date < l_starting_date99a and 
                                             prsmaster_combined:trans_eff => l_starting_date99a and 
                                             prsmaster_combined:trans_eff <= l_ending_date) or 
                                            (prsmaster_combined:trans_date => l_starting_date99a and 
                                             prsmaster_combined:trans_date <= l_ending_date and 
                                             prsmaster_combined:trans_eff <= l_ending_date)) and 
                                             sfsline2:exclude_from_contingent = 1 then l_premium else 0.00

define signed ascii number l_not_eligable_premium1 = if ((prsmaster_combined:trans_date < l_starting_date1 and 
                                             prsmaster_combined:trans_eff => l_starting_date1 and 
                                             prsmaster_combined:trans_eff <= l_ending_date1) or 
                                            (prsmaster_combined:trans_date => l_starting_date1 and 
                                             prsmaster_combined:trans_date <= l_ending_date1 and 
                                             prsmaster_combined:trans_eff <= l_ending_date1)) and 
                                             sfsline2:exclude_from_contingent = 1 then l_premium1 else 0.00

define signed ascii number l_not_eligable_premium2 = if ((prsmaster_combined:trans_date < l_starting_date2a and 
                                             prsmaster_combined:trans_eff => l_starting_date2a and 
                                             prsmaster_combined:trans_eff <= l_ending_date2) or 
                                            (prsmaster_combined:trans_date => l_starting_date2a and 
                                             prsmaster_combined:trans_date <= l_ending_date2 and 
                                             prsmaster_combined:trans_eff <= l_ending_date2)) and 
                                             sfsline2:exclude_from_contingent = 1 then l_premium2 else 0.00

-- ************************************************
-- calculate unearned premium - current period
-- ************************************************
define unsigned ascii number l_unearned_type[1]=parameter/prompt=
"Enter the unearned type for this report:<NL>1 - Daily Prorata<NL>2 - Monthly Prorata<NL>"
error "Invalid Selection - Options are 1 or 2 ONLY!" if l_unearned_type not one of 1, 2


/* Daily prorata calculations */
define unsigned ascii number l_days_inforce[4]= if prsmaster_combined:trans_exp > l_ending_date then prsmaster_combined:trans_exp 
- l_ending_date else 0
define unsigned ascii number l_total_days[4] = prsmaster_combined:trans_exp - prsmaster_combined:trans_eff
define unsigned ascii number l_current_unearned_factor[5]=l_days_inforce divide l_total_days/decimalplaces=4

/* Monthly (1/24) prorata calculations */
define unsigned ascii number l_total_months[3]=month(prsmaster_combined:trans_exp) - month(l_ending_date)
define unsigned ascii number l_years_left[2]= year(prsmaster_combined:trans_exp) - year(l_ending_date)
define unsigned ascii number l_total_months2[3]=l_total_months + (l_years_left * 12)

define signed ascii number l_unearned_factor = if l_unearned_type one of 1 then l_current_unearned_factor 
else
((l_total_months2 * 2) -1) divide 24

/* calculate the unearned based on option selected */
define signed ascii number l_unearned = if 
l_unearned_type one of 1 then 
    l_premium *  l_unearned_factor  -- l_current_unearned_factor 
else if 
l_unearned_type one of 2 then 
    l_premium * l_unearned_factor   -- ((l_total_months2 * 2) -1) divide 24
else
0/decimalplaces=2

-- ineligable unearned calc
define signed ascii number l_unearned_not_eligable = if 
l_unearned_type one of 1 then 
    l_not_eligable_premium *  l_unearned_factor  -- l_current_unearned_factor 
else if 
l_unearned_type one of 2 then 
    l_not_eligable_premium * l_unearned_factor   -- ((l_total_months2 * 2) -1) divide 24
else
0/decimalplaces=2

-- ineligable unearned calc
define signed ascii number l_unearned_eligable = if 
l_unearned_type one of 1 then 
    l_eligable_premium *  l_unearned_factor  -- l_current_unearned_factor 
else if 
l_unearned_type one of 2 then 
    l_eligable_premium * l_unearned_factor   -- ((l_total_months2 * 2) -1) divide 24
else
0/decimalplaces=2


-- *******************************
-- prior unearned premium (current year -1 year)
-- *******************************

/* Daily prorata calculations */

define unsigned ascii number l_days_inforce_prior[4]= if
((prsmaster_combined:trans_date < l_starting_date1 and 
  prsmaster_combined:trans_eff  >= l_starting_date1 and 
  prsmaster_combined:trans_eff  <= l_ending_date1) or
 (prsmaster_combined:trans_date >= l_starting_date1 and 
  prsmaster_combined:trans_date <= l_ending_date1 and 
  prsmaster_combined:trans_eff  <= l_ending_date1)) and 
  prsmaster_combined:trans_exp > l_ending_date then 
prsmaster_combined:trans_exp - l_ending_date1                  
else
0

define unsigned ascii number l_total_days_prior[4] = if
((prsmaster_combined:trans_date < l_starting_date1 and 
  prsmaster_combined:trans_eff  >= l_starting_date1 and 
  prsmaster_combined:trans_eff  <= l_ending_date1) or
 (prsmaster_combined:trans_date >= l_starting_date1 and 
  prsmaster_combined:trans_date <= l_ending_date1 and 
  prsmaster_combined:trans_eff  <= l_ending_date1)) then 
prsmaster_combined:trans_exp - prsmaster_combined:trans_eff            
else
0.00

define unsigned ascii number l_current_unearned_factor_prior[5]=if
((prsmaster_combined:trans_date < l_starting_date1 and 
  prsmaster_combined:trans_eff  >= l_starting_date1 and 
  prsmaster_combined:trans_eff  <= l_ending_date1) or
 (prsmaster_combined:trans_date >= l_starting_date1 and 
  prsmaster_combined:trans_date <= l_ending_date1 and 
  prsmaster_combined:trans_eff  <= l_ending_date1)) then 
l_days_inforce_prior divide l_total_days_prior/decimalplaces=4   
else
0

/* Monthly (1/24) prorata calculations */
define unsigned ascii number l_total_months_prior[3]=if
((prsmaster_combined:trans_date < l_starting_date1 and 
  prsmaster_combined:trans_eff  >= l_starting_date1 and 
  prsmaster_combined:trans_eff  <= l_ending_date1) or
 (prsmaster_combined:trans_date >= l_starting_date1 and 
  prsmaster_combined:trans_date <= l_ending_date1 and 
  prsmaster_combined:trans_eff  <= l_ending_date1)) then 
month(prsmaster_combined:trans_exp) - month(l_ending_date1)    
else
0

define unsigned ascii number l_years_left_prior[2]= if
((prsmaster_combined:trans_date < l_starting_date1 and 
  prsmaster_combined:trans_eff  >= l_starting_date1 and 
  prsmaster_combined:trans_eff  <= l_ending_date1) or
 (prsmaster_combined:trans_date >= l_starting_date1 and 
  prsmaster_combined:trans_date <= l_ending_date1 and 
  prsmaster_combined:trans_eff  <= l_ending_date1)) then 
year(prsmaster_combined:trans_exp) - year(l_ending_date1)      
else
0

define unsigned ascii number l_total_months2_prior[3]=if
((prsmaster_combined:trans_date < l_starting_date1 and 
  prsmaster_combined:trans_eff  >= l_starting_date1 and 
  prsmaster_combined:trans_eff  <= l_ending_date1) or
 (prsmaster_combined:trans_date >= l_starting_date1 and 
  prsmaster_combined:trans_date <= l_ending_date1 and 
  prsmaster_combined:trans_eff  <= l_ending_date1)) then 
l_total_months_prior + (l_years_left_prior * 12)                 
else
0

define signed ascii number l_unearned_factor_prior_1 = if l_unearned_type one of 1 then l_current_unearned_factor_prior  
else
((l_total_months2_prior * 2) -1) divide 24                 

define signed ascii number l_unearned_factor_prior = if prsmaster_combined:trans_exp > l_ending_date1 then 
l_unearned_factor_prior_1 
else 0.0000

/* calculate the unearned based on option selected */
define signed ascii number l_unearned_prior = if 
l_unearned_type one of 1 then 
    l_premium1 *  l_unearned_factor_prior_1  -- l_current_unearned_factor 
else if 
l_unearned_type one of 2 then 
    l_premium1 * l_unearned_factor_prior   -- ((l_total_months2_prior * 2) -1) divide 24
else
0/decimalplaces=2

define signed ascii number l_unearned_prior_not_eligable = if 
l_unearned_type one of 1 then 
    l_not_eligable_premium1 *  l_unearned_factor_prior_1  -- l_current_unearned_factor 
else if 
l_unearned_type one of 2 then 
    l_not_eligable_premium1 * l_unearned_factor_prior   -- ((l_total_months2_prior * 2) -1) divide 24
else
0/decimalplaces=2

define signed ascii number l_unearned_prior_eligable = if 
l_unearned_type one of 1 then 
    l_eligable_premium1 *  l_unearned_factor_prior_1  -- l_current_unearned_factor 
else if 
l_unearned_type one of 2 then 
    l_eligable_premium1 * l_unearned_factor_prior   -- ((l_total_months2_prior * 2) -1) divide 24
else
0/decimalplaces=2

-- *******************************
-- second prior unearned premium (current year -2 years)
-- *******************************

/* Daily prorata calculations */

define unsigned ascii number l_days_inforce_prior2[4]= if
((prsmaster_combined:trans_date < l_starting_date2a and 
  prsmaster_combined:trans_eff  >= l_starting_date2a and 
  prsmaster_combined:trans_eff  <= l_ending_date2) or
 (prsmaster_combined:trans_date >= l_starting_date2a and 
  prsmaster_combined:trans_date <= l_ending_date2 and 
  prsmaster_combined:trans_eff  <= l_ending_date2)) and
  prsmaster_combined:trans_exp > l_ending_date2 then 
prsmaster_combined:trans_exp - l_ending_date2                  
else
0

define unsigned ascii number l_total_days_prior2[4] = if
((prsmaster_combined:trans_date < l_starting_date2a and 
  prsmaster_combined:trans_eff  >= l_starting_date2a and 
  prsmaster_combined:trans_eff  <= l_ending_date2) or
 (prsmaster_combined:trans_date >= l_starting_date2a and 
  prsmaster_combined:trans_date <= l_ending_date2 and 
  prsmaster_combined:trans_eff  <= l_ending_date2)) then 
prsmaster_combined:trans_exp - prsmaster_combined:trans_eff            
else
0.00

define unsigned ascii number l_current_unearned_factor_prior2[5]=if
((prsmaster_combined:trans_date < l_starting_date2a and 
  prsmaster_combined:trans_eff  >= l_starting_date2a and 
  prsmaster_combined:trans_eff  <= l_ending_date2) or
 (prsmaster_combined:trans_date >= l_starting_date2a and 
  prsmaster_combined:trans_date <= l_ending_date2 and 
  prsmaster_combined:trans_eff  <= l_ending_date2)) then 
l_days_inforce_prior2 divide l_total_days_prior2/decimalplaces=4   
else
0

/* Monthly (1/24) prorata calculations */
define unsigned ascii number l_total_months_prior2[3]=if
((prsmaster_combined:trans_date < l_starting_date2a and 
  prsmaster_combined:trans_eff  >= l_starting_date2a and 
  prsmaster_combined:trans_eff  <= l_ending_date2) or
 (prsmaster_combined:trans_date >= l_starting_date2a and 
  prsmaster_combined:trans_date <= l_ending_date2 and 
  prsmaster_combined:trans_eff  <= l_ending_date2)) then 
month(prsmaster_combined:trans_exp) - month(l_ending_date2)    
else
0

define unsigned ascii number l_years_left_prior2[2]= if
((prsmaster_combined:trans_date < l_starting_date2a and 
  prsmaster_combined:trans_eff  >= l_starting_date2a and 
  prsmaster_combined:trans_eff  <= l_ending_date2) or
 (prsmaster_combined:trans_date >= l_starting_date2a and 
  prsmaster_combined:trans_date <= l_ending_date2 and 
  prsmaster_combined:trans_eff  <= l_ending_date2)) then 
year(prsmaster_combined:trans_exp) - year(l_ending_date2)      
else
0

define unsigned ascii number l_total_months2_prior2[3]=if
((prsmaster_combined:trans_date < l_starting_date2a and 
  prsmaster_combined:trans_eff  >= l_starting_date2a and 
  prsmaster_combined:trans_eff  <= l_ending_date2) or
 (prsmaster_combined:trans_date >= l_starting_date2a and 
  prsmaster_combined:trans_date <= l_ending_date2 and 
  prsmaster_combined:trans_eff  <= l_ending_date2)) then 
l_total_months_prior + (l_years_left_prior2 * 12)                 
else
0

define signed ascii number l_unearned_factor_prior_2 = if l_unearned_type one of 1 then l_current_unearned_factor_prior2  
else
((l_total_months2_prior2 * 2) -1) divide 24                 

define signed ascii number l_unearned_factor_prior2 = if prsmaster_combined:trans_exp > l_ending_date1 then 
l_unearned_factor_prior_2 
else 0.0000

/* calculate the unearned based on option selected */
define signed ascii number l_unearned_prior2 = if 
l_unearned_type one of 1 then 
    l_premium2 *  l_current_unearned_factor_prior2 
else if 
l_unearned_type one of 2 then 
    l_premium2 * ((l_total_months_prior2 * 2) -1) divide 24
else
0/decimalplaces=2

define signed ascii number l_unearned_prior_not_eligable2 = if 
l_unearned_type one of 1 then 
    l_not_eligable_premium2 *  l_current_unearned_factor_prior2 
else if 
l_unearned_type one of 2 then 
    l_not_eligable_premium2 * ((l_total_months_prior2 * 2) -1) divide 24
else
0/decimalplaces=2

define signed ascii number l_unearned_prior_eligable2 = if 
l_unearned_type one of 1 then 
    l_eligable_premium2 *  l_current_unearned_factor_prior2 
else if 
l_unearned_type one of 2 then 
    l_eligable_premium2 * ((l_total_months_prior2 * 2) -1) divide 24
else
0/decimalplaces=2

where 

/* TRANSACTED PRIOR TO START DATE WITH EFFECTIVE DATES WITHIN
   THE START DATE and THE END DATE */

((prsmaster_combined:trans_date < l_starting_date2a and
 prsmaster_combined:trans_eff => l_starting_date2a and
 prsmaster_combined:trans_eff <= l_ending_date) or

/* TRANSACTED WITHIN THE START DATE and THE END DATE WITH
   EFFECTIVE DATES NOT > THE l_ending_date */

(prsmaster_combined:trans_date => l_starting_date2a and
 prsmaster_combined:trans_date <= l_ending_date and
 prsmaster_combined:trans_eff <= l_ending_date))

and

prsmaster_combined:trans_eff <> prsmaster_combined:trans_exp

and

 prsmaster_combined:premium <> 0

and with prsmaster_combined:trans_code < 17
and with prsmaster_combined:agent_no = l_agent_no 

list
/nobanner
/title="Contingent Commissions Premium Audit Report"
/domain="prsmaster_combined"
/nodetail 

prsmaster_combined:agent_no /column=15
l_premium /mask="(ZZZ,ZZZ,ZZZ.99)"/column=50/heading="Written-Premium"
l_eligable_premium/mask="(ZZZ,ZZZ,ZZZ.99)"/column=70/heading="Eligable-Premium"
l_not_eligable_premium/mask="(ZZZ,ZZZ,ZZZ.99)"/column=90/heading="Ineligable-Premium"
l_unearned /mask="(ZZZ,ZZZ,ZZZ.99)"/column=110/heading="Unearned-Premium"
l_unearned_eligable  /mask="(ZZZ,ZZZ,ZZZ.99)"/column=130/heading="Unearned-Premium-Eligable"
l_unearned_not_eligable  /mask="(ZZZ,ZZZ,ZZZ.99)"/column=150/heading="Unearned-Premium-Ineligable"

l_premium1 /mask="(ZZZ,ZZZ,ZZZ.99)"/column=200/heading="Written-Premium"
l_eligable_premium1/mask="(ZZZ,ZZZ,ZZZ.99)"/column=220/heading="Eligable-Premium"
l_not_eligable_premium1/mask="(ZZZ,ZZZ,ZZZ.99)"/column=240/heading="Ineligable-Premium"
l_unearned_prior /mask="(ZZZ,ZZZ,ZZZ.99)"/column=260/heading="Unearned-Premium"
l_unearned_prior_eligable  /mask="(ZZZ,ZZZ,ZZZ.99)"/column=280/heading="Unearned-Premium-Eligable"
l_unearned_prior_not_eligable  /mask="(ZZZ,ZZZ,ZZZ.99)"/column=300/heading="Unearned-Premium-Ineligable"

l_premium2 /mask="(ZZZ,ZZZ,ZZZ.99)"/column=350/heading="Written-Premium"
l_eligable_premium2/mask="(ZZZ,ZZZ,ZZZ.99)"/column=370/heading="Eligable-Premium"
l_not_eligable_premium2/mask="(ZZZ,ZZZ,ZZZ.99)"/column=390/heading="Ineligable-Premium"
l_unearned_prior2 /mask="(ZZZ,ZZZ,ZZZ.99)"/column=410/heading="Unearned-Premium"
l_unearned_prior_eligable2  /mask="(ZZZ,ZZZ,ZZZ.99)"/column=430/heading="Unearned-Premium-Eligable"
l_unearned_prior_not_eligable2  /mask="(ZZZ,ZZZ,ZZZ.99)"/column=450/heading="Unearned-Premium-Ineligable"

sorted by sfsagent:agent_master_code/newlines 
          prsmaster_combined:agent_no prsmaster_combined:policy_no

top of sfsagent:agent_master_code 
box/noblanklines/noheadings
sfsagent:agent_master_code 
sfsagent:name[1]
xob

end of prsmaster_combined:agent_no 
box/noblanklines/noheadings 
prsmaster_combined:agent_no /column=15
total[l_premium]/column=50/mask="(ZZZ,ZZZ,ZZZ.99)"
total[l_eligable_premium]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=70
total[l_not_eligable_premium]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=90
total[l_unearned] /mask="(ZZZ,ZZZ,ZZZ.99)"/column=110
total[l_unearned_eligable]  /mask="(ZZZ,ZZZ,ZZZ.99)"/column=130
total[l_unearned_not_eligable]  /mask="(ZZZ,ZZZ,ZZZ.99)"/column=150

total[l_premium1]/column=200/mask="(ZZZ,ZZZ,ZZZ.99)"
total[l_eligable_premium1]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=220
total[l_not_eligable_premium1]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=240
total[l_unearned_prior ]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=260
total[l_unearned_prior_eligable]  /mask="(ZZZ,ZZZ,ZZZ.99)"/column=280
total[l_unearned_prior_not_eligable]  /mask="(ZZZ,ZZZ,ZZZ.99)"/column=300

total[l_premium2]/column=350/mask="(ZZZ,ZZZ,ZZZ.99)"
total[l_eligable_premium2]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=370
total[l_not_eligable_premium2]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=390
total[l_unearned_prior2] /mask="(ZZZ,ZZZ,ZZZ.99)"/column=410
total[l_unearned_prior_eligable2]  /mask="(ZZZ,ZZZ,ZZZ.99)"/column=430
total[l_unearned_prior_not_eligable2]  /mask="(ZZZ,ZZZ,ZZZ.99)"/column=450

xob

end of sfsagent:agent_master_code 
box/noblanklines/noheadings 
    "Total for Agent"
    total[l_premium]/column=50/mask="(ZZZ,ZZZ,ZZZ.99)"
    total[l_eligable_premium]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=70
    total[l_not_eligable_premium]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=90
    total[l_unearned] /mask="(ZZZ,ZZZ,ZZZ.99)"/column=110
    total[l_unearned_eligable]  /mask="(ZZZ,ZZZ,ZZZ.99)"/column=130
    total[l_unearned_not_eligable]  /mask="(ZZZ,ZZZ,ZZZ.99)"/column=150

    total[l_premium1]/column=200/mask="(ZZZ,ZZZ,ZZZ.99)"
    total[l_eligable_premium1]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=220
    total[l_not_eligable_premium1]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=240
    total[l_unearned_prior ]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=260
    total[l_unearned_prior_eligable]  /mask="(ZZZ,ZZZ,ZZZ.99)"/column=280
    total[l_unearned_prior_not_eligable]  /mask="(ZZZ,ZZZ,ZZZ.99)"/column=300

    total[l_premium2]/column=350/mask="(ZZZ,ZZZ,ZZZ.99)"
    total[l_eligable_premium2]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=370
    total[l_not_eligable_premium2]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=390
    total[l_unearned_prior2] /mask="(ZZZ,ZZZ,ZZZ.99)"/column=410
    total[l_unearned_prior_eligable2]  /mask="(ZZZ,ZZZ,ZZZ.99)"/column=430
    total[l_unearned_prior_not_eligable2]  /mask="(ZZZ,ZZZ,ZZZ.99)"/column=450

""/newline
    "Total Change from " + str(year(l_ending_date)) + " - " + str(year(l_ending_date1))
    Total[l_ELIgable_premium]-total[l_ELigable_premium1]/column=70
""/newline
    "Percent Change from " + str(year(l_ending_date)) + " - " + str(year(l_ending_date1))
    if total[l_ELigable_Premium1] <> 0 then 
    {
        ((Total[l_ELigable_premium]-total[l_ELigable_premium1]) divide total[l_ELigable_premium1]) * 100 /column=70/mask="(ZZZ.99%)"
    }
    else
    {
        100.00/column=50/mask="(ZZZ.99%)"
    }
    if total[l_eligable_premium] => l_minimum_premium and 
       ((Total[l_eligable_premium]-total[l_eligable_premium1]) divide total[l_eligable_premium1]) * 100 > 0.00 then 
    {
       "Premium is Eligable"/column=1
    }
    else
    {
       "Premium is Not Eligable"/column=1
    }

""/newline 
xob
top of page  
--L_prog_number                    /heading="Report No      "/column=1/newline 
enquiryname                        /heading="Report No      "/column=1/newline 
trun(sfscompany:name[1])/column=1/heading="Company Name   "/newline  
trun(str(l_starting_date,"MM/DD/YYYY") + " - " + str(l_ending_date,"MM/DD/YYYY"))/column=1/heading=
"Report Period  "/newline
""/newline
str(year(l_ending_date))+ " Activity" /column=100
str(year(l_ending_date1)) + " Activity"/column=265
str(year(l_ending_date2)) + " Activity"/column=390
