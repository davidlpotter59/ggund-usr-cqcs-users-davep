define unsigned ascii number l_new = if prsmaster:trans_code one of 10 then 1 else 0
define unsigned ascii number l_cx  = if prsmaster:trans_code one of 11 then -1 else 0
define unsigned ascii number l_renew = if prsmaster:trans_code one of 14 then 1 else 0
define unsigned ascii number l_reinstate = if prsmaster:trans_code one of 15 then 1 else 0


where prsmaster:eff_date => 12.01.2018
and prsmaster:eff_date <= 12.31.2018
and prsmaster:trans_code one of 10,11,14,16
and prsmaster:line_of_business one of 6


list
/nobanner
/domain="prsmaster"
--/nodetail 
/noreporttotals 

prsmaster:policy_no 
prsmaster:line_of_business 
--prsmaster:trans_eff 
--prsmaster:eff_date 
--prsmaster:trans_code 
--prscode:description /duplicates 
l_new/heading="New"
l_cx/heading="CX"
l_renew /heading="Renewal"
l_reinstate/heading="Reinstate"

sorted by prsmaster:line_of_business /newlines 
          prsmaster:policy_no 

end of prsmaster:line_of_business  
box/noblanklines /noheadings 
 -- prsmaster:policy_no 
  prsmaster:line_of_business 
--  l_new /align=l_new 
--l_cx/align=l_cx
--  l_renew/align=l_renew
--  l_reinstate/align=l_reinstate 
end box

end of prsmaster:policy_no 
box/noblanklines /noheadings 
  prsmaster:policy_no 
  prsmaster:line_of_business 
  l_new /align=l_new 
  l_cx /align=l_cx
  l_renew /align=l_renew
  l_reinstate /align=l_reinstate 
end box
