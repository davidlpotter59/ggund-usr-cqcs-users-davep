
/*  LRSPR531

    Losses by Claim Number - Direct

    Date Written : September 3, 2009

    SCIPS.com */

description 
Direct Incurred Losses By Claim Number - Version 7.20;
             
define string l_name[10] = lrssetup:name[1]
Define String l_prog_number = "LRSPR531 - XXRev 7.20"       

define string l_claim_no[11] = str(lrsdetail:claim_no) + trun(sfsline_alias:claim_alpha)

--Include "lrs63cal.inc"
/* LRS63CAL.INC

   INCLUDE FILE USED FOR CLAIM REPORT CALCULATIONS

   Date Written : November 7, 1992

   SCIPS.com

   PROGRAMS USED BY THIS INCLUDE FILE
        - LRSPR531, LRSPR631, LRSPR633, LRSPR634, LRSPR635, LRSPR636
        - LRSPR638, LRSPR641, LRSPR671, LRSPR881, LRSPR882, LRSPR891
*/

include "startend.inc"

define wdate l_prior_starting_date = 01.01.0000 
-- force the beginning of time

define wdate l_prior_ending_date = l_starting_date - 1 
-- one day before starting date

define string l_status_code = if lrssetup:status_date <= l_ending_date then 
lrssetup:status else "X"

define string
        l_status[12] = switch(l_status_code)
        case "O"                : "**OPEN    **"
        case "R"                : "**REOPENED**"
        case "C"                : "**CLOSED  **"
        case "X"                : "**OPEN    **"

define signed ascii l_prior_resv[10]= if
    lrsdetail:trans_date >= 01.01.1900 and 
    lrsdetail:trans_date < l_starting_date then
    lrsdetail:loss_resv/decimalplaces=2

define signed ascii l_prior_adj_resv[10]=if
    lrsdetail:trans_date < l_starting_date then
    lrsdetail:lae_resv/decimalplaces=2

define signed ascii l_curr_resv[10]= if
    lrsdetail:trans_date >= l_starting_date and
    lrsdetail:trans_date <= l_ending_date then
    lrsdetail:loss_resv/decimalplaces=2

define signed ascii l_period_resv[10]= if
-- reserves are period - as of 06/06/2007
   lrsdetail:trans_date >= l_starting_date and
    lrsdetail:trans_date <= l_ending_date then
    lrsdetail:loss_resv/decimalplaces=2

define signed ascii l_curr_adj_resv[10]=if
    lrsdetail:trans_date >= l_starting_date and
    lrsdetail:trans_date <= l_ending_date then
    lrsdetail:lae_resv/decimalplaces=2

define signed ascii l_period_adj_resv[10]=if
-- reserves are period - as of 06/06/2007
    lrsdetail:trans_date >= l_starting_date and
    lrsdetail:trans_date <= l_ending_date then
    lrsdetail:lae_resv/decimalplaces=2

define signed ascii number l_loss_paid[10]=if
    lrsdetail:trans_date => l_starting_date and
    lrsdetail:trans_date <= l_ending_date then
    lrsdetail:loss_paid/dec=2

define signed ascii number l_curr_adj_exp[10]=if
    lrsdetail:trans_date => l_starting_date and
    lrsdetail:trans_date <= l_ending_date then
    lrsdetail:lae_paid/dec=2

define signed ascii number l_prior_resv_total[10]=
    l_prior_resv/decimalplaces=2

define signed ascii number l_incurred[10]=
    l_curr_resv + l_loss_paid  - l_prior_resv_total  -- was commenting out the l_prior_resv_total

define signed ascii number l_incurred_lae[10]=
    l_curr_adj_resv + l_curr_adj_exp  - l_prior_adj_resv -- was commenting the l_prior_adj_resv

define signed ascii number l_incurred_total[10]=
    l_incurred + l_incurred_lae

/*  END OF FILE */

define string l_program_no = "LRSPR531 - Version 7.20"

include "lrscollect.inc"  

and   lrsdetail:trans_date <= l_ending_date and
      lrsdetail:trans_code < 30 --and trans_code not one of 15 -- why was 15 being excluded from this run?
--and (claim_no one of 1093403313, 1093035115)
list
/nobanner
/domain="lrsdetail" 
/title="Direct Incurred Losses By Claim Number *"
--/pagewidth=220
/duplicates
/nodetail
/nopageheadings
/noreporttotals 

Include "lrs53prt.inc"

sorted by lrsdetail:claim_no
          lrsdetail:cause_of_loss 
          lrsdetail:cause_loss_subline 

Include "lrs53clm.inc"

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
