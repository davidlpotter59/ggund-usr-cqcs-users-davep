
/*  prspr047

    SCIPS.com

    April 7, 2003

    Writtem, Unearned and Commissions Processed by Line of Business 
    and LOB Subline
*/

description 
Written, Unearned and Commissions Processed by Line of Business 
- Select Select Daily or Monthly Prorata for the unearned calculation ;

include "ending.inc"

define string l_prog_number = "PRSPR047 - Version 4.10"

include "prsunearned_current.inc"

define signed ascii number l_written_commission[9]=l_current_written * (
prsmaster:comm_rate * 0.01)/decimalplaces=2

define signed ascii number l_net_written = l_current_written - 
l_written_commission 

define signed ascii number l_unearned_commission[9]=l_unearned * (
prsmaster:comm_rate * 0.01)/decimalplaces=2

define signed ascii number l_net_unearned[9]=l_unearned - 
l_unearned_commission 

define unsigned ascii number l_eff_date = (year(prsmaster:trans_eff) * 100) + month(prsmaster:trans_eff)

include "prscollectu.inc"
and prsmaster:trans_code < 17 -- direct only
and sfsline:stmt_lob not one of 999 
--and prsmaster:lob_subline not one of "00"
--and prsmaster:line_of_business one of 5 
--and prsmaster:lob_subline one of "60"
and prsmaster:state > 0

list
/nobanner
/domain="prsmaster"
/title="Written, Unearned and Commissions Processed by Line of Business - No Detail (Summary Only)"
/nodetail                            
/nototals

l_current_written/heading="Written-Premium"/column=60
--l_current_written/heading="Written-Premium"/column=60
l_written_commission/heading="Written-Commissions"/column=80
l_net_written/heading="Net-Written-Premium"/column=100
l_unearned/heading="Unerned-Premium"/column=120
l_unearned_commission/heading="Unearned-Commissions"/column=140
l_net_unearned/heading="Net-Unearned-Premium"/column=160

sorted by --sfsline:stmt_lob /newlines 
          prsmaster:state/newpage
          prsmaster:line_of_business --/newlines 
          prsmaster:lob_subline
          l_eff_date 


/*
top of sfsline:stmt_lob 
sfsline:stmt_lob/noheading /column=1
sfsstmt:description/noheading/column=10/newline
"========================================================"
*/
/*
end of sfsline:stmt_lob                        
""/newline 
"Total for Statement "/column=10 
total[l_current_written]/noheading/column=60
total[l_written_commission]/noheading/column=80
total[l_net_written]/noheading/column=100
total[l_unearned]/noheading/column=120
total[l_unearned_commission]/noheading/column=140
total[l_net_unearned]/noheading/column=160
*/
  

top of prsmaster:state  
prsmaster:state/noheading /column=1
sfsstate:description/noheading/column=10/newline
"========================================================"


/*top of prsmaster:line_of_business
prsmaster:line_of_business/noheading /column=5
sfsline_heading:description/noheading/column=10                              
*/

end of prsmaster:state 
""/newline 
"Total for State "/column=10 
total[l_current_written]/noheading/column=60
total[l_written_commission]/noheading/column=80
total[l_net_written]/noheading/column=100
total[l_unearned]/noheading/column=120
total[l_unearned_commission]/noheading/column=140
total[l_net_unearned]/noheading/column=160

end of l_eff_date 
if total[l_current_written] <> 0 then 
{
    l_eff_date/mask="ZZZZZZZZZ"/noheading/column=10 
    total[l_current_written]/noheading/column=60
    total[l_written_commission]/noheading/column=80
    total[l_net_written]/noheading/column=100
    total[l_unearned]/noheading/column=120
    total[l_unearned_commission]/noheading/column=140
    total[l_net_unearned]/noheading/column=160
}

/* end of prsmaster:line_of_business                                    
--""/newline 
--"Total of Line of Business"/column=10
prsmaster:line_of_business/noheading /column=5
sfsline_heading:description/noheading/column=10
total[l_current_written,prsmaster:line_of_business]/noheading/column=60
total[l_written_commission,prsmaster:line_of_business]/noheading/column=80
total[l_net_written,prsmaster:line_of_business]/noheading/column=100
total[l_unearned,prsmaster:line_of_business]/noheading/column=120
total[l_unearned_commission,prsmaster:line_of_business]/noheading/column=140
total[l_net_unearned,prsmaster:line_of_business]/noheading/column=160
*/

end of prsmaster:lob_subline 
if total[l_current_written] <> 0 then 
{
box/noblanklines/noheadings 
str(prsmaster:line_of_business) + " " + prsmaster:lob_subline + " " + sfsline:description/noheading/column=1
total[l_current_written,prsmaster:lob_subline]/noheading/column=60
total[l_written_commission,prsmaster:lob_subline]/noheading/column=80
total[l_net_written,prsmaster:lob_subline]/noheading/column=100
total[l_unearned,prsmaster:lob_subline]/noheading/column=120
total[l_unearned_commission,prsmaster:lob_subline]/noheading/column=140
total[l_net_unearned,prsmaster:lob_subline]/noheading/column=160
end box
}

end of report                
""/newline=2
"Report Totals"/column=1
total[l_current_written]/noheading/column=60
total[l_written_commission]/noheading/column=80
total[l_net_written]/noheading/column=100
total[l_unearned]/noheading/column=120
total[l_unearned_commission]/noheading/column=140
total[l_net_unearned]/noheading/column=160

include "reporttop.inc"
""/newline 
sfsstate:description/column=1/noheading/newline
