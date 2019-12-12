list
/nobanner
/domain="sfsline2"
/noheadings 

if sfsline2:lob_subline one of "00" then 
{
    ""/newline/noheading 
}

sfsline2:Line_of_business 
sfsline2:lob_subline
sfsline2:exclude_from_contingent  
sfsline:description 

sorted by sfsline2:line_of_business lob_subline
