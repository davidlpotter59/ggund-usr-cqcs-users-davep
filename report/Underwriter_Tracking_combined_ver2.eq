/*  SCIPS.com, INC.

    Underwriter_Tracking

    September 13, 2014

    Tracks current and prior year written as well as earned to incurred for the current period
    sorted by Underwriter and agent number
*/

Description 
Tracks current and prior year written as well as earned to incurred for the current period sorted by Underwriter and agent number;

define wdate l_ending_date = parameter/prompt="Enter AS of Date"

define unsigned ascii number l_incurred_option = parameter/prompt=
"Enter Ratio Type:<NL>1 - No LAE<NL>2 - Including LAE(Paid and Reserve)"
error "Option must be either 1 or 2" if l_incurred_option not one of 1,2

define wdate l_starting_date =  dateadd(01.01.0000,00,year(l_ending_date))

define wdate l_ending_date1 = dateadd(l_ending_date,0,-1)
define wdate l_starting_date1 = dateadd(l_starting_date,0,-1)

define string L_prog_number ="Underwriter Tracking Combined "

define unsigned ascii number l_multiplier[3]=100/decimalplaces=0

define signed ascii number l_current_written = if 
      prspremloss_combined:start_date_yyyy = year(l_starting_date) and
      prspremloss_combined:start_date_mm   = month(l_starting_date) and
      prspremloss_combined:end_date_yyyy   = year(l_ending_date) and
      prspremloss_combined:end_date_mm     = month(l_ending_date) then prspremloss_combined:written_premium else 0

define signed ascii number l_current_uearned = if 
      prspremloss_combined:start_date_yyyy = year(l_starting_date) and
      prspremloss_combined:start_date_mm   = month(l_starting_date) and
      prspremloss_combined:end_date_yyyy   = year(l_ending_date) and
      prspremloss_combined:end_date_mm     = month(l_ending_date) then prspremloss_combined:unearned_premium_current else 0

define signed ascii number l_prior_uearned = if 
      prspremloss_combined:start_date_yyyy = year(l_starting_date) and
      prspremloss_combined:start_date_mm   = month(l_starting_date) and
      prspremloss_combined:end_date_yyyy   = year(l_ending_date) and
      prspremloss_combined:end_date_mm     = month(l_ending_date) then prspremloss_combined:unearned_premium_prior else 0

define signed ascii number l_current_earned = l_prior_uearned + l_current_written - l_current_uearned 

define signed ascii number l_incurred = if 
      prspremloss_combined:start_date_yyyy = year(l_starting_date) and
      prspremloss_combined:start_date_mm   = month(l_starting_date) and
      prspremloss_combined:end_date_yyyy   = year(l_ending_date) and
      prspremloss_combined:end_date_mm     = month(l_ending_date) then prspremloss_combined:loss_reserve_current + 
      prspremloss_combined:loss_paid_current - prspremloss_combined:loss_reserve_prior

define signed ascii number l_current_lae_reserve = if 
      prspremloss_combined:start_date_yyyy = year(l_starting_date) and
      prspremloss_combined:start_date_mm   = month(l_starting_date) and
      prspremloss_combined:end_date_yyyy   = year(l_ending_date) and
      prspremloss_combined:end_date_mm     = month(l_ending_date) then
      (prspremloss_combined:alae_reserve_current + prspremloss_combined:ulae_reserve_current) -
      (prspremloss_combined:alae_reserve_prior   + prspremloss_combined:ulae_reserve_prior)

define signed ascii number l_current_lae_paid = if 
      prspremloss_combined:start_date_yyyy = year(l_starting_date) and
      prspremloss_combined:start_date_mm   = month(l_starting_date) and
      prspremloss_combined:end_date_yyyy   = year(l_ending_date) and
      prspremloss_combined:end_date_mm     = month(l_ending_date) then
      (prspremloss_combined:alae_paid_current + prspremloss_combined:ulae_paid_current)

define signed ascii number l_incurred_lae = if
      prspremloss_combined:start_date_yyyy = year(l_starting_date) and
      prspremloss_combined:start_date_mm   = month(l_starting_date) and
      prspremloss_combined:end_date_yyyy   = year(l_ending_date) and
      prspremloss_combined:end_date_mm     = month(l_ending_date) then l_current_lae_paid + l_current_lae_reserve 



