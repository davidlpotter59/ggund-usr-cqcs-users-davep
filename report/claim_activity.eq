description This report will print the current claim activity, prior reserves and total change in reserves.  No data will print if ALL amounts are $0.00;

include "startend.inc"
define string l_prog_number = "Claims Activity Report - Reversion 7.20"

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
/title="Claims Activity and Tracking"
/nodetail 
/noreporttotals 

lrsdetail:claim_no/column=1
lrssetup:policy_no/column=20
lrssetup:line_of_business/heading="LOB"/column=35
year(lrssetup:eff_date)/column=45/heading="Effective-Year"
lrssetup:loss_date /column=60
l_prior_reserve/column=80/heading="Prior Reserve-Amount"
l_current_reserve/column=100/heading="Current Reserve-Amount"
""/column=120/heading="Net Change-in Reserves"
l_indemnity_paid/column=140/heading="Current Indemnity-Paid"
l_lae_paid/column=160/heading="Current LAE-Paid"

sorted by lrsdetail:claim_no 

end of lrsdetail:claim_no 
box/noblanklines/noheadings 
if total[l_prior_reserve] <> 0 or 
    total[l_current_reserve] <> 0 or
    total[l_indemnity_paid] <> 0 or 
    total[l_lae_paid] <> 0 then
{
    lrsdetail:claim_no/column=1
    lrssetup:policy_no/column=20
    lrssetup:line_of_business/column=35
    year(lrssetup:eff_date)/column=45
    lrssetup:loss_date /column=60
    total[l_prior_reserve]/column=80
    total[l_current_reserve]/column=100
    total[l_current_reserve] - total[l_prior_reserve]/column=120
    total[l_indemnity_paid]/column=140
    total[l_lae_paid]/column=160

}
xob

include "reporttop.inc"

end of report
""/newline
"Report Totals"
    total[l_prior_reserve]/column=70
    total[l_current_reserve]/column=90
    total[l_current_reserve] - total[l_prior_reserve]/column=110
    total[l_indemnity_paid]/column=130
    total[l_lae_paid]/column=150
