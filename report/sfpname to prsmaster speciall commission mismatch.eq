where sfpname:spec_comm_rate not one of 0 and sfpname:pol_year = 2012
and sfpname:line_of_business one of 8

list
/nobanner
/domain="sfpname"

sfpname:policy_no 
sfpname:spec_comm_rate 
sfpname:trans_date 
sfpname:eff_date 
sfpname:pol_year 
sfpname:end_sequence 

if prsmaster:pol_year = sfpname:pol_year and 
   prsmaster:end_sequence = sfpname:end_sequence and 
   sfsline:lob_code <> "BOILER" then 
{
prsmaster:policy_no 
prsmaster:comm_rate/heading="PREMIUMS-COMM-RATE"
prsmaster:line_of_business
prsmaster:lob_subline 
sfsline:description 
sfsline:lob_code 
}

sorted by sfpname:policy_no/newlines
