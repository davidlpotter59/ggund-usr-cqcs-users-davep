viewpoint native;

where sfsline:line_of_business not one of 1, 4, 24,9,12,14 

list/nobanner/domain="sfsline"
  sfsline:line_of_business 
  sfsline:lob_subline 
  sfsline:description 
  sfsline:stmt_lob 
  sfsline:stmt_subline 
  sfsline:line_type 
  sfsline:business_type

sorted by  sfsline:line_of_business /newlines 
           sfsline:lob_subline
