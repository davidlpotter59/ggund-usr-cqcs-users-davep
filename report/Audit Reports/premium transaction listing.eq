

include "startend.inc"
define string l_prog_number = "PRSLISTING"

/*define file sfsline_alias = access sfsline,
                               set sfsline:company_id       = prsmaster:company_id ,
                                   sfsline:line_of_business = prsmaster:line_of_business,
                                   sfsline:lob_subline      = "00"
*/
define file sfpname_alias = access sfpname,
                               set sfpname:policy_no = prsmaster:policy_no,
                                   sfpname:pol_year  = prsmaster:pol_year, 
                                   sfpname:end_sequence= prsmaster:end_sequence, approximate  
  
define file sfpnamea = access sfpname,
                               set sfpname:policy_no = prsmaster:policy_no, generic 

define file sfpname_delos_alias= access sfpname_delos,
                                    set sfpname_delos:policy_no= prsmaster:policy_no , 
                                        sfpname_delos:pol_year   = prsmaster:pol_year,
                                        sfpname_delos:end_sequence= prsmaster:end_sequence, approximate 
                                    
define string l_data_source=if prsmaster:eff_date < 07.01.2007 and prsmaster:trans_date < 06.01.2007 then "OLD System Data" else
"SCIPS Data"

define string l_data_source_flag=if prsmaster:eff_date < 07.01.2007 and prsmaster:trans_date < 06.01.2007 then "OLD" else
"SCIPS"

define string l_date_range = str(l_starting_date) + "-" + str(l_ending_date)

where (prsmaster:trans_date => l_starting_date and 
       prsmaster:trans_date <= l_ending_date) and 
       prsmaster:trans_code < 17 and 
       prsmaster:premium <> 0

list
/nobanner
/domain="prsmaster"
/duplicates 
/title="Premium Transaction Data Listing by Policy Number"
--/maxpages=10
--12/xls="Trans List"

l_data_source_flag /heading="Data-Source"
prsmaster:policy_no 
prsmaster:pol_year 
prsmaster:end_sequence
if sfpname_alias:name[1] <> "" then
  {
    sfpname_alias:name[1]/heading="Insured's Name"
  }
else if sfpname_delos_alias:name[1] <> "" then
  {
    sfpname_delos_alias:name[1]/noheading
  } 
/*
else if sfpnamea:name[1] <> "" then
  {
    sfpnamea:name[1]/heading="Insured's Name"
  }
*/

prsmaster:trans_date 
prsmaster:eff_date 
prsmaster:exp_date 
prsmaster:trans_code 
prscode:description 
prsmaster:premium/mask="(ZZZ,ZZZ,ZZZ,ZZZ.99)" 

sorted by l_data_source/heading="@" /total/newpage 
          prscode:description /total/newlines=2/heading="@"
          prsmaster:trans_date
          prsmaster:policy_no 
          prsmaster:trans_date

include "reporttop.inc"
""/newline 
l_data_source/heading="Data Was Generated Using"
""/newline
