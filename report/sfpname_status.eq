define wdate L_ending_date = parameter /prompt="Enter As of Date" default todaysdate 
define wdate l_starting_date = dateadd(01.01.0000,month(l_ending_date),year(l_ending_date)-1)

where sfpname:status not one of "EXPIRED", "CANCELLED", "NONRENEWED"
and sfpname:status_date => l_starting_date 
and sfpname:status_date <= l_ending_date 
and (sfpname:eff_date => l_starting_date  and 
     sfpname:eff_date <= l_ending_date )

list
/title="Policy Count by Line of Business and Policy Number - Detailed"
/nobanner
/domain="sfpname"
/count

sfpname:policy_no
sfpname:status 
sfpname:status_date 
sfpname:line_of_business 
sfsline_heading:description /duplicates 

sorted by sfsline_heading:description /heading="@" /newlines/count
          sfpname:policy_no
