include "startend.inc"

find prspremloss_starr with prspremloss_starr:start_date_yyyy = year(l_starting_date) and 
                            prspremloss_starr:start_date_mm   = month(l_starting_date) and 
                            prspremloss_starr:end_date_yyyy   = year(l_ending_date) and 
                            prspremloss_starr:end_date_mm     = month(l_ending_date)
