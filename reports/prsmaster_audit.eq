description Prmeium policy number, trans_date, trans_eff and type (new or renewal);

include "startend.inc"

define string l_type = switch(prsmaster:trans_code)
case 10 : "New Policies"
case 14 : "Renewal Policies"
default : "All other policies"

define l_pos = pos("=",sfpname:name[1])

define string l_name_1 = sfpname:name[1,1,l_pos-1]
define string l_name_2 = sfpname:name[1,l_pos+1,len(sfpname:name[1])]
define string l_name[50] = trim(l_name_1) + " " + trim(l_name_2)

define l_pos2 = pos("=",sfpname:name[2])

define string l_name_1_dba = sfpname:name[2,1,l_pos2-1]
define string l_name_2_dba = sfpname:name[2,l_pos2+1,len(sfpname:name[2])]
define string l_name2_dba[50] = trim(l_name_2_dba) + " " + trim(l_name_2_dba)

define string l_fullname = trim(l_name) + " " + trim(l_name2_dba)

where prsmaster:trans_date => l_starting_date and 
      prsmaster:trans_date <= l_ending_date  and
      prsmaster:trans_code one of 10,14

list
/nobanner
/domain="prsmaster"
/title="G and G New and Renewal Policies"
/nodetail 

prsmaster:policy_no 
sfpname:name[1]/name="name2"
l_fullname /name="name"/heading="Insured Name"
prsmaster:trans_eff 
prsmaster:eff_date

sorted by l_type /newpage 
          prsmaster:policy_no   

include "reporttop.inc"
""/newline 
box/noheadings
   "Policy Transaction: " + l_type 
   ""/newline 
end box 

end of prsmaster:policy_no   
box/noheadings/noblanklines 
   prsmaster:policy_no/align=prsmaster:policy_no 
   sfpname:name[1]/align=name2
   l_fullname/align=name 
   prsmaster:trans_eff/align=prsmaster:trans_eff 
   prsmaster:eff_date/align=prsmaster:eff_date 
end box
