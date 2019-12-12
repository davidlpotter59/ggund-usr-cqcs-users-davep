include "startend.inc"

find prspremloss_delos with prspremloss_delos:start_date_yyyy = year(l_starting_date) and 
                            prspremloss_delos:start_date_mm   = month(l_starting_date) and 
                            prspremloss_delos:end_date_yyyy   = year(l_ending_date) and 
                            prspremloss_delos:end_date_mm     = month(l_ending_date)
