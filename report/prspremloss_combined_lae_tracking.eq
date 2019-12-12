define wdate l_starting_date = 01.01.2018
define wdate l_ending_date   = 04.30.2018

where (prspremloss_combined:start_date_yyyy = year(l_starting_date) and
       prspremloss_combined:start_date_mm   = month(l_starting_date) and
       prspremloss_combined:end_date_yyyy   = year(l_ending_date) and
       prspremloss_combined:end_date_mm     = month(l_ending_date))-- and
       --prspremloss_combined:line_of_business one of 9
--       prspremloss_combined:agent_no        > 0)

and sfsline:stmt_lob  <> 999
and (prspremloss_combined:alae_reserve_prior <> 0 or 
     prspremloss_combined:alae_reserve_current <> 0 or
     prspremloss_combined:ulae_reserve_prior <> 0 or 
     prspremloss_combined:ulae_reserve_current <> 0 )

list
/nobanner
/domain="prspremloss_combined"

prspremloss_combined:alae_reserve_prior /total 
prspremloss_combined:ulae_reserve_prior /total 
prspremloss_combined:alae_reserve_current /total 
prspremloss_combined:ulae_reserve_current /total
