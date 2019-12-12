viewpoint native;

include "startend.inc"

define file sfsstate1 = access sfsstate, set sfsstate:company_id= capvehicle:company_id, 
                                             sfsstate:state     = capvehicle:state,  
                                             sfsstate:county    = 0

define file sfsstate2 = access sfsstate, set sfsstate:company_id= capvehicle:company_id, 
                                             sfsstate:state     = capvehicle:state,  
                                             sfsstate:county    = capvehicle:county 
define unsigned ascii number l_rev_pos = pos("=",sfpname:name[1])

define string l_last_name = sfpname:name[1,1,l_rev_pos -1]
define string l_first_name = sfpname:name[1,l_rev_pos +1,len(sfpname:name[1])]

define unsigned ascii number l_rev_pos1 = pos("=",sfpname:name[2])

define string l_last_name1 = sfpname:name[2,1,l_rev_pos1 -1]
define string l_first_name1 = sfpname:name[2,l_rev_pos1 +1,len(sfpname:name[2])]

define file prscodea = access prscode, set prscode:company_id= capvehicle:company_id,
                                           prscode:trans_code = sfpname:trans_code 

where ((sfpname:trans_date => l_starting_date and 
        sfpname:trans_date <= l_ending_date and 
        sfpname:eff_date   <= l_ending_date) or 
       (sfpname:trans_date <  l_starting_date and 
        sfpname:eff_date   => l_starting_date and 
        sfpname:eff_date   <= l_ending_date))
and sfpname:trans_date => 11.20.2018 
and sfpname:eff_date   => 11.20.2018

list
/nobanner
/domain="capvehicle"
/duplicates 

  capvehicle:policy_no
sfpname:trans_date 
sfpname:eff_date 
sfpname:exp_date  
--sfpname:trans_code 
--prscodea:description 
--  capvehicle:pol_year 
--sfpmaster:form_of_business vehicle_symbol
--sfpname:name[1]/duplicates 
--l_rev_pos 
trim(l_first_name) + " " + trim(l_last_name)/heading="Name" 
--trim(l_first_name1) + " " + trim(l_last_name1)/heading="Name2" --l_last_name 
--sfpname:name[2]/duplicates 
--  capvehicle:end_sequence 
 capvehicle:state 
--  trun(sfsstate1:description) /noheading 
  capvehicle:county 
--  trun(sfsstate2:description) /noheading 
--  capvehicle:vehicle_no 
  capvehicle:year 
  capvehicle:make 
  capvehicle:serial_no 
--  capvehicle:original_cost /mask="(ZZZ,ZZZ,ZZZ.99)"
--  capvehicle:acv  
--  capvehicle:comp_deductible 
--  capvehicle:coll_deductible 
--  capvehicle:towing 
--  capvehicle:rental_days 
--  capvehicle:rental_amount
 -- capvehicle:additional_insured 
  --capvehicle:include_pip 
--  capvehicle:physical_damage_only

sorted by capvehicle:policy_no
