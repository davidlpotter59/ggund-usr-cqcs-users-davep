define wdate L_ending_date = parameter /prompt="Enter As of Date" default todaysdate 
define wdate l_starting_date = dateadd(01.01.0000,month(l_ending_date),year(l_ending_date)-1)

where sfpname:status not one of "EXPIRED", "CANCELLED", "NONRENEWED"
and sfpname:status_date => l_starting_date 
and sfpname:status_date <= l_ending_date 
and (sfpname:eff_date => l_starting_date  and 
     sfpname:eff_date <= l_ending_date )

sum
/title="Summary Policy Count by Line of Business"
/nobanner
/domain="sfpname"
/count
--/noreporttotals 

sfpname:units /heading="Inforce-Count"

by sfsline_heading:description 

include "reporttop.inc"
