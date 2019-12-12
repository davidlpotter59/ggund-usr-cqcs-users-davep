
/*  LRSPR638

    Losses by Agent - Direct

    Date Written : November 7, 1992

    SCIPS.com, Inc. */

description 
Direct Incurred Losses by Agent  -  Detail;

Define String l_prog_number = "LRSPR638 - Rev 4.10"

define string l_claim_no = str(lrsdetail:claim_no) + trun(
sfsline_alias:claim_alpha)

Include "lrs63cal.inc"
define l_prior_resv2 = if
lrsdetail:trans_date < l_starting_date then 
lrsdetail:loss_resv 

--include "lrscollect.inc"
where   (lrsdetail:trans_date <= l_ending_date and
      lrsdetail:trans_code < 30) 
--and lrssetup:agent_no = 110
                             
list
/nobanner
/domain="lrsdetail"
/title="Direct Incurred Losses By Agent  -  Detail"
--/pagewidth=220
/duplicates
/nodetail 
--/noreporttotals 

Include "lrs63prt.inc"
lrssetup:agent_no/column=1
l_prior_resv /total /column=20
l_incurred_total/total /column=40
l_prior_resv2 /total /column=60

sorted by lrssetup:agent_no
          --lrsdetail:line_of_business/total/newline
          --lrsdetail:claim_no

--Include "lrs63clm.inc"

end of lrssetup:agent_no 
lrssetup:agent_no /column=1/noheading 
total[l_prior_resv]/column=20/noheading 
total[l_incurred_total]/column=40/noheading 
total[l_prior_resv2]/column=60/noheading 


Include "reporttop.inc"
""/newline 
lrssetup:agent_no/column=1/noheading 
box/noblanklines/noheadings  
    sfsagent:name[1]/column=10/newline 
    sfsagent:name[2]/column=10/newline 
    sfsagent:name[3]/column=10/newline=2
end box
