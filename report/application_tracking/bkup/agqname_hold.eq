define wdate l_start_date_default = dateadd(01.01.0000,00,year(todaysdate))
define wdate l_end_date_default   = dateadd(01.01.0000,month(todaysdate)-1,year(todaysdate))-1
define wdate l_starting_date = parameter/prompt="Enter Starting Date" default l_start_date_default 
define wdate l_ending_date   = parameter/prompt="Enter Ending Date" default l_end_date_default 

where agqname:agent_no not one of 0,9999
and (agqname:trans_date => l_starting_date and 
      agqname:trans_date <= l_ending_date)

list
/domain="agqname"
--/hold="applications_hold"

agqname:app_no 
agqname:quote_no 
agqname:policy_no 
agqname:trans_date 
agqname:eff_date 
agqname:exp_date
agqname:line_of_business
agqname:agent_no
