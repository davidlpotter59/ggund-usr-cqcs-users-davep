viewpoint native;

--include "startend.inc"
define
  wdate l_starting_date = 01.01.2016;
  
  wdate l_ending_date = 06.30.2016
  
define string l_claim_no = str(lrsdetail:claim_no)
define string l_scips_prefix[4]=  
switch(l_claim_no[1,3])
case "444"   : "GGDI"
case "333"   : "GGCA"
case "222"   : "SICA"
case "777"   : "GGSR"
case "888"   : "888"
case "555"   : "GGAX"

define l_nars_claim_no = l_scips_prefix + l_claim_no[4,11]
--where lrsdetail:claim_no one of 88814020043, 88814040051, 88815080011,
--        88816060022
--
where lrssetup:line_of_business one of 7


list
/banner
/duplicates
/domain="lrsdetail"
--/nodetail 

lrsdetail:claim_no/column=1--lrssetup:agent_no/column=15/heading="Agent"
l_nars_claim_no/heading="NARS-Claim-Number"/column=20
--lrssetup:policy_no 
--lrssetup:eff_date 
--lrsdetail:trans_date 
--lrsdetail:company_id 
--len(company_id)
lrsdetail:loss_resv /mask="(ZZZ,ZZZ,ZZZ.99)"
lrsdetail:loss_paid 
lrsdetail:lae_paid  


sorted by  lrsdetail:claim_no

end of lrsdetail:claim_no 
box/noblanklines /noheadings 
lrsdetail:claim_no 
l_nars_claim_no/align=l_nars_claim_no 
total[lrsdetail:loss_resv]/align=lrsdetail:loss_resv  /mask="(ZZZ,ZZZ,ZZZ.99)"
total[lrsdetail:loss_paid]/align=lrsdetail:loss_paid  /mask="(ZZZ,ZZZ,ZZZ.99)"
total[lrsdetail:lae_paid]/align=lrsdetail:lae_paid  /mask="(ZZZ,ZZZ,ZZZ.99)"
--lrsdetail:cause_of_loss 
xob
