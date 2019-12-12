include "startend.inc"

define string l_prog_number = "NARS DUMP"

--where lrsdetail:trans_date>= l_starting_date and 
--      lrsdetail:trans_date <= l_ending_date 
--and lrssetup:agent_no one of 100 

where (lrsdetail:trans_date => l_starting_date 
and lrsdetail:trans_date <= l_ending_date )
and lrsdetail:lae_resv <> 0

list
/nobanner
/domain="lrsdetail"  
--/nodetail  
--/noreporttotals  
--/pagelength=0
/duplicates 
  
lrsdetail:claim_no/column=1
--lrsdetail:trans_date
--lrssetup:agent_no 

lrsdetail:loss_resv/total/heading="Loss Reserve"/column=15/mask="(ZZZ,ZZZ,ZZZ.99)"
lrsdetail:loss_paid/total/heading="Loss Paid"  /column=35/mask="(ZZZ,ZZZ,ZZZ.99)"
lrsdetail:lae_paid/total/heading="LAE Paid"/column=55/mask="(ZZZ,ZZZ,ZZZ.99)"
lrsdetail:lae_resv/total/heading="LAE Resv"/column=75/mask="(ZZZ,ZZZ,ZZZ.99)"
lrsdetail:ulae 
lrsdetail:alae 
 

sorted by lrsdetail:claim_no
          
include "reporttop.inc"
