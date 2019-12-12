/*  prspr097

    scips.com, inc.
    
    Direct premiums Annual Statement Sort - excel output of prspr078

    january 18, 2004
    added commission cols april 11, 2005
    added AC/DB Commissions breakdown at the end of the report  - February 1, 2011 - DLP
*/

description 
Spreadsheet output of the Direct (Transaction Codes Less than) Premium Report (Written and Unearned).  Sorted by Annual Statement Line of Business.  There will be totals for each of the sorts. By Agent Code;

include "ending.inc" 

string l_prog_number = "PRSPR097 - Version 7.22a"

/* get january 1, of the ending date year */

include "prsunearned_current.inc"  

include "prsunearned_ytd.inc"    

include "prsunearned_prior.inc" 

include "prsunearned_total.inc"       

define l_earned[11]=l_unearned_prior + 
                    l_ytd_written - 
                    l_unearned_total /decimalplaces=2

define l_commission_written[11]=if prsmaster:comm_rate <> 0 then 
l_current_written * (prsmaster:comm_rate * 0.01)
else
0/decimalplaces=2

define l_commission_unearned[11]=if prsmaster:comm_rate <> 0 then 
l_unearned * (prsmaster:comm_rate * 0.01)
else
0/decimalplaces=2

l_net_written[11]=l_current_written - l_commission_written/decimalplaces=2
l_net_unearned[11]=l_unearned - l_commission_unearned/decimalplaces=2

include "prscollectu.inc"
and prsmaster:trans_code < 17 -- direct only
and sfsline:stmt_lob not one of 999 
--and sfsagent:agent_master_code  one of 173
--and sfsline2:exclude_from_contingent not one of 1

list
/nobanner
/domain="prsmaster"
/title="Direct Premiums Written and Unearned - by Agent"
/nodetail
--/pagewidth=250
/noreporttotals 
--/pagelength=0
--/xls

sfsline:stmt_lob/heading="Statment-Line-of Business"/column=1
sfsstmt:description/heading="Description"/column=15/width=20         
l_unearned_prior/heading="Prior-Period-Unearned"/column=50
l_current_written/heading="Month Of-Written-Premium"/column=70
l_unearned/heading="Month Of-Unearned-Premium"/column=90
l_YTD_written/heading="YTD-Premium"/column=110
l_unearned_total/heading="Unearned-Premium-Total"/column=130 
l_earned/heading="YTD-Earned-Premium"/column=150
l_commission_written/heading="Month Of-Written-Commissions"/column=170
l_commission_unearned/heading="Month Of-Unearned-Commissions"/column=190
l_YTD_commission/heading="YTD-Written-Commissions"/column=210
l_unearned_ytd/heading="Unearned-Premium-YTD"/column=230

sorted by  prsmaster:agent_no/newpage 
           sfsline:stmt_lob 
           prsmaster:line_of_business/newlines 
           prsmaster:lob_subline 

include "reporttop.inc"  
""/newline 
prsmaster:agent_no 
sfsagent:name[1]/newline=2/noheading 

Top of sfsline:stmt_lob 
sfsline:stmt_lob/column=1/noheading                                
sfsstmt:description/column=10/width=20/noheading 
if sfsline:stmt_lob = 0 then 
{
   "Record Coding Error"/column=1
}

end of sfsline:stmt_lob 
""/newline 
"Total for Statement Line"/column=15
total[l_unearned_prior,sfsline:stmt_lob]/column=50/mask=
"ZZ,ZZZ,ZZZ,ZZZ.99-"                           
total[l_current_written,sfsline:stmt_lob]/column=70/mask=
"ZZ,ZZZ,ZZZ,ZZZ.99-"
total[l_unearned,sfsline:stmt_lob]/column=90/mask=
"ZZ,ZZZ,ZZZ,ZZZ.99-"
total[l_ytd_written,sfsline:stmt_lob]/column=110/mask=
"ZZ,ZZZ,ZZZ,ZZZ.99-"
total[l_unearned_total,sfsline:stmt_lob]/column=130/mask=
"ZZ,ZZZ,ZZZ,ZZZ.99-"
total[l_earned,sfsline:stmt_lob]/column=150/mask=
"ZZ,ZZZ,ZZZ,ZZZ.99-"
total[l_commission_written]/column=170/mask="ZZ,ZZZ,ZZZ,ZZZ.99-"
total[l_commission_unearned]/column=190/mask="ZZ,ZZZ,ZZZ,ZZZ.99-"
total[l_YTD_commission,sfsline:stmt_lob]/column=210/mask="ZZ,ZZZ,ZZZ,ZZZ.99-"
total[l_unearned_ytd,sfsline:stmt_lob]/column=230/mask="ZZ,ZZZ,ZZZ,ZZZ.99-"

