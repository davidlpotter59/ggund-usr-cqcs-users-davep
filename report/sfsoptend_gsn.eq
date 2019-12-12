include "startend.inc"

where 1 = 1 -- sfsoptend:typed_form one of 1 
and sfsoptend:exp_date = 00.00.0000
--and sfsoptend:line_of_business one of 8
and sfsoptend:form_file_name <> ""
--and sfsoptend:print_form one of 1
--and sfsoptend:state one of 29
and pos('gs',sfsoptend:form_file_name) <> 0
list
/nobanner
/domain="sfsoptend"
/title="Manuscript Forms - NJ - Line 8"
/nodetail 

  sfsoptend:state 
  sfsoptend:line_of_business 
  sfsoptend:code 
  sfsoptend:edition_print 
  sfsoptend:form_file_name 
  sfsoptend:typed_form 
  sfsoptend:form_print
  sfsoptend:description 

sorted by sfsoptend:state 
          sfsoptend:line_of_business 
          sfsoptend:form_file_name 

end of sfsoptend:form_file_name  
box/noblanklines/noheadings 
  sfsoptend:state 
  sfsoptend:line_of_business 
  sfsoptend:code /align=sfsoptend:code 
  sfsoptend:edition_print /align=sfsoptend:edition_print 
  sfsoptend:form_file_name /align=sfsoptend:form_file_name 
  sfsoptend:typed_form /align=sfsoptend:typed_form 
  sfsoptend:form_print/align=sfsoptend:form_print 
  sfsoptend:description/align=sfsoptend:description 
end box

include "reporttop.inc"
