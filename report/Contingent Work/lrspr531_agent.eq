
/*  LRSPR531

    Losses by Claim Number - Direct

    Date Written : September 3, 2009

    SCIPS.com */

description 
Direct Incurred Losses By Claim Number - Version 7.22;
             
define string l_name[10] = lrssetup_combined:name[1]
Define String l_prog_number = "LRSPR531 - Rev 7.20"       

define string l_claim_no[11] = str(lrsdetail_combined:claim_no) + trun(sfsline_alias:claim_alpha)


define date l_ending_date   = parameter/prompt="Please Enter The As of Date : (MMDDYYYY) "
default todaysdate 
--error "Ending Date MUST Be => Starting Date" if
--l_ending_date < l_starting_date

define date l_starting_date = dateadd(01.01.0000,0,year(l_ending_date))  -- beginning of time

define unsigned ascii number l_stop_loss = parameter/prompt="Enter Stop Loss for Agent " default 300000;

define unsigned ascii number l_agent_no = parameter/prompt= "Enter Agent Number "

define wdate l_prior_starting_date = 01.01.0000 
-- force the beginning of time

define wdate l_prior_ending_date = l_starting_date - 1 
-- one day before starting date

define string l_status_code = if lrssetup_combined:status_date <= l_ending_date then 
lrssetup_combined:status else "X"

define string
        l_status[12] = switch(l_status_code)
        case "O"                : "**OPEN    **"
        case "R"                : "**REOPENED**"
        case "C"                : "**CLOSED  **"
        case "X"                : "**OPEN    **"

define signed ascii l_prior_resv[10]= if
    lrsdetail_combined:trans_date >= 01.01.1900 and 
    lrsdetail_combined:trans_date < l_starting_date then
    lrsdetail_combined:loss_resv/decimalplaces=2

define signed ascii l_prior_adj_resv[10]=if
    lrsdetail_combined:trans_date < l_starting_date then
    lrsdetail_combined:lae_resv/decimalplaces=2

define signed ascii l_curr_resv[10]= if
 --  lrsdetail_combined:trans_date >= l_starting_date and
    lrsdetail_combined:trans_date <= l_ending_date then
    lrsdetail_combined:loss_resv/decimalplaces=2

define signed ascii l_period_resv[10]= if
-- reserves are period - as of 06/06/2007
  lrsdetail_combined:trans_date >= l_starting_date and
    lrsdetail_combined:trans_date <= l_ending_date then
    lrsdetail_combined:loss_resv/decimalplaces=2

define signed ascii l_curr_adj_resv[10]=if
--    lrsdetail_combined:trans_date >= l_starting_date and
    lrsdetail_combined:trans_date <= l_ending_date then
    lrsdetail_combined:lae_resv/decimalplaces=2

define signed ascii l_period_adj_resv[10]=if
-- reserves are period - as of 06/06/2007
    lrsdetail_combined:trans_date >= l_starting_date and
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
    l_curr_resv + l_loss_paid  - l_prior_resv_total  -- was commenting out the l_prior_resv_total

define signed ascii number l_incurred_lae[10]=
    l_curr_adj_resv + l_curr_adj_exp  - l_prior_adj_resv -- was commenting the l_prior_adj_resv

define signed ascii number l_incurred_total[10]=
    l_incurred + l_incurred_lae

/*  END OF FILE */

define file sfsline2a = access sfsline2, set sfsline2:company_id= lrssetup_combined:company_id,
                                             sfsline2:line_of_business= lrssetup_combined:line_of_business, 
                                             sfsline2:lob_subline= lrssetup_combined:lob_subline 

define string l_program_no = "LRSPR531 - Version 7.20"

/*  lrscollect.inc

    february 8, 1999

    SCIPS.com

    Replace lrscol1 - lrscol4, does not require select/collection= to run */

where  


/*
        (((lrsdetail_combined:loss_paid <> 0 and
        (lrsdetail_combined:trans_date => l_starting_date and
         lrsdetail_combined:trans_date <= l_ending_date)) or

        (lrsdetail_combined:lae_paid <> 0 and
        (lrsdetail_combined:trans_date => l_starting_date and
         lrsdetail_combined:trans_date <= l_ending_date)) or

        ((lrsdetail_combined:loss_resv <> 0 and
         (lrssetup_combined:status <> "C") or
         (lrssetup_combined:status = "C" and
          lrssetup_combined:status_date => l_starting_date))) or

        ((lrsdetail_combined:lae_resv <> 0/* and
         (lrssetup_combined:status <> "C") or
        (lrssetup_combined:status = "C" and
         lrssetup_combined:status_date => l_starting_date)))))
*/
      (lrsdetail_combined:loss_paid <> 0 or 
       lrsdetail_combined:lae_paid <> 0 or
       lrsdetail_combined:loss_resv <> 0 or
       lrsdetail_combined:lae_resv <> 0)
  
