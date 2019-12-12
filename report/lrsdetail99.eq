
--include "startend.inc"
define wdate l_starting_date = 01.01.2010
define wdate l_ending_date   = 07.31.2010

define string l_prog_number = "NARS Edit List - 2009 ITD" 
define signed ascii number l_current_reserve = if lrsdetail:trans_date => l_starting_date and 
 lrsdetail:trans_date <= l_ending_date and 
 lrsdetail:loss_resv <> 0 then lrsdetail:loss_resv 
else
0

define signed ascii number l_2009_reserve = if year(lrsdetail:trans_date) = 2009 then lrsdetail:loss_resv 
define signed ascii number l_2010_reserve = if year(lrsdetail:trans_date) = 2010 then lrsdetail:loss_resv 

define signed ascii l_current_paid = if lrsdetail:trans_date => l_starting_date and 
 lrsdetail:trans_date <= l_ending_date and 
 lrsdetail:loss_paid <> 0 then  lrsdetail:loss_paid 
else
0

define string l_claim_no[11] = str(lrsdetail:claim_no)

where (lrsdetail:trans_date =>L_starting_date and
      lrsdetail:trans_date <= l_ending_date) 
and lrsdetail:loss_RESV  <> 0

list
/nobanner
/domain="lrsdetail"
/duplicates 

lrsdetail:claim_no/column=1 
lrsdetail:sub_code /column=15
lrssetup:agent_no/column=15/heading="Agent"
lrsdetail:trans_date /column=30
lrsdetail:trans_code 
lrsdetail:loss_resv/column=50/mask="(ZZZ,ZZZ,ZZZ)"/total 
--lrsdetail:other_system_trans_code 
--lrsdetail:loss_paid 
--lrsdetail:lae_paid 

sorted by lrsdetail:claim_no
