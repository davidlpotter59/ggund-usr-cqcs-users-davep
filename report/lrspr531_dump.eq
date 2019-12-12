
/*  LRSPR531

    Losses by Claim Number - Direct

    Date Written : September 3, 2009

    SCIPS.com */

description 
Direct Incurred Losses By Claim Number - Version 7.20;
             
define string l_name[10] = lrssetup:name[1]
Define String l_prog_number = "LRSPR531 - Rev 7.20"       

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

define date l_starting_date = parameter/cls/prompt="Please Enter The Starting Date : (MMDDYYYY) "

define date l_ending_date   = parameter/prompt="Please Enter The Ending Date : (MMDDYYYY) "
error "Ending Date MUST Be => Starting Date" if
l_ending_date < l_starting_date


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
 --  lrsdetail:trans_date >= l_starting_date and
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


define string l_program_no = "LRSPR531 - Version 7.20"

/*  lrscollect.inc

    february 8, 1999

    SCIPS.com

    Replace lrscol1 - lrscol4, does not require select/collection= to run */

where  


/*
        (((lrsdetail:loss_paid <> 0 and
        (lrsdetail:trans_date => l_starting_date and
         lrsdetail:trans_date <= l_ending_date)) or

        (lrsdetail:lae_paid <> 0 and
        (lrsdetail:trans_date => l_starting_date and
         lrsdetail:trans_date <= l_ending_date)) or

        ((lrsdetail:loss_resv <> 0 and
         (lrssetup:status <> "C") or
         (lrssetup:status = "C" and
          lrssetup:status_date => l_starting_date))) or

        ((lrsdetail:lae_resv <> 0/* and
         (lrssetup:status <> "C") or
        (lrssetup:status = "C" and
         lrssetup:status_date => l_starting_date)))))
*/
      (lrsdetail:loss_paid <> 0 or 
       lrsdetail:lae_paid <> 0 or
       lrsdetail:loss_resv <> 0 or
       lrsdetail:lae_resv <> 0)
  
and lrsdetail:trans_code not one of 91,92,93,94,95,96,97,98,99

--and lrsdetail:trans_code not one of 91,92,93,94,95,96,97,98,99


and   lrsdetail:trans_date <= l_ending_date and
      lrsdetail:trans_code < 30 --and trans_code not one of 15 -- why was 15 being excluded from this run?

--and val(lrsdetail:other_system_trans_code) <> 45
--and sfsagent:agent_master_code one of 262
--and lrssetup:agent_no one of 143,144
--and (lrssetup:eff_date < 09.01.2011 or 
--    lrssetup:eff_date => 09.01.2014)
and with lrsdetail:claim_no one of 88811090001, 88811090002, 88811090003,
        88811100001, 88811100002, 88811100003, 88811100004, 88811100005,
        88811100006, 88811110001, 88811110002, 88811110005, 88811110006,
        88811110007, 88811110010, 88811110011, 88811120001, 88811120002
list
/nobanner
/domain="lrsdetail" 
/title="Direct Incurred Losses By Claim Number *"
--/pagewidth=220
/duplicates
/nodetail
/nopageheadings
/noreporttotals 

--Include "lrs53prt.inc"
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

08/09/2010      dlp     added adjustment (lae) paid to report
*/

box/duplicates 
l_claim_no/heading="Claim No"/column=1
--lrssetup:policy_no/heading="Policy-No"/column=11
--lrssetup:agent_no/heading="Agent-No"/column=21/duplicates 
--lrssetup:eff_date/heading="Effective-Date"/column=26/duplicates 
--lrsdetail:cause_of_loss/heading="Cause"/column=37/duplicates 
--lrsdetail:cause_loss_subline/noheading/column=41
--lrssetup:loss_date/heading="Loss-Date"/column=45
--lrsdetail:line_of_business/heading="LOB-Subline"/column=57 
--lrsdetail:lob_subline/noheading/column=61
--l_status/heading="Open/Closed"/width=12/column=64
l_loss_paid/heading="Losses Paid"/width=15/column=80
l_curr_adj_exp/heading="LAE Paid"/width=15/column=100
--l_curr_resv/heading="Current-Loss-Reserves"/width=15/column=120
--l_curr_adj_resv/heading="Current-LAE Reserves"/width=15/column=140
--l_prior_resv/heading="Prior-Loss-Reserves"/width=15/column=160
--l_prior_adj_resv/heading="Prior-LAE Reserves"/width=15/column=180
--l_incurred/heading="Current Period-Incurred Losses-Without LAE"/width=15/column=200
--l_incurred_lae/heading="Current Period-Incurred LAE"/width=15/column=220
--l_incurred_total/heading="Current Period-Net Losses &-LAE Incurred"/width=15/column=240
end box
/*  END OF FILE  */


sorted by lrsdetail:claim_no
          lrsdetail:cause_of_loss 
          lrsdetail:cause_loss_subline 

--Include "lrs53clm.inc"
/*  LRS53CLM.INC

    CLAIM TOTAL INFORMATION FOR ALL LRSPR53? REPORTS

    Date Written : October 5, 1993

    SCIPS.com

    PROGRAMS USED BY THIS INCLUDE FILE
        - LRSPR531, LRSPR532
*/

end of lrsdetail:claim_no 
l_claim_no/noheading
--lrssetup:policy_no/noheading/column=11
---lrssetup:agent_no/noheading/column=21
--lrssetup:eff_date/noheading/column=26
--lrsdetail:cause_of_loss/noheading/column=37
--lrsdetail:cause_loss_subline/noheading/column=41
--lrssetup:loss_date/noheading/column=45
--lrsdetail:line_of_business/noheading/column=57
--lrsdetail:lob_subline/noheading/column=61
--l_status/noheading/width=12/column=64
total[l_loss_paid]/noheading/align=l_loss_paid/column=80
total[l_curr_adj_exp]/noheading/align=l_curr_adj_exp/column=100
--total[l_curr_resv]/noheading/align=l_curr_resv/column=120
--total[l_curr_adj_resv]/noheading/align=l_curr_adj_resv/column=140
--total[l_prior_resv]/noheading/align=l_prior_resv/column=160
--total[l_prior_adj_resv]/noheading/align=l_prior_adj_resv/column=180
--total[l_incurred]/align=l_incurred/noheading/column=200
--total[l_incurred_lae]/align=l_incurred_lae/noheading/column=220
--total[l_incurred_total]/align=l_incurred_total/noheading/column=240

/*  END OF FILE  */




/*  reporttop.inc

    February 10, 2004

    SCIPS.com, Inc.

    top of page headings for standard printing
*/

top of page  
--L_prog_number                    /heading="Report No      "/column=1/newline 
enquiryname                                                                               /heading="Report No      "/left/column=1/newline
trun(sfscompany:name[1])                                                                  /heading="Company Name   "/left/column=1/newline  
trun(str(l_starting_date,"MM/DD/YYYY") + " - " + str(l_ending_date,"MM/DD/YYYY"))/column=1/heading="Report Period  "/left/newline

/*
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
*/
