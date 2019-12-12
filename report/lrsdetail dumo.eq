
include "startend.inc"

define string l_prog_number = "lrsdetail_dump"
define signed ascii number l_paid = if lrsdetail:trans_code not one of 15 then lrsdetail:loss_paid else 0
define signed ascii number l_recovery = if lrsdetail:trans_code one of 15 then lrsdetail:loss_paid else 0

where (lrsdetail:trans_date => l_starting_date 
and      lrsdetail:trans_date <= l_ending_date )
--and lrsdetail:loss_resv <> 0
--and lrsdetail:trans_code = 15
and lrssetup:agent_no one of 703

list
/nobanner
/domain="lrsdetail"
/title="2009 Payments"
/duplicates 
--/nodetail 

--lrsdetail:company_id 
lrsdetail:claim_no /column=1/heading="SCIPS-Claim Number"
lrsdetail:trans_code /column=201
--lrspointer:company_claim_number /column=20
lrsdetail:trans_date /column=60
lrsdetail:loss_paid /mask="(ZZ,ZZZ,ZZZ.99)"/column=80/total 
l_paid /column=100/heading="Paid-Amount"/total 
l_recovery/column=120/heading="Recovery"/total 
lrsdetail:lae_paid  /mask="(ZZ,ZZZ,ZZZ.99)"/column=140/total 
lrsdetail:loss_resv /mask="(ZZ,ZZZ,ZZZ.99)"/column=160/total 
--lrsdetail:summary_sub_code 

--lrsdetail:control_total /mask="(ZZ,ZZZ,ZZZ.99)"/heading="Amount that-is DCC"

--lrssetup:claim_no lrspointer:company_claim_number 

sorted by lrsdetail:claim_no/newlines /total lrsdetail:trans_date 

/*
end of lrsdetail:claim_no
box/noblanklines /noheadings 
lrsdetail:claim_no /column=1
lrspointer:company_claim_number /column=20
total[lrsdetail:loss_paid ]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=60
xob
*/

include "reporttop.inc"
