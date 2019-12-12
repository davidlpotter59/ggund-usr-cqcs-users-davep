/* prspr300d

   November 23, 2004

   scips.com, inc.

   inforce policy counts - summary - no policy detail 
*/

description  Inforce policy counts - summary - no policy detail ;

include "startend.inc"

define string l_prog_number = "PRSPR300D - Ver 4.10"

define file sfsagenta   = access sfsagent, 
set sfsagent:company_id =  policy_counts:company_id, 
    sfsagent:agent_no   =  policy_counts:agent_no 

define signed ascii number l_new_premium =
val(policy_counts:new_premium)

define signed ascii number l_cancel_premium =
val(policy_counts:cancel_premium)

define signed ascii number l_increase_premium =
val(policy_counts:increase_premium)

define signed ascii number l_decrease_premium =
val(policy_counts:decrease_premium)

define signed ascii number l_renewal_premium =
val(policy_counts:renewal_premium)

define signed ascii number l_reinstatement_premium =
val(policy_counts:reinstatement_premium)

define signed ascii number l_total_premium = 
l_new_premium + l_cancel_premium + l_increase_premium +
l_decrease_premium + l_renewal_premium + l_reinstatement_premium 

define signed ascii number l_total_inforce_count =
if l_new_premium <> 0 or l_renewal_premium <> 0 then 1
else if l_cancel_premium <> 0 and l_reinstatement_premium <> 0 then 0
else if l_cancel_premium <> 0 and l_reinstatement_premium = 0 then -1
else if l_cancel_premium = 0 and l_reinstatement_premium <> 0 then 1
else 0
                    
define signed ascii number l_total_new_renewal = if l_new_premium <> 0 or
                                                    l_renewal_premium <> 0 then
                                                     1
                                                 else
                                                     0    

define signed ascii number l_total_new = if l_new_premium <> 0 then 
                                             1
                                         else
                                             0    

define signed ascii number l_total_renewal = if l_renewal_premium <> 0 then 
                                                 1
                                             else
                                                 0    

define signed ascii number l_total_cancel = if l_cancel_premium <> 0 then 
                                                     -1
                                                 else
                                                     0    

define signed ascii number l_total_reinstate = if l_reinstatement_premium <> 0 then 
                                                     1
                                                 else
                                                     0    

define signed ascii number l_inforce2 = l_total_new +
                                        l_total_renewal +
                                        l_total_cancel +
                                        l_total_reinstate

define signed ascii number l_total_end_premium = 
l_increase_premium + l_decrease_premium 

define signed ascii number l_total_inforce_end_premium =
if l_new_premium <> 0 or l_renewal_premium <> 0 then 
l_total_end_premium               
else 0.00

define signed ascii number l_total_end_premium_not_used =
l_total_end_premium - l_total_inforce_end_premium 
                 
define signed ascii number l_total_inforce_cancel_premium =
l_cancel_premium - l_reinstatement_premium 

define signed ascii number l_total_inforce_rein_premium =
l_reinstatement_premium 
         
define signed ascii number l_total_cancel_premium_not_used =
l_cancel_premium - l_total_inforce_cancel_premium 

define signed ascii number l_total_inforce_premium =
l_new_premium + l_renewal_premium

define signed ascii number l_total_net_inforce_premium = l_total_inforce_premium 
+ l_total_inforce_cancel_premium + l_total_inforce_end_premium 
+ l_total_inforce_rein_premium 

define file sfpcurrenta = access sfpcurrent, set 
sfpcurrent:policy_no= policy_counts:policy_no 

define unsigned ascii number l_year[4] = year(policy_counts:eff_date)

define file sfpnamea = access sfpname, set 
sfpname:policy_no= policy_counts:policy_no, 
sfpname:pol_year= l_year, 
sfpname:end_sequence= policy_counts:end_sequence 

-- where policy_counts:line_of_business one of 1

list
/nobanner
/domain="policy_counts"
/pagelength=0

