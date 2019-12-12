/*  LRSPR531

    Losses by Claim Number - Direct

    Date Written : September 3, 2009

    SCIPS.com */

description 
Direct Incurred Losses By Claim Number - Version 7.22;
             
define string l_name[10] = lrssetup_combined:name[1]
Define String l_prog_number = "LRSPR531 - Rev 7.20"       

define string l_claim_no[11] = str(lrsdetail_combined:claim_no) + trun(sfsline_alias:claim_alpha)

/* LRS63CAL.INC

   INCLUDE FILE USED FOR CLAIM REPORT CALCULATIONS

   Date Written : November 7, 1992

   SCIPS.com

   PROGRAMS USED BY THIS INCLUDE FILE
        - LRSPR531, LRSPR631, LRSPR633, LRSPR634, LRSPR635, LRSPR636
        - LRSPR638, LRSPR641, LRSPR671, LRSPR881, LRSPR882, LRSPR891
*/

define wdate l_starting_date = parameter 
define wdate l_ending_date   = parameter 

define wdate l_prior_starting_date = 01.01.0000 
-- force the beginning of time

define wdate l_prior_ending_date = l_starting_date - 1 
-- one day before starting date

define string
        l_status[12] = switch(lrssetup_combined:status)
        case "O"                : "**OPEN    **"
        case "R"                : "**REOPENED**"
        case "C"                : "**CLOSED  **"

define signed ascii l_prior_resv[10]= if
    lrsdetail_combined:trans_date < l_starting_date then
    lrsdetail_combined:loss_resv/decimalplaces=2

define signed ascii l_prior_adj_resv[10]=if
    lrsdetail_combined:trans_date < l_starting_date then
    lrsdetail_combined:lae_resv/decimalplaces=2

define signed ascii l_curr_resv[10]= if
    lrsdetail_combined:trans_date <= l_ending_date then
    lrsdetail_combined:loss_resv/decimalplaces=2

define signed ascii l_curr_adj_resv[10]=if
    lrsdetail_combined:trans_date <= l_ending_date then
    lrsdetail_combined:lae_resv/decimalplaces=2

define signed ascii number l_loss_paid[10]=if
    lrsdetail_combined:trans_date => l_starting_date and
    lrsdetail_combined:trans_date <= l_ending_date then
    lrsdetail_combined:loss_paid/dec=2

define signed ascii number l_curr_adj_exp[10]=if
    lrsdetail_combined:trans_date => l_starting_date and
    lrsdetail_combined:trans_date <= l_ending_date then
    lrsdetail_combined:lae_paid/dec=2

define signed ascii number l_prior_resv_total[10]=
    l_prior_resv/decimalplaces=2

define signed ascii number l_incurred[10]=
    l_curr_resv + l_loss_paid - l_prior_resv_total

define signed ascii number l_incurred_lae[10]=
    l_curr_adj_resv + l_curr_adj_exp - l_prior_adj_resv

define signed ascii number l_incurred_total[10]=
    l_incurred + l_incurred_lae

/*  END OF FILE */


define string l_program_no = "LRSPR531_combined - Version 7.20"

/*  lrscollect.inc

    february 8, 1999

    SCIPS.com

    Replace lrscol1 - lrscol4, does not require select/collection= to run */

where  
 1 = 1
--and lrsdetail_combined:trans_code not one of 91,92,93,94,95,96,97,98,99
--and sfsline:stmt_lob <> 999 

and   lrsdetail_combined:trans_date <= l_ending_date and
      lrsdetail_combined:trans_code < 30 --and trans_code not one of 15 -- why was 15 being excluded from this run?

--and val(lrsdetail_combined:other_system_trans_code) <> 45
--and lrssetup_combined:agent_no  one of 262,263
--and sfsline2:exclude_from_contingent not one of 1
and sfsagent:agent_master_code one of 136, 252 
--and sfsline2:exclude_from_contingent = 0

list
/nobanner
/domain="lrsdetail_combined" 
/title="Direct Incurred Losses By Claim Number *"
--/pagewidth=220
/duplicates
/nodetail
/nopageheadings
/noreporttotals 

/*  LRS53PRT.INC

    DETAIL PRINTING FOR LRSPR53? REPORTS

    Date Written : October 5, 1993

    SCIPS.com

    PROGRAMS USED BY THIS INCLUDE FILE
        - LRSPR531, LRSPR532

                        change log

Date            Initial Change
====            ======= ======
2/27/95         dlp     changed include to place loss paid in a specified
                        column.  this problem was causing the report 
                        to truncate the last column of the report.
*/

