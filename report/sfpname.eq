--where sfpname:policy_no one of 800001083, 800000266, 20537, 20382, 500000547,
--        120001021, 19289, 20292, 18655, 800002369, 500000995,510001011

--where sfpname:policy_no one of 120001021, 120001021, 197932012,
--        120001021, 600003171, 120000112, 11181,197932012

where sfpname:eff_date => 01.12.2019
and sfpname:trans_date => 01.12.2019
--and sfpname:agent_no one of 173

list
/banner 
/domain="sfpname"
--/nodetail 

sfpname:policy_no 
sfpname:name[1]
sfpname:agent_no 
sfpname:line_of_business 
status_date 
eff_date 
trans_date 
status 
trans_code 
previous_policy_no 
status 

sorted by sfpname:line_of_business /newlines 
sfpname:policy_no 

/*end of sfpname:policy_no 
box/noheadings 
    sfpname:policy_no 
sfpname:name[1]
sfpname:agent_no 
sfpname:line_of_business 
xob
*/
