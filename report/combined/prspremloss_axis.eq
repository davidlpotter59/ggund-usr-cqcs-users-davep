include "startend.inc"

find prspremloss with prspremloss:start_date_yyyy = year(l_starting_date) and 
                      prspremloss:start_date_mm   = month(l_starting_date) and 
                      prspremloss:end_date_yyyy   = year(l_ending_date) and 
                      prspremloss:end_date_mm     = month(l_ending_date)
