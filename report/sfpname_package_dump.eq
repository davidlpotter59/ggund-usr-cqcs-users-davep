define wdate l_starting_date = 06.01.2016
define wdate l_ending_date   = 06.30.2016

where sfpname:trans_date => l_starting_date and
      sfpname:trans_date <= l_ending_date and  
      sfpname:line_of_business one of 8,11 and
      sfpname:convert_date <> 0
--and sfpname:policy_no one of 800001123
and sfppoint:converted <> "N"

list
/nobanner
/domain="sfpname"
/duplicates 
--/nodetail 
/noblanklines 

sfpname:policy_no /column=1
sfpname:agent_no/heading="Agent" /column=15
sfpname:line_of_business/column=25 /heading="Line"
sfsline_heading:description /width=20/column=35
sfpname:trans_date /column=60
sfplocation:policy_no/column=80 
sfplocation:prem_no/column=95
sfplocation:build_no/column=105 
sfppoint:converted /column=115

sorted by sfpname:agent_no/newpage  
          sfpname:policy_no 

top of page
box/noblanklines/noheadings 
sfpname:agent_no sfsagent:name[1]/newline 
xob

/*end of sfpname:policy_no 
box/noblanklines/noheadings 
 -- if count[sfplocation:policy_no] >2  then 
  {
    sfpname:policy_no/align=sfpname:policy_no 
    sfpname:agent_no/column=15
    sfpname:line_of_business/align=sfpname:Line_of_business 
    sfsline_heading:description /width=20/align=sfsline_heading:description 
    sfpname:trans_date /align=sfpname:trans_date 
    sfplocation:policy_no/align=sfplocation:policy_no 
    sfplocation:prem_no/align=sfplocation:prem_no 
    sfplocation:build_no/align=sfplocation:build_no 
    sfppoint:converted/align=sfppoint:converted 
  }
end box
*/
