viewpoint native;

where 
  sfsline2:lob_subline one of
    "00"
and sfsline2:line_of_business not one of 1,9,12,16,10,3,4,14,24

list/nobanner/domain="sfsline2"
  sfsline2:line_of_business 
  sfsline:description 
 -- sfsline2:lob_subline 
  sfsline2:additional_alpha_prefix /HEADING="Renewal Prefix-First Year"
  sfsline2:starting_date_with_new_company
