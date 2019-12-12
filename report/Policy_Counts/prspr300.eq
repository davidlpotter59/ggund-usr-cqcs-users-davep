/* prspr300

   November 23, 2004

   scips.com, inc.

   inforce policy counts - summary - no policy detail 
*/

description  Inforce policy counts - summary - no policy detail ;

define wdate l_ending_date = parameter/prompt="Enter the ending date " default todaysdate 
define date l_starting_date = dateadd(l_ending_date,0,-1) + 1

define string l_prog_number = "PRSPR300 - Ver 4.10"

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

define signed ascii number l_cx_count = if l_cancel_premium <> 0 then 1 else 0
define signed ascii number l_rein_count = if l_reinstatement_premium <> 0 then 1 else 0
    
define signed ascii number l_count_new = if l_new_premium <> 0 then 1 else 0
define signed ascii number l_count_ren = if l_renewal_premium <> 0 then 1 else 0

define signed ascii number l_total_inforce_count =
l_count_new + l_count_ren + l_rein_count - l_cx_count 

/*if l_new_premium <> 0 or l_renewal_premium <> 0 then 1
else if l_cancel_premium <> 0 and l_reinstatement_premium <> 0 then 0
else if l_cancel_premium <> 0 and l_reinstatement_premium = 0 then -1
else if l_cancel_premium = 0 and l_reinstatement_premium <> 0 then 1
else 0
*/
                    
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

list
/nobanner
/domain="policy_counts"
/nodetail 
--/pagewidth=255
--/wks="policy counts"

""/column=1/heading="Count"
""/column=8/heading="Inforce-Count"
line_of_business /column=15
l_new_premium /column=40/heading="New-Premium"/mask="ZZZ,ZZZ,ZZZ.99-"
l_cancel_premium /column=60/heading="Cancel-Premium"/mask="ZZZ,ZZZ,ZZZ.99-"
l_increase_premium /column=80/heading="Increase-Premium"/mask="ZZZ,ZZZ,ZZZ.99-"
l_decrease_premium/column=100/heading="Decrease-Premium"/mask="ZZZ,ZZZ,ZZZ.99-"
l_renewal_premium /column=120/heading="Renewal-Premium"/mask="ZZZ,ZZZ,ZZZ.99-"
l_reinstatement_premium /column=140/heading="Reinstatement-Premium"/mask="ZZZ,ZZZ,ZZZ.99-"
l_total_premium/column=160/heading="Total-Written-Premium"/mask="ZZZ,ZZZ,ZZZ.99-"
l_total_net_inforce_premium/column=180/heading="Total-Inforce-Premium"/mask="ZZZ,ZZZ,ZZZ.99-"
l_total_end_premium_not_used/column=200
    /heading="Omitted-Endorsement-Premium"/mask="ZZZ,ZZZ,ZZZ.99-"
l_total_cancel_premium_not_used/column=220
    /heading="Omitted-CX-Premium"/mask="ZZZ,ZZZ,ZZZ.99-"

sorted by policy_counts:line_of_business 

end of line_of_business 
box/noheadings 
    count[policy_counts:policy_no]/column=1/mask="ZZ,ZZZ"
    "/"/column=7
    total[l_total_inforce_count]/column=8/mask="ZZ,ZZZ"
    policy_counts:line_of_business /column=15
    total[l_new_premium]/column=40/mask="ZZZ,ZZZ,ZZZ.99-"
    total[l_cancel_premium]/column=60/mask="ZZZ,ZZZ,ZZZ.99-"
    total[l_increase_premium]/column=80/mask="ZZZ,ZZZ,ZZZ.99-"
    total[l_decrease_premium]/column=100/mask="ZZZ,ZZZ,ZZZ.99-"
    total[l_renewal_premium]/column=120/mask="ZZZ,ZZZ,ZZZ.99-"
    total[l_reinstatement_premium]/column=140/mask="ZZZ,ZZZ,ZZZ.99-"
    total[l_total_premium]/column=160/mask="ZZZ,ZZZ,ZZZ.99-"
    total[l_total_net_inforce_premium]/column=180/mask="ZZZ,ZZZ,ZZZ.99-"
    total[l_total_end_premium_not_used] /column=200/mask="ZZZ,ZZZ,ZZZ.99-"
    total[l_total_cancel_premium_not_used]/column=220/mask="ZZZ,ZZZ,ZZZ.99-"
end box

end of report
box
  ""/newline=2
  total[l_count_new] /heading="New Count          " /newline 
  total[l_count_ren] /heading="Renewal Count      "/newline 
  total[l_rein_count]/heading="Reinstatement Count"/newline 
  total[l_cx_count]  /heading="Cancellation Count "/newline  
end box

include "reporttop.inc"