policy_counts:policy_no/column=1
sfpnamea:name[1,1,20]
policy_counts:eff_date/heading="Effective"
policy_counts:exp_date/heading="Expiration"
policy_counts:line_of_business /heading="LOB"
Policy_counts:agent_no /heading="Agent"
policy_counts:end_sequence /heading="End Seq"
l_new_premium /column=100/heading="New-Premium"/mask="ZZZ,ZZZ,ZZZ.99-"
l_cancel_premium /column=120/heading="Cancel-Premium"/mask="ZZZ,ZZZ,ZZZ.99-"
l_increase_premium /column=140/heading="Increase-Premium"/mask="ZZZ,ZZZ,ZZZ.99-"
l_decrease_premium/column=160/heading="Decrease-Premium"/mask="ZZZ,ZZZ,ZZZ.99-"
l_renewal_premium /column=180/heading="Renewal-Premium"/mask="ZZZ,ZZZ,ZZZ.99-"
l_reinstatement_premium /column=200/heading="Reinstatement-Premium"/mask="ZZZ,ZZZ,ZZZ.99-"
l_total_premium/column=220/heading="Total-Written-Premium"/mask="ZZZ,ZZZ,ZZZ.99-"
l_total_net_inforce_premium/column=240/heading="Total-Inforce-Premium"/mask="ZZZ,ZZZ,ZZZ.99-"
l_total_end_premium_not_used/column=260
    /heading="Omitted-Endorsement-Premium"/mask="ZZZ,ZZZ,ZZZ.99-"
l_total_cancel_premium_not_used/column=280
    /heading="Omitted-CX-Premium"/mask="ZZZ,ZZZ,ZZZ.99-"
L_total_new/column=300/heading="New-Totals"/mask="ZZZ,ZZZ,ZZZ-"
L_total_renewal/column=320/heading="Renewal-Totals"/mask="ZZZ,ZZZ,ZZZ-"
l_total_cancel/column=340/heading="Cancel-Totals"/mask="ZZZ,ZZZ,ZZZ-"
l_total_reinstate/column=360/heading="Reinstate-Totals"/mask="ZZZ,ZZZ,ZZZ-" 

sorted by  policy_counts:line_of_business /newlines=2
           policy_counts:policy_no 

end of line_of_business 
box/noheadings 
    count[policy_counts:policy_no]/column=1/mask="ZZ,ZZZ"
    "/"/column=7
    total[l_inforce2]/column=8/mask="ZZ,ZZZ"
    policy_counts:line_of_business 
    total[l_new_premium]/mask="ZZZ,ZZZ,ZZZ.99-"/align=l_new_premium
    total[l_cancel_premium]/mask="ZZZ,ZZZ,ZZZ.99-"/align=l_cancel_premium
    total[l_increase_premium]/mask="ZZZ,ZZZ,ZZZ.99-"/align=l_increase_premium
    total[l_decrease_premium]/mask="ZZZ,ZZZ,ZZZ.99-"/align=l_decrease_premium
    total[l_renewal_premium]/mask="ZZZ,ZZZ,ZZZ.99-"/align=l_renewal_premium
    total[l_reinstatement_premium]/mask="ZZZ,ZZZ,ZZZ.99-"/align=l_reinstatement_premium
    total[l_total_premium]/mask="ZZZ,ZZZ,ZZZ.99-"/align=l_total_premium
    total[l_total_net_inforce_premium]/mask="ZZZ,ZZZ,ZZZ.99-"/align=l_total_net_inforce_premium
    total[l_total_end_premium_not_used]/mask="ZZZ,ZZZ,ZZZ.99-"/align=l_total_end_premium_not_used
    total[l_total_cancel_premium_not_used]/column=220/mask="ZZZ,ZZZ,ZZZ.99-"/align=l_total_cancel_premium_not_used
    total[l_total_new]/align=l_total_new/mask="ZZZ,ZZZ,ZZZ-" 
    total[l_total_renewal]/align=l_total_renewal/mask="ZZZ,ZZZ,ZZZ-" 
    total[l_total_cancel]/align=l_total_cancel/mask="ZZZ,ZZZ,ZZZ-"
    total[l_total_reinstate]/align=l_total_reinstate /mask="ZZZ,ZZZ,ZZZ-"
end box

top of page  
L_prog_number                    /heading="Report No      "/column=1/newline 
trun(sfscompany:name[1])/column=1/heading="Company Name   "/newline  
trun(str(l_starting_date,"MM/DD/YYYY") + " - " + str(l_ending_date,"MM/DD/YYYY"))/column=1/heading=
"Report Period  "/newline
