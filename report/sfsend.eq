--include "startend.inc"
define wdate l_starting_date = todaysdate 
define wdate l_ending_date = todaysdate 

where sfsend:print_form one of 1
--      sfsend:line_of_business one of 5, 51,50 and 
and sfsend:exp_date = 00.00.0000
--and sfsend:line_of_business one of 8
--and sfsend:state one of 29
and pos("GS",sfsend:form_edition) <> 0 

list
/nobanner
/domain="sfsend"
/title="Mandatory Forms - GSN"
/nodefaults 

sfsend:state 
sfsend:line_of_business 
sfsend:form 
sfsend:code 
sfsend:form_edition 
sfsend:eff_date 
sfsend:exp_date 
sfsend:form_file_name

sorted by sfsend:state/newlines 
          sfsend:line_of_business /newlines 
          sfsend:form 
          sfsend:code 

include "reporttop.inc"
