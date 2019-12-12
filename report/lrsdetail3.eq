--include "startend.inc"
define wdate l_starting_date = 01.01.2000
define wdate l_ending_date = 12.31.2009

define string l_prog_number = "NARS DUMP"

define signed ascii number l_2009_paid_amount = if
lrsdetail:trans_date => 01.01.2009 and 
lrsdetail:trans_date <= 12.31.2009 then lrsdetail:loss_paid 
else 0.00

define signed ascii number l_2009_reserve = if
--lrsdetail:trans_date => 12.31.2009 and 
lrsdetail:trans_date <= 12.31.2009 then lrsdetail:loss_resv 
else 0.00

define signed ascii number l_2008_paid_amount = if
lrsdetail:trans_date => 01.01.2008 and 
lrsdetail:trans_date <= 12.31.2008 then lrsdetail:loss_paid 
else 0.00

define signed ascii number l_2008_reserve = if
lrsdetail:trans_date <= 12.31.2008 then lrsdetail:loss_resv 
else 0.00

define signed ascii number l_2007_reserve = if
lrsdetail:trans_date <= 12.31.2007 then lrsdetail:loss_resv 
else 0.00

define signed ascii number l_2006_reserve = if
lrsdetail:trans_date <= 12.31.2006 then lrsdetail:loss_resv 
else 0.00

define signed ascii number l_2005_reserve = if
lrsdetail:trans_date <= 12.31.2005 then lrsdetail:loss_resv 
else 0.00

where lrsdetail:trans_date>= l_starting_date and 
      lrsdetail:trans_date <= l_ending_date 
--and with lrssetup:comments[1,4] = "NARS"
-- and lrssetup:agent_no one of 143
and claim_no one of 1093035115,
 1093403313


list
/nobanner
/domain="lrsdetail"
--/nodetail  
--/noreporttotals  
--/pagelength=0
/duplicates 

lrsdetail:claim_no/column=1
lrsdetail:loss_resv/total/heading="Period-Loss Reserve"/column=15/mask="(ZZZ,ZZZ,ZZZ.99)"
lrsdetail:loss_paid/total/heading="Period-Loss Paid"  /column=35/mask="(ZZZ,ZZZ,ZZZ.99)"
lrsdetail:lae_paid/total/heading="Period-LAE Paid"/column=55/mask="(ZZZ,ZZZ,ZZZ.99)"
lrsdetail:lae_resv/total/heading="Period-LAE Resv"/column=75/mask="(ZZZ,ZZZ,ZZZ.99)"
l_2005_reserve /heading="2005 Ending-Reserve"/column=95/mask="(ZZZ,ZZZ,ZZZ.99)"
l_2006_reserve/heading="2006 Ending-Reserve"/column=115/mask="(ZZZ,ZZZ,ZZZ.99)"
l_2007_reserve /heading="2007 Ending-Reserve"/column=135/mask="(ZZZ,ZZZ,ZZZ.99)"
l_2008_reserve/heading="2008 Ending-Reserve"/column=155/mask="(ZZZ,ZZZ,ZZZ.99)"
l_2008_reserve/heading="2009 Ending-Reserve"/column=175/mask="(ZZZ,ZZZ,ZZZ.99)"
lrsdetail:trans_date 
--""/column=95/heading="LOSS and LAE-Paid-Total"/mask="(ZZZ,ZZZ,ZZZ.99)"

--}

sorted by --sfsagent:agent_master_code/newpage/total/heading="@"
lrssetup:policy_no           
lrsdetail:claim_no/newlines/total  
          
include "reporttop.inc"
