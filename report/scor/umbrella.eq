include "startend.inc"

--where sfsline:lob_code  one of "UMBRELLA"
where ((sfpmaster:trans_date => l_starting_date and 
     sfpmaster:trans_date <= l_ending_date and 
     sfpmaster:trans_eff  <= l_ending_date ) or 
    (sfpmaster:trans_date < l_starting_date and 
     sfpmaster:trans_eff => l_starting_date and 
     sfpmaster:trans_eff <= l_ending_date))

list
/nobanner
/domain="cppumbrella"


cppumbrella:policy_no  occurrence general_aggregate products personal_add_injury
