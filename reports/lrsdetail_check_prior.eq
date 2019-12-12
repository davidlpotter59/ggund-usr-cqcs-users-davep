viewpoint native;
--include "startend.inc"

/* LRS63CAL.INC

   INCLUDE FILE USED FOR CLAIM REPORT CALCULATIONS

   Date Written : November 7, 1992

   SCIPS.com

   PROGRAMS USED BY THIS INCLUDE FILE
        - LRSPR531, LRSPR631, LRSPR633, LRSPR634, LRSPR635, LRSPR636
        - LRSPR638, LRSPR641, LRSPR671, LRSPR881, LRSPR882, LRSPR891
*/

include "startend2.inc"

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
--    lrsdetail:trans_date >= l_starting_date and
    lrsdetail:trans_date <= l_ending_date then
    lrsdetail:loss_resv/decimalplaces=2

define signed ascii l_period_resv[10]= if
-- reserves are period - as of 06/06/2007
   lrsdetail:trans_date >= l_starting_date and
    lrsdetail:trans_date <= l_ending_date then
    lrsdetail:loss_resv/decimalplaces=2

define signed ascii l_curr_adj_resv[10]=if
--    lrsdetail:trans_date >= l_starting_date and
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

where 
  lrsdetail:trans_date < 
    1.jan.2019
 

list/nobanner/domain="lrsdetail"
  lrsdetail:claim_no 
  lrsdetail:trans_date 
  lrsdetail:line_of_business 
  lrsdetail:lob_subline 
  lrsdetail:cause_of_loss 
  lrsdetail:cause_loss_subline 
  lrsdetail:trans_code 
  lrsdetail:loss_resv 
  lrsdetail:loss_paid 
  lrsdetail:lae_resv 
  lrsdetail:lae_paid
  l_prior_resv
