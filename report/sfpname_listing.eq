include "startend.inc"

where sfpname:eff_date => l_starting_date and 
      sfpname:eff_date <= l_ending_date and 
   (  sfplocation:pol_year = sfpcurrent:pol_year and 
      sfplocation:end_sequence = sfpcurrent:end_sequence )

list
/nobanner
/domain="sfpname"
/title="Policy Number Listing with Named Locations"

sfpname:policy_no 
sfpname:pol_year 
sfpname:end_sequence 
sfpname:eff_date 
sfpname:exp_date 
sfpname:name[1]/heading="Insured's Name"
sfplocation:prem_no
sfplocation:build_no 
sfplocation:address 
sfplocation:city 
sfplocation:str_state
trun(sfplocation:str_zipcode)/mask="XXXXX-XXXX"

include "reporttop.inc"
