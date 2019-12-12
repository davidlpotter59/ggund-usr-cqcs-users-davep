
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
and prsmaster:state = 29

list
/nobanner
/domain="prsmaster"
/title="Written, Unearned and Commissions Processed by Line of Business - No Detail (Summary Only)"
/nodetail                            
/nototals

l_current_written/heading="Written-Premium"/column=60
l_unearned/heading="Unerned-Premium"/column=80

sorted by prsmaster:state/newpage
          prsmaster:line_of_business --/newlines 
          prsmaster:lob_subline
          l_eff_date 


top of prsmaster:state  
prsmaster:state/noheading /column=1
sfsstate:description/noheading/column=10/newline
"========================================================"

end of prsmaster:state 
""/newline 
"Total for State "/column=10 
total[l_current_written]/noheading/column=60
total[l_unearned]/noheading/column=120
end of l_eff_date 
if total[l_current_written] <> 0 then 
{
    l_eff_date/mask="ZZZZZZZZZ"/noheading/column=10 
    total[l_current_written]/noheading/column=60
    total[l_unearned]/noheading/column=80
}

top of prsmaster:lob_subline
if total[l_current_written] <> 0 then 
box/noblanklines 
""/newline 
str(prsmaster:line_of_business) + " " + prsmaster:lob_subline + " " + sfsline:description/noheading/column=10
end box

end of prsmaster:lob_subline 
if total[l_current_written] <> 0 then 
{
box/noblanklines/noheadings 
str(prsmaster:line_of_business) + " " + prsmaster:lob_subline + " " + sfsline:description + " TOTAL"/noheading/column=20
total[l_current_written,prsmaster:lob_subline]/noheading/column=60
total[l_unearned,prsmaster:lob_subline]/noheading/column=80
end box
}
""/newline 

end of report                
""/newline=2
"Report Totals"/column=1
total[l_current_written]/noheading/column=60
total[l_unearned]/noheading/column=80
include "reporttop.inc"
""/newline 
sfsstate:description/column=1/noheading/newline
