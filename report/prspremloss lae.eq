define string l_sfs = "SFS"
define unsigned ascii number l_claim_no[11] = prspremloss:claim_no/decimalplaces=0/nocommas 

define file sfsdefaulta = access sfsdefault, set sfsdefault:sfs_code= l_sfs 

define file lrsdetaila = access lrsdetail, set lrsdetail:company_id= sfsdefaulta:company_id, 
                                               lrsdetail:claim_no= l_claim_no, approximate  

define signed ascii number l_loss_reserve[8]=if lrsdetaila:trans_date => 01.01.2010 and lrsdetail:trans_date <= 07.31.2010 and 
lrsdetail:trans_code < 30 then lrsdetaila:loss_resv else 0/decimalplaces=0

where (prspremloss:start_date_yyyy = 2017 and 
       prspremloss:start_date_mm   = 01 and 
       prspremloss:end_date_yyyy   = 2017 and 
       prspremloss:end_date_mm     = 12) 
--and
--(prspremloss:loss_reserve_prior <> 0 or 
-- prspremloss:loss_reserve_current <> 0)
and sfsline:stmt_lob  <> 999
and (prspremloss:ulae_reserve_prior <> 0 or 
     prspremloss:ulae_reserve_current <> 0 or 
     prspremloss:alae_reserve_prior <> 0 or 
     prspremloss:alae_reserve_current <> 0)

list
/nobanner
/domain="prspremloss"
/nodetail 
/noreporttotals 

/*
prspremloss:claim_no 
prspremloss:loss_paid_current 
prspremloss:alae_paid_current + prspremloss:ulae_paid_current 
prspremloss:loss_reserve_current 
prspremloss:loss_reserve_prior 
--l_loss_reserve /heading="LRSDETAIL-Loss Reserve"
--sfsdefaulta:company_id /duplicates 
--len(sfsdefaulta:company_id)
--l_claim_no 
*/

end of report 
prspremloss:start_date_yyyy/heading="Start Date YYYY"/newline /mask="ZZZZ"
prspremloss:start_date_mm  /heading="Start Date MM  "/newline 
prspremloss:end_date_yyyy  /heading="End Date YYYY  "/newline /mask="ZZZZ" 
prspremloss:end_date_mm    /heading="End Date MM    "/newline=2

total[prspremloss:ulae_reserve_prior]                                      /heading="ULAE Reserve Prior     " /mask="(ZZZ,ZZZ,ZZZ)"/newline/column=1
total[prspremloss:alae_reserve_prior]                                      /heading="ALAE Reserve Prior     " /mask="(ZZZ,ZZZ,ZZZ)"/newline/column=1
total[prspremloss:ulae_reserve_current]                                    /heading="ULAE Reserve Current   " /mask="(ZZZ,ZZZ,ZZZ)"/newline/column=1
total[prspremloss:alae_reserve_current]                                    /heading="ALAE Reserve Current   " /mask="(ZZZ,ZZZ,ZZZ)"/newline/column=1

""/newline
