description Inforce Policies as of the date entered;

define wdate l_ending_date = parameter/prompt="Enter as of Date:"

define l_pos = pos("=",sfpname:name[1])

define string l_name_1 = sfpname:name[1,1,l_pos-1]
define string l_name_2 = sfpname:name[1,l_pos+1,len(sfpname:name[1])]
define string l_name[50] = trim(l_name_1) + " " + trim(l_name_2)

define l_pos2 = pos("=",sfpname:name[2])

define string l_name_1_dba = sfpname:name[2,1,l_pos2-1]
define string l_name_2_dba = sfpname:name[2,l_pos2+1,len(sfpname:name[2])]
define string l_name2_dba[50] = trim(l_name_2_dba) + " " + trim(l_name_2_dba)

define string l_fullname = trim(l_name) + " " + trim(l_name2_dba)

where sfpname:eff_date <= l_ending_date
and sfpname:status = "CURRENT"
and sfpname:exp_date => l_ending_date 

list
/nobanner
/domain="sfpname"
/title="G and G New and Renewal Policies"

sfpname:policy_no 
sfpname:eff_date 
sfpname:exp_date 
sfpname:status 

sorted by sfpname:policy_no
