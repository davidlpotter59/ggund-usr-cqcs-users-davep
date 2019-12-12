define string l_axis_lob = str(sfsline:line_of_business)+sfsline:lob_subline 

where sfsline:line_of_business not one of 14,12,3,4,1,24,10 
and sfsline:lob_subline not one of "00"


list
/nobanner
/domain="sfsline"

sfsline:stmt_lob 
sfsline:line_of_business 
sfsline:lob_subline 
l_axis_lob/heading="AXIS-LOB"
sfsline:description 

sorted by sfsline:stmt_lob /newlines 
          sfsline:line_of_business 
          sfsline:lob_subline
