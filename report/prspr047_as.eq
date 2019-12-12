
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

include "prsunearned_ytd.inc"

include "prsunearned_prior.inc"

define string l_line_sort[150] = str(prsmaster:line_of_business) + " " + prsmaster:lob_subline + " " + sfsline:description 

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

l_current_written/heading="Monthly-Written-Premium"/column=100
l_unearned/heading="Monthly-Unearned-Premium"/column=120
l_unearned_ytd/heading="YTD-Unearned-Premium"/column=140
l_ytd_written/heading="YTD-Written-Premium"/column=160
l_unearned_prior/heading="Prior Period-Unearned-Premium"/column=180 

sorted by prsmaster:state/newpage
          sfsline:stmt_lob 
          l_Line_sort 
          l_eff_date 


top of prsmaster:state  
prsmaster:state/noheading /column=1
sfsstate:description/noheading/column=10/newline
"========================================================"

end of prsmaster:state 
""/newline 
"Total for State "/column=10 
total[l_current_written]/noheading/column=100
total[l_unearned]/noheading/column=120
total[l_unearned_ytd]/noheading/column=140
total[l_ytd_written]/noheading/column=160
total[l_unearned_prior]/noheading/column=180

end of l_eff_date 
if total[l_current_written] <> 0 then 
{
    l_eff_date/mask="ZZZZZZZZZ"/noheading/column=10 
    total[l_current_written]/noheading/column=100
    total[l_unearned]/noheading/column=120
    total[l_unearned_ytd]/noheading/column=140
    total[l_ytd_written]/noheading/column=160
    total[l_unearned_prior]/noheading/column=180
}

end of l_line_sort 
if total[L_current_written] <> 0 then 
box/noblanklines/noheadings 
l_line_sort/column=1/noheading
end box

top of sfsline:stmt_lob 
if total[l_current_written] <> 0 then 
box/noblanklines 
""/newline 
str(sfsline:stmt_lob ) + " " + sfsstmt:description/noheading/column=10
end box

end of sfsline:stmt_lob 
if total[l_current_written] <> 0 then 
{
box/noblanklines/noheadings 
    "Annual Statement " + str(sfsline:stmt_lob ) + " " + sfsstmt:description + " TOTAL"/noheading/column=20
    total[l_current_written]/noheading/column=100
    total[l_unearned]/noheading/column=120
    total[l_unearned_ytd]/noheading/column=140
    total[l_ytd_written]/noheading/column=160
    total[l_unearned_prior]/noheading/column=180
    end box
}
""/newline 

end of report                
""/newline=2
"Report Totals"/column=1
total[l_current_written]/noheading/column=100
total[l_unearned]/noheading/column=120
total[l_unearned_ytd]/noheading/column=140
total[l_ytd_written]/noheading/column=160
total[l_unearned_prior]/noheading/column=180

include "reporttop.inc"
""/newline 
sfsstate:description/column=1/noheading/newline
