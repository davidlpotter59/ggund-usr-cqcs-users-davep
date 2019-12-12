
description 
This report will print the current claim activity, prior reserves and total change in reserves.  No data will print if ALL amounts are $0.00;

include "startend.inc"
define string l_prog_number = "Monthly Claims Audit Report - Reversion 7.20"

define signed ascii number l_prior_reserve = if lrsdetail_combined:trans_date < l_starting_date then lrsdetail_combined:loss_resv 
define signed ascii number l_current_reserve = if lrsdetail_combined:trans_date <= l_ending_date then lrsdetail_combined:loss_resv 

define signed ascii number l_indemnity_paid = if lrsdetail_combined:trans_date => l_starting_date and 
                                                  lrsdetail_combined:trans_date <= l_ending_date then lrsdetail_combined:loss_paid 

define signed ascii number l_lae_paid       = if lrsdetail_combined:trans_date => l_starting_date and 
                                                  lrsdetail_combined:trans_date <= l_ending_date then lrsdetail_combined:lae_paid 

where lrsdetail_combined:trans_date <= l_ending_date 


list
/nobanner
/domain="lrsdetail_combined"
/title="Claims Audit and Tracking"
/nodetail 
/noreporttotals 

lrsdetail_combined:claim_no/column=1
lrssetup_combined:policy_no/column=20
lrssetup_combined:loss_date /column=35
l_prior_reserve/column=50/heading="Prior Reserve-Amount"
l_current_reserve/column=70/heading="Current Reserve-Amount"
""/column=90/heading="Net Change-in Reserves"
l_indemnity_paid/column=110/heading="Current Indemnity-Paid"
l_lae_paid/column=130/heading="Current LAE-Paid"

sorted by lrsdetail_combined:claim_no 

end of lrsdetail_combined:claim_no 
box/noblanklines/noheadings 
if total[l_prior_reserve] <> 0 or 
    total[l_current_reserve] <> 0 or
    total[l_indemnity_paid] <> 0 or 
    total[l_lae_paid] <> 0 then
{
    lrsdetail_combined:claim_no/column=1
    lrssetup_combined:policy_no/column=20
    lrssetup_combined:loss_date /column=35
    total[l_prior_reserve]/column=50
    total[l_current_reserve]/column=70
    total[l_current_reserve] - total[l_prior_reserve]/column=90
    total[l_indemnity_paid]/column=110
    total[l_lae_paid]/column=130
}
xob

include "reporttop.inc"

end of report
""/newline
"Report Totals"
    total[l_prior_reserve]/column=50
    total[l_current_reserve]/column=70
    total[l_current_reserve] - total[l_prior_reserve]/column=90
    total[l_indemnity_paid]/column=110
    total[l_lae_paid]/column=130
