--where sfsline:lob_code one of "BOILER" and sfsline2:iso_stmt_lob <> ""

where sfsline2:line_of_business one of 5,8,11,50,51
and sfsline2:lob_subline one of "00","40"

list
/nobanner
/domain="sfsline2"

if sfsline2:lob_subline one of "00" then 
{
  sfsline2:line_of_business
}
 
if sfsline2:lob_subline not one of "00" then
{
  sfsline2:lob_subline 
}
sfsline:description 
sfsline2:iso_stmt_lob 

sorted by sfsline2:line_of_business /newlines 
          sfsline2:lob_subline
