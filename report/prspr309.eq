/* prspr300

   November 23, 2004

   scips.com, inc.

   inforce policy counts - summary - no policy detail 
*/

description  Inforce policy counts - summary - no policy detail - sorted by Commercial Underwriter ;

include "startend.inc"

define string l_prog_number = "PRSPR309 - Version 7"

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

define file sfscomuna = access sfscomun, set sfscomun:company_id= policy_counts:company_id,
                                             sfscomun:commercial_underwriter= sfsagenta:commercial_underwriter 

define string l_sfs[3]="SFS"

define file sfsdefaulta = access sfsdefault, set sfsdefault:sfs_code= l_sfs 
define string l_lob_subline[2]="00"

define file sfslinea = access sfsline, set sfsline:company_id       = sfsdefaulta:company_id, 
                                           sfsline:line_of_business = policy_counts:line_of_business,
                                           sfsline:lob_subline      = l_lob_subline 

list
/nobanner
/domain="policy_counts"
--/nodetail 
--/pagewidth=255
--/wks="policy counts"

""/heading="Count"/name="Policy_Count"
""/heading="Inforce-Count"/name="Inforce_Count"
policy_counts:policy_no/name="Policy_Number" 
policy_counts:line_of_business /heading="LOB"/name="LOB"
sfslinea:description/name="LOB_DESC"/duplicates 
l_new_premium /heading="New-Premium"/mask="ZZZ,ZZZ,ZZZ.99-"
l_cancel_premium /heading="Cancel-Premium"/mask="ZZZ,ZZZ,ZZZ.99-"
l_increase_premium /heading="Increase-Premium"/mask="ZZZ,ZZZ,ZZZ.99-"
l_decrease_premium/heading="Decrease-Premium"/mask="ZZZ,ZZZ,ZZZ.99-"
l_renewal_premium /heading="Renewal-Premium"/mask="ZZZ,ZZZ,ZZZ.99-"
l_reinstatement_premium /heading="Reinstatement-Premium"/mask="ZZZ,ZZZ,ZZZ.99-"
l_total_premium/heading="Total-Written-Premium"/mask="ZZZ,ZZZ,ZZZ.99-"
l_total_net_inforce_premium/heading="Total-Inforce-Premium"/mask="ZZZ,ZZZ,ZZZ.99-"
l_total_end_premium_not_used    /heading="Omitted-Endorsement-Premium"/mask="ZZZ,ZZZ,ZZZ.99-"
l_total_cancel_premium_not_used /heading="Omitted-CX-Premium"/mask="ZZZ,ZZZ,ZZZ.99-"

sorted by sfsagenta:commercial_underwriter/newpage 
          policy_counts:line_of_business /newlines 

end of line_of_business 
box/noheadings 
    ""/newline 
    count[policy_counts:policy_no]/align=Policy_count/mask="ZZ,ZZZ"
    "/"
    total[l_total_inforce_count]/align=Inforce_count/mask="ZZ,ZZZ"
    policy_counts:line_of_business/align=LOB
    total[l_new_premium]/align=l_new_premium /mask="ZZZ,ZZZ,ZZZ.99-"
    total[l_cancel_premium]/align=l_cancel_premium /mask="ZZZ,ZZZ,ZZZ.99-"
    total[l_increase_premium]/align=l_increase_premium /mask="ZZZ,ZZZ,ZZZ.99-"
    total[l_decrease_premium]/align=l_decrease_premium /mask="ZZZ,ZZZ,ZZZ.99-"
    total[l_renewal_premium]/align=l_renewal_premium /mask="ZZZ,ZZZ,ZZZ.99-"
    total[l_reinstatement_premium]/align=l_reinstatement_premium /mask="ZZZ,ZZZ,ZZZ.99-"
    total[l_total_premium]/align=l_total_premium /mask="ZZZ,ZZZ,ZZZ.99-"
    total[l_total_net_inforce_premium]/align=l_total_net_inforce_premium /mask="ZZZ,ZZZ,ZZZ.99-"
    total[l_total_end_premium_not_used] /align=l_total_end_premium_not_used /mask="ZZZ,ZZZ,ZZZ.99-"
    total[l_total_cancel_premium_not_used]/align=l_total_cancel_premium_not_used /mask="ZZZ,ZZZ,ZZZ.99-"
end box

end of sfsagenta:commercial_underwriter 
box/noheadings 
    ""/newline 
    count[policy_counts:policy_no]/align=Policy_count/mask="ZZ,ZZZ"
    "/"
    total[l_total_inforce_count]/align=Inforce_count/mask="ZZ,ZZZ"
    policy_counts:line_of_business/align=LOB
    total[l_new_premium]/align=l_new_premium /mask="ZZZ,ZZZ,ZZZ.99-"
    total[l_cancel_premium]/align=l_cancel_premium /mask="ZZZ,ZZZ,ZZZ.99-"
    total[l_increase_premium]/align=l_increase_premium /mask="ZZZ,ZZZ,ZZZ.99-"
    total[l_decrease_premium]/align=l_decrease_premium /mask="ZZZ,ZZZ,ZZZ.99-"
    total[l_renewal_premium]/align=l_renewal_premium /mask="ZZZ,ZZZ,ZZZ.99-"
    total[l_reinstatement_premium]/align=l_reinstatement_premium /mask="ZZZ,ZZZ,ZZZ.99-"
    total[l_total_premium]/align=l_total_premium /mask="ZZZ,ZZZ,ZZZ.99-"
    total[l_total_net_inforce_premium]/align=l_total_net_inforce_premium /mask="ZZZ,ZZZ,ZZZ.99-"
    total[l_total_end_premium_not_used] /align=l_total_end_premium_not_used /mask="ZZZ,ZZZ,ZZZ.99-"
    total[l_total_cancel_premium_not_used]/align=l_total_cancel_premium_not_used /mask="ZZZ,ZZZ,ZZZ.99-"
end box

include "reporttop.inc"
""/newline 
sfsagenta:commercial_underwriter 
sfscomuna:name /newline=2
