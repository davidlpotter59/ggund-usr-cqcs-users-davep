description This report will print the current claim activity, prior reserves and total change in reserves.  No data will print if ALL amounts are $0.00;

include "startend.inc"
define string l_prog_number = "Monthly Claims Audit Report - Reversion 7.20"

define signed ascii number l_prior_reserve = if lrsdetail:trans_date < l_starting_date then lrsdetail:loss_resv 
define signed ascii number l_current_reserve = if lrsdetail:trans_date <= l_ending_date then lrsdetail:loss_resv 

define signed ascii number l_indemnity_paid = if lrsdetail:trans_date => l_starting_date and 
                                                  lrsdetail:trans_date <= l_ending_date then lrsdetail:loss_paid 

define signed ascii number l_lae_paid       = if lrsdetail:trans_date => l_starting_date and 
                                                  lrsdetail:trans_date <= l_ending_date then lrsdetail:lae_paid 

where lrsdetail:trans_date <= l_ending_date 

list
/nobanner
/domain="lrsdetail"
/title="Claims Audit and Tracking- Bad Claim Numbers Only"
/nodetail 
/noreporttotals 

lrsdetail:claim_no/column=1
lrssetup:policy_no/column=20
lrssetup:loss_date /column=35
l_prior_reserve/column=50/heading="Prior Reserve-Amount"
l_current_reserve/column=70/heading="Current Reserve-Amount"
""/column=90/heading="Net Change-in Reserves"
l_indemnity_paid/column=110/heading="Current Indemnity-Paid"
l_lae_paid/column=130/heading="Current LAE-Paid"

sorted by lrsdetail:claim_no 

end of lrsdetail:claim_no 
box/noblanklines/noheadings 
if (total[l_prior_reserve] <> 0 or 
    total[l_current_reserve] <> 0 or
    total[l_indemnity_paid] <> 0 or 
    total[l_lae_paid] <> 0) and 
    lrssetup:policy_no = 0  then
{
    lrsdetail:claim_no/column=1
    lrssetup:policy_no/column=20
    lrssetup:loss_date /column=35
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