/*(prspremloss_combined:alae_reserve_current + 
      prspremloss_combined:alae_paid_current - prspremloss_combined:alae_reserve_prior) +
      (prspremloss_combined:ulae_reserve_current + prspremloss_combined:ulae_paid_current - prspremloss_combined:ulae_reserve_prior)
*/
 

define signed ascii number l_prior_written = if 
      prspremloss_combined:start_date_yyyy = year(l_starting_date1) and
      prspremloss_combined:start_date_mm   = month(l_starting_date1) and
      prspremloss_combined:end_date_yyyy   = year(l_ending_date1) and
      prspremloss_combined:end_date_mm     = month(l_ending_date1) then prspremloss_combined:written_premium else 0

define signed ascii number l_incurred_total = l_incurred + l_incurred_lae 

define signed ascii number l_incurred_ratio = if l_incurred_option = 1 then
l_current_earned divide l_incurred
else
l_current_earned divide l_incurred_total 


define file sfsagenta = access sfsagent, set sfsagent:company_id= prspremloss_combined:company_id, 
                                             sfsagent:agent_no  = prspremloss_combined:agent_no 

define file sfscomuna = access sfscomun, set sfscomun:company_id= sfsagenta:company_id, 
                                             sfscomun:commercial_underwriter= sfsagenta:commercial_underwriter 

where 
--  getting current data
     ((prspremloss_combined:start_date_yyyy = year(l_starting_date) and
      prspremloss_combined:start_date_mm   = month(l_starting_date) and
      prspremloss_combined:end_date_yyyy   = year(l_ending_date) and
      prspremloss_combined:end_date_mm     = month(l_ending_date))
--  getting prior data
or
     (prspremloss_combined:start_date_yyyy = year(l_starting_date1) and
      prspremloss_combined:start_date_mm   = month(l_starting_date1) and
      prspremloss_combined:end_date_yyyy   = year(l_ending_date1) and
      prspremloss_combined:end_date_mm     = month(l_ending_date1)))

-- use this for testing and balancing 
-- and prspremloss_combined:underwriter one of 20 
and prspremloss_combined:agent_no one of 103, 135

list
/nobanner
/domain="prspremloss_combined"
/nodetail
/title="Underwriter Tracking Report - Combined"
/noreporttotals 

prspremloss_combined:agent_no /column=1
sfsagenta:commercial_underwriter/column=10 --prspremloss_combined:underwriter /column=10
sfsagent:name[1]/column=30/heading="Agent"
l_prior_written   /column=70/heading="Prior-Written Premium"
l_current_written /column=90/heading="Current-Written Premium"
""/column=110/heading="Difference"
""/column=130/heading="Percent Change"
l_current_earned/column=150/heading="Current-Earned Premium"
l_incurred/column=170/heading="Current-Loss Incurred"
l_incurred_lae/column=190/heading="Current-LAE Incurred"
l_incurred_total/column=210/heading="Current-Combined Incurred"
l_incurred_ratio/column=230/heading="Current-Loss Ratio"
l_current_lae_paid 
l_current_lae_reserve 

sorted by sfsagenta:commercial_underwriter /newpage 
          prspremloss_combined:agent_no 

end of prspremloss_combined:agent_no 
box/noblanklines/noheadings 
  prspremloss_combined:agent_no /column=1
  str(sfsagenta:commercial_underwriter) + " " +sfscomuna:name/column=10
  sfsagent:name[1]/column=30
  total[l_prior_written] /column=70/mask="(ZZZ,ZZZ,ZZZ.99)"
  total[l_current_written] /column=90/mask="(ZZZ,ZZZ,ZZZ.99)"
  total[l_current_written] - total[l_prior_written]/column=110/mask="(ZZZ,ZZZ,ZZZ.99)"
  round((((total[l_current_written] - total[l_prior_written]) divide 
    total[l_prior_written]) * 100),4) /column=130/mask="(ZZZ,ZZZ,ZZZ.99)"
  total[l_current_earned]/column=150/mask="(ZZZ,ZZZ,ZZZ.99)"
  total[l_incurred]/column=170/mask="(ZZZ,ZZZ,ZZZ.99)"
  total[l_incurred_lae]/column=190/mask="(ZZZ,ZZZ,ZZZ.99)"
  total[l_incurred_total]/column=210/mask="(ZZZ,ZZZ,ZZZ.99)"

  if l_incurred_option = 1 then
  {  
    (total[l_incurred] divide
    total[l_current_earned])  * l_multiplier /mask="ZZZ,ZZZ.ZZZ-"
  }
  else
  {  
    (total[l_incurred_total] divide
    total[l_current_earned]) * l_multiplier /noheading/column=230/mask="ZZZ,ZZZ.ZZZ-"
  }
  "%"/width=1
