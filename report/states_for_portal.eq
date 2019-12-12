where sfpname:status one of "CURRENT"
and sfpname:exp_date > todaysdate 
and prsmaster:state one of 37,07

list
/nobanner
/domain="prsmaster"
/nodetail 

prsmaster:policy_no 
prsmaster:state 
sfpname:eff_date 
sfpname:line_of_business 
sfsline:description 

sorted by prsmaster:state 
          prsmaster:line_of_business 
          prsmaster:policy_no 

end of prsmaster:policy_no 
box/noblanklines/noheadings 
   prsmaster:policy_no/align=prsmaster:policy_no  
   prsmaster:state /align=prsmaster:state 
   sfpname:eff_date/align=sfpname:eff_date 
   sfpname:line_of_business /align=sfpname:line_of_business 
   sfsline:description /align=sfsline:description 
end box
