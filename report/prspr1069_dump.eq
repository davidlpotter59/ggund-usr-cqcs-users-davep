/*  prspr1060

    SCIPS.com

    July 14, 2002

    Earned to Incurred Report by Agent and Line of Business 
*/

description * Updated - Earned to Incurred Report by Agent and Line of Business - Select LAE or No LAE in Incurred Number ;

include "startend.inc"
define string l_prog_number = "PRSPR1069 - Version 7.22"

define signed ascii number l_prior_direct_unearned = prspremloss:unearned_premium_prior 
define signed ascii number l_current_premium       = prspremloss:written_premium 
define signed ascii number l_direct_unearned       = prspremloss:unearned_premium_current 

define signed ascii number l_direct_earned = 
(l_prior_direct_unearned + l_current_premium) - l_direct_unearned 

define signed ascii number l_incurred = prspremloss:loss_reserve_current + 
prspremloss:loss_paid_current - prspremloss:loss_reserve_prior 

define signed ascii number l_incurred_lae = 
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
    
where (prspremloss:start_date_yyyy = year(l_starting_date) and
       prspremloss:start_date_mm   = month(l_starting_date) and
       prspremloss:end_date_yyyy   = year(l_ending_date) and
       prspremloss:end_date_mm     = month(l_ending_date) and
       prspremloss:agent_no        > 0)

--and sfsline:stmt_lob  <> 999
and prspremloss:line_of_business = 0

list
/nobanner
/domain="prspremloss"
/title="Earned to Incurred Report by Line of Business - No Detail (Summary Only)"
--/nodetail                            
/nototals

prspremloss:claim_no policy_no line_of_business lob_subline 
--sfsagent:name[1]
l_prior_direct_unearned/column=60/heading="Prior Unearned-Premium"
l_current_premium/column=75/heading="Written-Premium" 
l_direct_unearned/column=90/heading="Unearned-Premium"   
l_direct_earned/column=105/heading="Earned-Premium" 
l_incurred/column=120/heading="Incurred-Losses" 
l_incurred_lae/column=135/heading="Incurred-LAE" 
l_incurred_total/column=150/heading="Total-Incurred" 
l_incurred_ratio/column=165/heading="Earned to-Incurred Percent"
--lrssetup:claim_no 
              
sorted by -- prspremloss:agent_no/newline
          prspremloss:line_of_business
--          prsmaster:lob_subline


/*top of prspremloss:line_of_business*/

end of prspremloss:line_of_business 
prspremloss:line_of_business/noheading /column=5
sfsline_heading:description/noheading/column=10                                
total[l_prior_direct_unearned,prspremloss:line_of_business]/noheading/column=60
total[l_current_premium,prspremloss:line_of_business]/noheading/column=75
total[l_direct_unearned,prspremloss:line_of_business]/noheading/column=90 
total[l_direct_earned,prspremloss:line_of_business]/noheading/column=105
total[l_incurred,prspremloss:line_of_business]/noheading/column=120
total[l_incurred_lae,prspremloss:line_of_business]/noheading/column=135
total[l_incurred_total,prspremloss:line_of_business]/noheading/column=150
if l_incurred_option = 1 then
{ 
   total[l_incurred,prspremloss:line_of_business] divide 
   total[l_direct_earned,prspremloss:line_of_business] * l_multiplier  /mask=
"ZZZ,ZZZ.ZZZ-"
 
}
else
{ 
   total[l_incurred_total,prspremloss:line_of_business] divide 
   total[l_direct_earned,prspremloss:line_of_business] * l_multiplier 
/noheading/column=165/mask="ZZZ,ZZZ.ZZZ-" 
}                        
"%"/width=1

end of report                
""/newline=2
"Report Totals"/column=1
total[l_prior_direct_unearned]/noheading/column=60
total[l_current_premium]/noheading/column=75
total[l_direct_unearned]/noheading/column=90 
total[l_direct_earned]/noheading/column=105
total[l_incurred]/noheading/column=120 
total[l_incurred_lae]/noheading/column=135
total[l_incurred_total]/noheading/column=150
if l_incurred_option = 1 then
{ 
   total[l_incurred] divide 
   total[l_direct_earned] * l_multiplier  /mask="ZZZ,ZZZ.ZZZ-"
 
}
else
{ 
   total[l_incurred_total] divide 
   total[l_direct_earned] * l_multiplier /noheading/column=165/mask="ZZZ,ZZZ.ZZZ-" 

}

include "reporttop.inc"
if l_incurred_option =1 then
{ 
    "No LAE Calculated in the Incurred"/centre/newline=2
}
else
{
    "LAE is Included in the Incurred"/center/newline=2
}