and lrsdetail_combined:trans_code not one of 91,92,93,94,95,96,97,98,99
 

and   
      (lrsdetail_combined:loss_paid <> 0 or 
       lrsdetail_combined:lae_paid <> 0 or
       lrsdetail_combined:loss_resv <> 0 or
       lrsdetail_combined:lae_resv <> 0)
  
--and lrsdetail_combined:trans_code not one of 91,92,93,94,95,96,97,98,99
--and sfsline:stmt_lob <> 999 

and   lrsdetail_combined:trans_date <= l_ending_date and
      lrsdetail_combined:trans_code < 30 --and trans_code not one of 15 -- why was 15 being excluded from this run?

and with lrssetup_combined:agent_no = l_agent_no 
and sfsline2:exclude_from_contingent one of 1

list
/nobanner
/domain="lrsdetail_combined" 
/title="Direct Incurred Losses By Claim Number *"
--/pagewidth=220
/duplicates
/nodetail
--/nopageheadings
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

08/09/2010      dlp     added adjustment (lae) paid to report
*/

box/duplicates 
l_claim_no/heading="Claim-No"/column=1
lrssetup_combined:policy_no/heading="Policy-No"/column=15
lrssetup_combined:agent_no/heading="Agt-No"/column=25/duplicates 
lrssetup_combined:eff_date/heading="Eff-Date"/column=30/duplicates 
lrsdetail_combined:cause_of_loss/heading="Cause"/column=45/duplicates 
lrsdetail_combined:cause_loss_subline/noheading/column=50
lrssetup_combined:loss_date/heading="Loss-Date"/column=60
lrsdetail_combined:line_of_business/heading="LOB-Subline"/column=75 
lrsdetail_combined:lob_subline/noheading/column=80
l_status/heading="Open/Closed"/width=12/column=85
l_loss_paid/heading="Period-Losses-Paid"/width=15/column=100
l_curr_adj_exp/heading="Period-LAE-Paid"/width=15/column=120
l_curr_resv/heading="Current-Loss-Reserves"/width=15/column=140
l_curr_adj_resv/heading="Current-LAE Reserves"/width=15/column=160
l_prior_resv/heading="Prior-Loss-Reserves"/width=15/column=180
l_prior_adj_resv/heading="Prior-LAE Reserves"/width=15/column=200
l_incurred/heading="Current Period-Incurred Losses-Without LAE"/width=15/column=220
l_incurred_lae/heading="Current Period-Incurred LAE"/width=15/column=240
l_incurred_total/heading="Current Period-Net Losses &-LAE Incurred"/width=15/column=260
""/column=280/heading="Stop Loss-Adjustment"

end box
/*  END OF FILE  */


sorted by lrsdetail_combined:claim_no
          lrsdetail_combined:cause_of_loss 
          lrsdetail_combined:cause_loss_subline 

end of lrsdetail_combined:claim_no 
l_claim_no/noheading
lrssetup_combined:policy_no/noheading/column=15
lrssetup_combined:agent_no/noheading/column=25
lrssetup_combined:eff_date/noheading/column=30
lrsdetail_combined:cause_of_loss/noheading/column=45
lrsdetail_combined:cause_loss_subline/noheading/column=50
lrssetup_combined:loss_date/noheading/column=60
lrsdetail_combined:line_of_business/noheading/column=75
lrsdetail_combined:lob_subline/noheading/column=80
l_status/noheading/width=12/column=85
total[l_loss_paid]/noheading/align=l_loss_paid/column=100
total[l_curr_adj_exp]/noheading/align=l_curr_adj_exp/column=120
total[l_curr_resv]/noheading/align=l_curr_resv/column=140
total[l_curr_adj_resv]/noheading/align=l_curr_adj_resv/column=160
total[l_prior_resv]/noheading/align=l_prior_resv/column=180
total[l_prior_adj_resv]/noheading/align=l_prior_adj_resv/column=200
total[l_incurred]/align=l_incurred/noheading/column=220
total[l_incurred_lae]/align=l_incurred_lae/noheading/column=240
total[l_incurred_total]/align=l_incurred_total/noheading/column=260


if total[l_incurred_total] > l_stop_loss  then 
{
   total[l_incurred_total] - l_stop_loss/mask="(ZZZ,ZZZ,ZZZ.99)"/noheading/column=280
}
else
{
0.00/mask="(ZZZ,ZZZ,ZZZ.99)"/noheading/column=280
}

top of page  
enquiryname                                                                               /heading="Report No      "/left/column=1/newline
trun(sfscompany:name[1])                                                                  /heading="Company Name   "/left/column=1/newline  
                                                  str(l_ending_date,"MM/DD/YYYY")/column=1/heading="As of Date     "/left/newline


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
