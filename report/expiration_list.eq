/* sfspr050

   SCIPS.com

   August 14, 2002

   Expiration List by Agent
*/
description 
Prints the Policy Expiration List by Agent (Active Policies Only) - Enter Starting and Ending Date - - Report selects policies expiring between the Date Range Entered - Displays on screen and you can select the printer;

define string I_Name[50]=sfpname:name[1]

include "renaeq1.inc"

include "startend.inc" 
                            
where sfpname:exp_date => l_starting_date and
sfpname:exp_date <= l_ending_date and
sfpname:status = "CURRENT" and
--sfpname:pol_year = sfpcurrent:pol_Year 
sfpname:end_sequence = sfpcurrent:end_sequence and
sfpmaster:trans_code not one of 11
--and sfpname:policy_no one of 800000829 


list
/nobanner
/domain="sfpname"
/notitle    
/nopageheadings 
/noreporttotals                   
/pagewidth=100
/nodetail 
/pagelength=47

sfpname:policy_no/column=1/mask="ZZZZZZZZZ"/heading="Policy-Number"
i_rev_name/heading="Policy Holder" /column=11
sfpname:exp_date/mask="MM/DD/YYYY"/column=65/heading="Trans-Exp"
sfpname:line_of_business /mask="ZZ"/column=75/noheading 
sfsline_heading:description[1,30]/column=78/heading="Line of Business"/duplicates  

sorted by sfpname:agent_no /newpage
          sfpname:exp_date
          sfpname:policy_no 

end of sfpname:policy_no 
sfpname:policy_no/column=1/mask="ZZZZZZZZZ"/noheading 
i_rev_name/noheading/column=11
sfpname:exp_date/mask="MM/DD/YYYY"/column=65/noheading
sfpname:line_of_business /mask="ZZ"/column=75/noheading 
sfsline_heading:description[1,30]/column=78/noheading
/duplicates  

top of page                 
sfscompany:name[1]/noheading /column=20
pagenumber/heading="Page"/column=70/newline/mask="ZZZZ" 
if sfscompany:name[2] <> "" then
{
sfscompany:name[2]/noheading/column=20/newline
}      

if sfscompany:address[1] <> "" then
{
sfscompany:address[1]/noheading/column=20/newline
}       

if sfscompany:address[2] <> "" then
{
sfscompany:address[2]/noheading /column=20/newline          
}            

todaysdate/heading="Print Date"/mask="MM/DD/YYYY"/column=55
trun(sfscompany:city) + ", " + trun(sfscompany:str_state)/column=20 
sfscompany:str_zipcode/mask="XXXXX-XXXX"/column=35/noheading/newline=2
"POLICIES EXPIRING"/column=38/newline
trun(str(l_starting_date,"MM/DD/YYYY")) + " - " + trun(str(l_ending_date,
"MM/DD/YYYY"))/column=35/noheading/newline=2
               
"EXPIRATION LIST"/column=55/newline 
trun(sfsagent:name[1]) + " - " + str(sfsagent:agent_no)/noheading/column=1/newline
if sfsagent:name[2] <> "" then
{
sfsagent:name[2]/noheading/column=1/newline
}

if sfsagent:name[3] <> "" then
{
sfsagent:name[3]/noheading/column=1/newline 
}

if sfsagent:address[1] <> "" then
{
sfsagent:address[1]/noheading/column=1/newline 
}

if sfsagent:address[2] <> "" then
{
sfsagent:address[2]/noheading/column=1/newline 
}

if sfsagent:address[3] <> "" then
{
sfsagent:address[3]/noheading/column=1/newline 
}
trun(sfsagent:city) + ", " + trun(sfsagent:str_state)/column=1
sfsagent:str_zipcode/column=30/noheading/newline=2
