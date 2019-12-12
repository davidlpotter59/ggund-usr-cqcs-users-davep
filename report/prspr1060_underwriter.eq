
/*  prspr1060_underwriter

    SCIPS.com

    July 14, 2002

    Earned to Incurred Report by Agent and Line of Business 
*/

description 
* Updated - Earned to Incurred Report by Agent and Line of Business - Select LAE or No LAE in Incurred Number - by Underwriter ;

include "startend.inc"
define string l_prog_number = "PRSPR1060_Underwriter - Version 7.22"

wdate l_prior_starting_date = dateadd(01.01.0000,00,year(l_starting_date)-1) 
-- this is to keep the logic the same for record selection
wdate l_prior_ending_date   = dateadd(01.01.0000,00,year(l_starting_date)) -1

/*
define wdate l_prior_starting_date = dateadd(l_starting_date,0,-1)
define wdate l_prior_ending_date   = dateadd(l_ending_date,0,-1)
*/

define signed ascii number l_prior_direct_unearned = if 
 prspremloss:start_date_yyyy = year(l_starting_date) and 
 prspremloss:start_date_mm   = month(l_starting_date) and 
 prspremloss:end_date_yyyy   = year(l_ending_date) and 
 prspremloss:end_date_mm     = month(l_ending_date) then 
    prspremloss:unearned_premium_prior 
else
    0.00

define signed ascii number l_current_premium       = if 
 prspremloss:start_date_yyyy = year(l_starting_date) and 
 prspremloss:start_date_mm   = month(l_starting_date) and 
 prspremloss:end_date_yyyy   = year(l_ending_date) and 
 prspremloss:end_date_mm     = month(l_ending_date) then 
    prspremloss:written_premium 
else
    0.00

define signed ascii number l_current_premium_prior = if 
 prspremloss:start_date_yyyy = year(l_prior_starting_date) and 
 prspremloss:start_date_mm   = month(l_prior_starting_date) and
 prspremloss:end_date_yyyy   = year(l_prior_ending_date) and 
 prspremloss:end_date_mm     = month(l_prior_ending_date) then
    prspremloss:written_premium 
else
    0.00

define signed ascii number l_direct_unearned       = if 
 prspremloss:start_date_yyyy = year(l_starting_date) and 
 prspremloss:start_date_mm   = month(l_starting_date) and 
 prspremloss:end_date_yyyy   = year(l_ending_date) and 
 prspremloss:end_date_mm     = month(l_ending_date) then 
    prspremloss:unearned_premium_current 
else
    0.00

define signed ascii number l_direct_earned = if 
 prspremloss:start_date_yyyy = year(l_starting_date) and 
 prspremloss:start_date_mm   = month(l_starting_date) and 
 prspremloss:end_date_yyyy   = year(l_ending_date) and 
 prspremloss:end_date_mm     = month(l_ending_date) then 
(l_prior_direct_unearned + l_current_premium) - l_direct_unearned 

define signed ascii number l_incurred = if 
 prspremloss:start_date_yyyy = year(l_starting_date) and 
 prspremloss:start_date_mm   = month(l_starting_date) and 
 prspremloss:end_date_yyyy   = year(l_ending_date) and 
 prspremloss:end_date_mm     = month(l_ending_date) then 
prspremloss:loss_reserve_current + 
prspremloss:loss_paid_current - prspremloss:loss_reserve_prior 

define signed ascii number l_incurred_lae = if 
 prspremloss:start_date_yyyy = year(l_starting_date) and 
 prspremloss:start_date_mm   = month(l_starting_date) and 
 prspremloss:end_date_yyyy   = year(l_ending_date) and 
 prspremloss:end_date_mm     = month(l_ending_date) then 
(prspremloss:alae_reserve_current + prspremloss:alae_paid_current - prspremloss:alae_reserve_prior) +
(prspremloss:ulae_reserve_current + prspremloss:ulae_paid_current - prspremloss:ulae_reserve_prior)

define signed ascii number l_incurred_total = l_incurred + l_incurred_lae 

define unsigned ascii number l_incurred_option = parameter/prompt="Enter Ratio Type:<NL>1 - No LAE<NL>2 - Including LAE(Paid and Reserve)"
error "Option must be either 1 or 2" if l_incurred_option not one of 1,2

define signed ascii number l_incurred_ratio = if l_incurred_option = 1 then
l_direct_earned divide l_incurred
else
l_direct_earned divide l_incurred_total 

define unsigned ascii number l_multiplier[3]=100/decimalplaces=0

define file sfpnamea = access sfpname, set sfpname:policy_no= prspremloss:policy_no, generic, one to many 

define string l_status = if sfpnamea:status_date => l_starting_date and 
                            sfpnamea:status_date <= l_ending_date then sfpname:status 
else "None"
    
define file sfscommuna  =  access sfscomun, set sfscomun:company_id= prspremloss:company_id, 
                                                sfscomun:commercial_underwriter= sfsagent:commercial_underwriter 

