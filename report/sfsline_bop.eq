where sfsline:line_of_business not one of 1, 3, 4, 10, 12, 14, 24, 40
--and (sfsline:line_of_business one of 5,50,51,52 or sfsline:lob_code one of "XBOP")

list
/nobanner
/domain="sfsline"

if sfsline:lob_subline <> "00"
then 
{
  sfsline:line_of_business  
  sfsline:lob_subline 
  sfsline:description 
  sfsline:lob_code
  sfsline:bureau_lob 
  sfsline:stmt_lob 
  sfsline:stmt_subline 
  sfsline:line_type 
 -- sfsline:business_type 

}

sorted by sfsline:line_of_business/newlines  
          sfsline:lob_subline

top of sfsline:line_of_business
box/noblanklines/noheadings 
   sfsline:line_of_business 
   sfsline:description 
end box
