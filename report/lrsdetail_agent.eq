include "startend.inc"

define unsigned ascii number l_agent_no[4] = parameter 

where lrsdetail:trans_date <= l_ending_date 
--include "lrscollect.inc"
and lrssetup:agent_no = l_agent_no 
and (lrsdetail:loss_paid <> 0 or 
     lrsdetail:loss_resv <> 0)
--and lrsdetail:line_of_business one of 6

list
/nobanner
/domain="lrsdetail"
/duplicates 

lrsdetail:claim_no 
lrssetup:policy_no 
lrssetup:status 
lrssetup:status_date 
lrssetup:agent_no 
lrsdetail:trans_date
lrsdetail:trans_code 
lrsdetail:loss_resv 
--lrsdetail:loss_paid 

sorted by lrsdetail:line_of_business/total/newlines/heading="@"  lrssetup:claim_no/newlines/total
