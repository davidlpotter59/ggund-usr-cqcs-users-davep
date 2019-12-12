define wdate l_ending_date = parameter/prompt="Enter the As of Date " default todaysdate 
define date l_starting_date = dateadd(l_ending_date,0,-1) + 1

/* define variables to be written out */

define signed ascii number l_new_premium[9]=if
prsmaster:trans_code one of 10 then prsmaster:premium 
else
0.00

define signed ascii number l_cancel_premium[9]=if
prsmaster:trans_code one of 11 then prsmaster:premium
else
0.00

define signed ascii number l_increase_premium[9]=if
prsmaster:trans_code one of 12 then prsmaster:premium 
else
0.00

define signed ascii number l_decrease_premium[9]=if
prsmaster:trans_code one of 13 then prsmaster:premium 
else
0.00

define signed ascii number l_renewal_premium[9]=if
prsmaster:trans_code one of 14 then prsmaster:premium 
else
0.00

define signed ascii number l_audit_premium[9]=if
prsmaster:trans_code one of 15 then prsmaster:premium 
else
0.00

define signed ascii number l_reinstatement_premium[9]=if
prsmaster:trans_code one of 16 then prsmaster:premium 
else
0.00

--include "prscollect.inc"
where prsmaster:trans_exp > l_ending_date 
and prsmaster:trans_code < 17
and prsmaster:eff_date => 11.20.2018
and prsmaster:trans_date => 11.20.2018
and prsmaster:trans_eff <= l_ending_date
--and prsmaster:line_of_business one of 02

list
/nobanner
/nodetail
/nodefaults
/nopageheadings
/pagelength=0
/domain="prsmaster"

sorted by prsmaster:policy_no
       
end of prsmaster:policy_no 
box/noheadings                  
prsmaster:company_id/noheading/column=1/width=10/mask="X(10)"
prsmaster:policy_no/noheading/column=11/width=9/mask="999999999"
prsmaster:trans_code/noheading/column=20/mask="9999"/width=4
prsmaster:line_of_business/noheading/column=24/mask="9999"/width=4
total[l_new_premium]/noheading/column=28/mask="-99999999.99"/width=12
total[l_cancel_premium]/column=40/mask="-99999999.99"/width=12
total[l_increase_premium]/noheading/column=52/mask="-99999999.99"/width=12
total[l_decrease_premium]/noheading/column=64/mask="-99999999.99"/width=12
total[l_renewal_premium]/column=76/mask="-99999999.99"/width=12
total[l_reinstatement_premium]/noheading/column=88/mask="-99999999.99"/width=12
total[l_audit_premium]/noheading/column=100/mask="-99999999.99"/width=12
prsmaster:agent_no/column=112/mask="9999"/width=4
prsmaster:lob_subline/column=116/mask="XX"/width=2
prsmaster:eff_date/column=118/mask="MMDDYYYY"/width=8
prsmaster:exp_date/column=126/mask="MMDDYYYY"/width=8 
prsmaster:end_sequence/column=134/mask="9999"/width=4
--total[prsmaster:premium]/noheading/column=175/mask="-99999999.99"/width=12
end box