total[l_current_lae_paid]
total[l_current_lae_reserve]

end box

end of sfsagenta:commercial_underwriter 
box/noheadings 
  ""/newline 
  "Underwriter Totals"/column=1
  str(sfsagenta:commercial_underwriter) + " " + sfscomuna:name/column=30
  total[l_prior_written] /column=70/mask="(ZZZ,ZZZ,ZZZ.99)"
  total[l_current_written] /column=90/mask="(ZZZ,ZZZ,ZZZ.99)"
  total[l_current_written] - total[l_prior_written]/column=110/mask="(ZZZ,ZZZ,ZZZ.99)"
  round((((total[l_current_written] - total[l_prior_written]) divide 
    total[l_prior_written]) * 100),4) /column=130/mask="(ZZZ,ZZZ,ZZZ.99)"
  total[l_current_earned]/column=150/mask="(ZZZ,ZZZ,ZZZ.99)"
  total[l_incurred]/column=170/mask="(ZZZ,ZZZ,ZZZ.99)"
  total[l_incurred_lae]/column=190/mask="(ZZZ,ZZZ,ZZZ.99)"
  total[l_incurred_total]/column=210/mask="(ZZZ,ZZZ,ZZZ.99)"

  if l_incurred_option = 1 then
  {  
    (total[l_incurred] divide
    total[l_current_earned])  * l_multiplier /mask="ZZZ,ZZZ.ZZZ-"
  }
  else
  {  
    (total[l_incurred_total] divide
    total[l_current_earned]) * l_multiplier /noheading/column=230/mask="ZZZ,ZZZ.ZZZ-"
  }
  "%"/width=1

total[l_current_lae_paid]
total[l_current_lae_reserve]

end box

top of page  
l_prog_number                      /heading="Report No      "/column=1/newline 
trun(sfscompany:name[1])                                                                  /heading="Company Name   "/left
/column=1/newline  
trun(str(l_starting_date,"MM/DD/YYYY") + " - " + str(l_ending_date,"MM/DD/YYYY"))/column=1/heading="Report Period  "/left
/newline
l_starting_date 
l_ending_date 
l_starting_date1 
l_ending_date1

end of Report
box/noblanklines/noheadings 
  ""/newline 
  "Company Totals"/column=10
  total[l_prior_written] /column=70/mask="(ZZZ,ZZZ,ZZZ.99)"
  total[l_current_written] /column=90/mask="(ZZZ,ZZZ,ZZZ.99)"
  total[l_current_written] - total[l_prior_written]/column=110/mask="(ZZZ,ZZZ,ZZZ.99)"
  round((((total[l_current_written] - total[l_prior_written]) divide 
    total[l_prior_written]) * 100),4) /column=130/mask="(ZZZ,ZZZ,ZZZ.99)"
  total[l_current_earned]/column=150/mask="(ZZZ,ZZZ,ZZZ.99)"
  total[l_incurred]/column=170/mask="(ZZZ,ZZZ,ZZZ.99)"
  total[l_incurred_lae]/column=190/mask="(ZZZ,ZZZ,ZZZ.99)"
  total[l_incurred_total]/column=210/mask="(ZZZ,ZZZ,ZZZ.99)"

  if l_incurred_option = 1 then
  {  
    (total[l_incurred] divide
    total[l_current_earned])  * l_multiplier /mask="ZZZ,ZZZ.ZZZ-"
  }
  else
  {  
    (total[l_incurred_total] divide
    total[l_current_earned]) * l_multiplier /noheading/column=230/mask="ZZZ,ZZZ.ZZZ-"
  }
  "%"/width=1

end box