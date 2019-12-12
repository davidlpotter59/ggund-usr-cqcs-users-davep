include "startend.inc"
--define file sfqnamea = access sfqname, set sfqname:quote_no= agqname:quote_no 

define unsigned ascii number l_converted_to_quote = if applications_hold:quote_no <> 0 then 1 else 0
define unsigned ascii number l_converted_to_policy = if applications_hold:policy_no <> 0 then 1 else 0
define unsigned ascii number l_applications = if applications_hold:app_no <> 0 then 1 else 0

define file sfsagenta = access sfsagent, set sfsagent:company_id= "GGUND     ",
                                             sfsagent:agent_no= applications_hold:agent_no 

--define file agqcontractora = access agqcontractor, set agqcontractor:app_no= agqname:app_no, generic 
--define file agqvehiclea    = access agqvehicle, set agqvehicle:app_no= agqname:app_no, generic 
--define file agqgenerala    = access agqgeneral, set agqgeneral:app_no=agqname:app_no, generic 
define file sfsline_headinga = access sfsline_heading, set sfsline_heading:company_id= "GGUND     ",
                                                           sfsline_heading:line_of_business= applications_hold:line_of_business,
                                                           sfsline_heading:lob_subline= "00"
define file sfscompanya    = access sfscompany, set sfscompany:company_id= "GGUND     ", exact 

define string l_prog_number = "Application_Tracking_List 7.70"

where applications_hold:agent_no not one of 0,9999
--and (applications_hold:trans_date => l_starting_date and 
 --     applications_hold:trans_date <= l_ending_date)
--and (applications_hold:app_no <> 0 and applications_hold:quote_no = 0 ))
--and app_no one of 7577
 
list
/nobanner
/domain="applications_hold"
/title="Agent's Quote Activity List Version 7.70"

if applications_hold:app_no <> 0 then 
  {  
    applications_hold:app_no/heading="App-No" /mask="ZZZZZZ"
  }
  else
  {
  if applications_hold:quote_no <> 0 then 
  { 
    "INHOUSE"
  }
  }

applications_hold:agent_no /heading="Agent-No"  
applications_hold:quote_no /heading="Quote-No"
--agqname:policy_no /heading="Policy-No"
applications_hold:policy_no/heading="Policy-No"
--agqname:eff_date
applications_hold:eff_date /heading="Eff-Date"
--agqname:trans_date 
applications_hold:trans_date /heading="Trans-Date" 
applications_hold:line_of_business 
sfsline_headinga:description 

sorted by applications_hold:agent_no/newlines 

end of applications_hold:agent_no 
box/noblanklines/noheadings 
  "TOTAL Applications  "  total[l_applications ]
  if total[l_converted_to_quote] => 0 then 
  {  
     "TOTAL Quotes  "
     total[l_converted_to_quote ]/mask="ZZZ9" 
     "TOTAL Policies  "
     total[l_converted_to_policy ]/mask="ZZZ9" 
  }
end box 

top of applications_hold:agent_no 
box/noblanklines/noheadings 
   applications_hold:agent_no /mask="ZZZZ"
   "  "
   sfsagenta:name[1]/newline 
end box

top of page  
L_prog_number                    /heading="Report No      "/column=1/newline 
trun(sfscompanya:name[1])/column=1/heading="Company Name   "/newline  
trun(str(l_starting_date,"MM/DD/YYYY") + " - " + str(l_ending_date,"MM/DD/YYYY"))/column=1/heading=
"Report Period  "/newline

end of report 
""/newline=2
box/noblanklines/noheadings 

    "TOTAL Applications  "  total[l_applications ]  total[l_applications ]
  if total[l_converted_to_quote] => 0 then 
  {  
     "TOTAL Quotes  "
     total[l_converted_to_quote ]/mask="ZZZ9" 
     "TOTAL Policies  "
     total[l_converted_to_policy ]/mask="ZZZ9" 
  }
end box
