include "startend.inc"

where sfpname:eff_date => l_starting_date and 
      sfpname:eff_date <= l_ending_date and 
   (  sfplocation:pol_year = sfpcurrent:pol_year and 
      sfplocation:end_sequence = sfpcurrent:end_sequence )
and sfpname:status = "CURRENT"

list
/nobanner
/domain="sfpname"
/title="Policy Number Listing with Named Locations"
/nodetail 

sfpname:policy_no 
sfpname:pol_year 
sfpname:end_sequence 
sfpname:eff_date 
sfpname:exp_date 
sfpname:name/heading="Insured's Name"/tag="name"
sfpname:address 
sfpname:city 
sfpname:str_state
trun(sfpname:str_zipcode)/mask="XXXXX-XXXX"/name="zipcode"
sfpname:status 

sorted by sfpname:policy_no 

end of sfpname:policy_no 
box/noblanklines/noheadings 
  sfpname:policy_no /align=policy_no 
  sfpname:pol_year /align=sfpname:pol_year 
  sfpname:end_sequence /align=sfpname:end_sequence 
  sfpname:eff_date /align=sfpname:eff_date 
  sfpname:exp_date /align=sfpname:exp_date 
  sfpname:name/align=sfpname:name 
  sfpname:address /align=sfpname:address 
  sfpname:city /align=sfpname:city 
  sfpname:str_state/align=sfpname:str_state 
  if str_zipcode[6,9]<> "0000" then 
  {
    trun(sfplocation:str_zipcode)/mask="XXXXX-XXXX"/align=zipcode 
  }
  else
  {
    trun(sfplocation:str_zipcode[1,5])/mask="XXXXX"/align=zipcode
  }
  sfpname:status /align=sfpname:status 
end box 

include "reporttop.inc"
