include "startend.inc"

where
lrsdetail:trans_code < 30 
and lrsdetail:trans_date => l_starting_date 
and lrsdetail:trans_date <= l_ending_date 


list
/nobanner
/domain="lrsdetail"

claim_no 
lrsdetail:preload 
lrssetup:policy_no 
lrssetup:agent_no 
lrsdetail:trans_code 
trans_date 
line_of_business 
loss_resv/mask="(ZZZ,ZZZ,ZZZ.99)" 
loss_paid/mask="(ZZZ,ZZZ,ZZZ.99)" 
lrsdetail:alae 
lrsdetail:ulae 
lae_resv/mask="(ZZZ,ZZZ,ZZZ.99)" 
lae_paid/mask="(ZZZ,ZZZ,ZZZ.99)"

lrssetup:status  lrssetup:status_date comments 

sorted by lrssetup:agent_no--/newlines 
          lrsdetail:claim_no--/newlines /total
