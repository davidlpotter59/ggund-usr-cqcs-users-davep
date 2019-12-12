
include "startend.inc"

define string l_Prog_number ="Exclude from Contingent"

list
/nobanner
/domain="sfsline2"
/pagelength=0

if sfsline2:lob_subline one of "00" then
{
   sfsline2:line_of_business /column=1
}

if sfsline2:lob_subline not one of "00" then 
{
   sfsline2:lob_subline /column=15 
}

if sfsline2:lob_subline one of "00" then 
{
    sfsline:description /column=15/noheading 
}
else
{
    sfsline:description/column=20/noheading 
}
--sfsline2:lob_subline 
if sfsline2:lob_subline not one of "00" then 
{
    if sfsline2:exclude_from_contingent one of 1 then 
    { "YES"/heading="Exclude" } else { " NO" } 
}

sorted by sfsline2:company_id line_of_business/newlines  lob_subline

--include "reporttop.inc"
