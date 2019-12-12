define string l_new_prefix = replace(sfsline:alpha,"AX","GS")

where sfsline:line_of_business not one of 1,2,3,4,14,12,10,24,9 --and lob_subline = "00"
--and sfsline:lob_subline = "00"

list
/nobanner
/domain="sfsline"

--company_id 
sfsline:line_of_business 
--sfsline:alpha 
--l_new_prefix /heading="New Alpha Prefix"
--lob_code 
--claim_alpha
sfsline:lob_subline 
sfsline:stmt_lob 
sfsline:description 

sorted by sfsline:line_of_business/newlines  lob_subline
