include "startend.inc"

define unsigned ascii number l_state = parameter/prompt="Enter State"

where sfssurcharge:state = l_state and 
      sfssurcharge:eff_date => l_starting_date 

list
/nobanner
/domain="sfssurcharge"
/nodefaults 

sfssurcharge:state 
sfssurcharge:line_of_business 
sfsline_heading:description 
sfssurcharge:eff_date 
sfssurcharge:surcharge_factor

sorted by sfssurcharge:state 
          sfssurcharge:line_of_business /newlines 
          sfssurcharge:eff_date 

include "reporttop.inc"