box/duplicates 
l_claim_no/heading="Claim-No"/column=1
lrssetup_combined:policy_no/heading="Policy-No"/column=13
sfpname:eff_date/heading="Effective-Date"/column=25/duplicates 
lrssetup_combined:cause_of_loss/heading="Cause"/column=37/duplicates 
lrssetup_combined:cause_loss_subline/noheading/column=41
lrssetup_combined:loss_date/heading="Loss-Date"/column=45
lrsdetail_combined:line_of_business/heading="LOB-Subline"/column=57 
lrsdetail_combined:lob_subline/noheading/column=61
l_status/heading="Open/Closed"/width=12/column=64
l_loss_paid/heading="Period-Losses-Paid"/width=15/column=80
l_curr_adj_exp/heading="Period-LAE-Paid"/width=15/column=100
l_curr_resv/heading="Current-Loss-Reserves"/width=15/column=120
l_curr_adj_resv/heading="Current-LAE Reserves"/width=15/column=140
l_prior_resv/heading="Prior-Loss-Reserves"/width=15/column=160
l_prior_adj_resv/heading="Prior-LAE Reserves"/width=15/column=180
l_incurred/heading="Current Period-Incurred Losses-Without LAE"/width=15/column=200
l_incurred_lae/heading="Current Period-Incurred LAE"/width=15/column=220
l_incurred_total/heading="Current Period-Net Losses &-LAE Incurred"/width=15/column=240
end box
/*  END OF FILE  */


sorted by --sfsagent_combined:agent_master_code/newlines/total/heading="@"
          lrsdetail_combined:claim_no
          lrsdetail_combined:cause_of_loss 
          lrsdetail_combined:cause_loss_subline 

/*  LRS53CLM.INC

    CLAIM TOTAL INFORMATION FOR ALL LRSPR53? REPORTS

    Date Written : October 5, 1993

    SCIPS.com

    PROGRAMS USED BY THIS INCLUDE FILE
        - LRSPR531, LRSPR532
*/

end of lrsdetail_combined:claim_no 
l_claim_no/noheading
lrssetup_combined:policy_no/noheading/column=13
sfpname:eff_date/noheading/column=25
lrssetup_combined:cause_of_loss/noheading/column=37
lrssetup_combined:cause_loss_subline/noheading/column=41
lrssetup_combined:loss_date/noheading/column=45
lrsdetail_combined:line_of_business/noheading/column=57
lrsdetail_combined:lob_subline/noheading/column=61
l_status/noheading/width=12/column=64
total[l_loss_paid,lrsdetail_combined:claim_no]/noheading/align=l_loss_paid/column=80
total[l_curr_adj_exp,lrsdetail_combined:claim_no]/noheading/align=l_curr_adj_exp/column=100
total[l_curr_resv,lrsdetail_combined:claim_no]/noheading/align=l_curr_resv/column=120
total[l_curr_adj_resv,lrsdetail_combined:claim_no]/noheading/align=l_curr_adj_resv/column=140
total[l_prior_resv,lrsdetail_combined:claim_no]/noheading/align=l_prior_resv/column=160
total[l_prior_adj_resv,lrsdetail_combined:claim_no]/noheading/align=l_prior_adj_resv/column=180
total[l_incurred,lrsdetail_combined:claim_no]/align=l_incurred/noheading/column=200
total[l_incurred_lae,lrsdetail_combined:claim_no]/align=l_incurred_lae/noheading/column=220
total[l_incurred_total,lrsdetail_combined:claim_no]/align=l_incurred_total/noheading/column=240

/*  END OF FILE  */


include "reporttop.inc"

end of report 
""/newline  
"  REPORT TOTAL "
total[l_loss_paid]/noheading/align=l_loss_paid
total[l_curr_adj_exp]/noheading/align=l_curr_adj_exp
total[l_curr_resv]/noheading/align=l_curr_resv
total[l_curr_adj_resv]/noheading/align=l_curr_adj_resv
total[l_prior_resv]/noheading/align=l_prior_resv
total[l_prior_adj_resv]/noheading/align=l_prior_adj_resv
total[l_incurred]/align=l_incurred/noheading
total[l_incurred_lae]/align=l_incurred_lae/noheading
total[l_incurred_total]/align=l_incurred_total/noheading