top of prsmaster:line_of_business 
prsmaster:line_of_business/column=15/noheading 
sfsline_heading:description/column=20/width=20/noheading                                

end of prsmaster:line_of_business 
""/newline 
"Total for Line of Business"/column=20
total[l_unearned_prior]/column=50/mask="ZZ,ZZZ,ZZZ,ZZZ.99-"                           
total[l_current_written]/column=70/mask="ZZ,ZZZ,ZZZ,ZZZ.99-"
total[l_unearned]/column=90/mask="ZZ,ZZZ,ZZZ,ZZZ.99-"
total[l_ytd_written]/column=110/mask="ZZ,ZZZ,ZZZ,ZZZ.99-"
total[l_unearned_total]/column=130/mask="ZZ,ZZZ,ZZZ,ZZZ.99-"
total[l_earned]/column=150/mask="ZZ,ZZZ,ZZZ,ZZZ.99-"
total[l_commission_written]/column=170/mask="ZZ,ZZZ,ZZZ,ZZZ.99-"
total[l_commission_unearned]/column=190/mask="ZZ,ZZZ,ZZZ,ZZZ.99-"
total[l_YTD_commission]/column=210/mask="ZZ,ZZZ,ZZZ,ZZZ.99-"
total[l_unearned_ytd]/column=230/mask="ZZ,ZZZ,ZZZ,ZZZ.99-"

end of prsmaster:lob_subline 
prsmaster:lob_subline/column=20/noheading 
sfsline:description/column=25/width=20/noheading                                
total[l_unearned_prior]/column=50/mask="ZZ,ZZZ,ZZZ,ZZZ.99-"                           
total[l_current_written]/column=70/mask="ZZ,ZZZ,ZZZ,ZZZ.99-"
total[l_unearned]/column=90/mask="ZZ,ZZZ,ZZZ,ZZZ.99-"
total[l_ytd_written]/column=110/mask="ZZ,ZZZ,ZZZ,ZZZ.99-"
total[l_unearned_total]/column=130/mask="ZZ,ZZZ,ZZZ,ZZZ.99-"
total[l_earned]/column=150/mask="ZZ,ZZZ,ZZZ,ZZZ.99-"
total[l_commission_written]/column=170/mask="ZZ,ZZZ,ZZZ,ZZZ.99-"
total[l_commission_unearned]/column=190/mask="ZZ,ZZZ,ZZZ,ZZZ.99-"
total[l_YTD_commission]/column=210/mask="ZZ,ZZZ,ZZZ,ZZZ.99-"
total[l_unearned_ytd]/column=230/mask="ZZ,ZZZ,ZZZ,ZZZ.99-"

end of report 
""/newline=2
"GRAND TOTALS"/column=20
total[l_unearned_prior]/column=50/mask=
"ZZ,ZZZ,ZZZ,ZZZ.99-"
total[l_current_written]/column=70/mask=
"ZZ,ZZZ,ZZZ,ZZZ.99-"
total[l_unearned]/column=90/mask=
"ZZ,ZZZ,ZZZ,ZZZ.99-"
total[l_ytd_written]/column=110/mask=
"ZZ,ZZZ,ZZZ,ZZZ.99-"
total[l_unearned_total]/column=130/mask=
"ZZ,ZZZ,ZZZ,ZZZ.99-"
total[l_earned]/column=150/mask=
"ZZ,ZZZ,ZZZ,ZZZ.99-"
total[l_commission_written]/column=170/mask="ZZ,ZZZ,ZZZ,ZZZ.99-"
total[l_commission_unearned]/column=190/mask="ZZ,ZZZ,ZZZ,ZZZ.99-"
total[l_YTD_commission]/column=210/mask="ZZ,ZZZ,ZZZ,ZZZ.99-"
total[l_unearned_ytd]/column=230/mask="ZZ,ZZZ,ZZZ,ZZZ.99-"
""/newline=2
--total[l_ytd_ac_commission]/column=1/heading="YTD Account Current Commissions"/mask="ZZ,ZZZ,ZZZ,ZZZ.99-"/newline
--total[l_ytd_db_commission]/column=1/heading="YTD Direct Bill Commissions    "/mask="ZZ,ZZZ,ZZZ,ZZZ.99-"/newline