where ((prspremloss:start_date_yyyy = year(l_prior_starting_date) and
        prspremloss:start_date_mm   = month(l_prior_starting_date) and
        prspremloss:end_date_yyyy   = year(l_prior_ending_date) and 
        prspremloss:end_date_mm     = month(l_prior_ending_date)) or
       (prspremloss:start_date_yyyy = year(l_starting_date) and 
        prspremloss:start_date_mm   = month(l_starting_date) and       
        prspremloss:end_date_yyyy   = year(l_ending_date) and
        prspremloss:end_date_mm     = month(l_ending_date)))
--and
--       prspremloss:agent_no        > 0)
and 
       sfsline:stmt_lob  <> 999

list
/nobanner
/domain="prspremloss"
/title="Earned to Incurred Report by Agency - No Detail (Summary Only)"
/nodetail                            
/nototals

prspremloss:agent_no /column=1
sfsagent:name[1]/width=20/noheading
l_prior_direct_unearned/column=40/heading="Prior Unearned-Premium"
l_current_premium_prior/column=60/heading="Prior Year-Written Premium"
l_current_premium/column=80/heading="Written-Premium" 
l_current_premium - l_current_premium_prior/column=100/heading="Premium-Change"
l_direct_unearned/column=120/heading="Unearned-Premium"   
l_direct_earned/column=140/heading="Earned-Premium" 
l_incurred/column=160/heading="Incurred-Losses" 
l_incurred_lae/column=180/heading="Incurred-LAE" 
l_incurred_total/column=200/heading="Total-Incurred" 
l_incurred_ratio/column=220/heading="Earned to-Incurred Percent"
--lrssetup:claim_no 
              
sorted by sfsagent:commercial_underwriter/newlines  
          prspremloss:agent_no
--          prspremloss:line_of_business
--          prsmaster:lob_subline

top of sfsagent:commercial_underwriter 
sfscommuna:name /column=1/noheading 

end of sfsagent:commercial_underwriter  
box/noheadings           
"Total For Underwriter"/column=15
total[l_prior_direct_unearned]/column=40
total[l_current_premium_prior]/column=60
total[l_current_premium]/column=80 
total[l_current_premium] - total[l_current_premium_prior]/column=100
total[l_direct_unearned]/column=120 
total[l_direct_earned]/column=140
total[l_incurred]/column=160 
total[l_incurred_lae]/column=180
total[l_incurred_total]/column=200
if l_incurred_option = 1 then
{  
   total[l_incurred] divide
   total[l_direct_earned]  * l_multiplier /mask=
"ZZZ,ZZZ.ZZZ-"

}
else
{  total[l_incurred_total] divide
   total[l_direct_earned] * l_multiplier /noheading/column
=220  /mask="ZZZ,ZZZ.ZZZ-"
}
"%"/width=1
""/newline 
xob 

end of prspremloss:agent_no     
box/noheadings           
prspremloss:agent_no /column=1
sfsagent:name[1]/column=10/width=20
total[l_prior_direct_unearned]/column=40
total[l_current_premium_prior]/column=60
total[l_current_premium]/column=80 
total[l_current_premium] - total[l_current_premium_prior]/column=100
total[l_direct_unearned]/column=120 
total[l_direct_earned]/column=140
total[l_incurred]/column=160 
total[l_incurred_lae]/column=180
total[l_incurred_total]/column=200
if l_incurred_option = 1 then
{  
   total[l_incurred] divide
   total[l_direct_earned]  * l_multiplier /mask=
"ZZZ,ZZZ.ZZZ-"

}
else
{  total[l_incurred_total] divide
   total[l_direct_earned] * l_multiplier /noheading/column
=220  /mask="ZZZ,ZZZ.ZZZ-"
}
"%"/width=1
xob 

end of report                
""/newline=2
box/noheadings 
"Report Totals"/column=1
total[l_prior_direct_unearned]/column=40
total[l_current_premium_prior]/column=60
total[l_current_premium]/column=80
total[l_current_premium] - total[l_current_premium_prior]/column=100
total[l_direct_unearned]/column=120 
total[l_direct_earned]/column=140
total[l_incurred]/column=160 
total[l_incurred_lae]/column=180
total[l_incurred_total]/column=200
if l_incurred_option = 1 then
{ 
   total[l_incurred] divide 
   total[l_direct_earned] * l_multiplier  /mask="ZZZ,ZZZ.ZZZ-"
 
}
else
{ 
   total[l_incurred_total] divide 
   total[l_direct_earned] * l_multiplier/column=220/mask="ZZZ,ZZZ.ZZZ-" 

}
xob

include "reporttop.inc"

if l_incurred_option =1 then
{ 
    "No LAE Calculated in the Incurred"/centre/newline=2
}
else
{
    "LAE is Included in the Incurred"/center/newline=2
}
