include "ending.inc"

define string l_mandatory = if pos("*",sfsend:form_edition) <> 0 then "Mandatory" else "Optional"

where sfsend:exp_date = 00.00.0000 or 
      sfsend:exp_date => l_ending_date 

--and with sfsend:code one of "MCM414"

list
/nobanner
/domain="sfsend"
/title="Forms used By State, Line and Mandatory or Optional"
/nodetail 

sfsend:state 
sfsend:line_of_business /heading="LOB"
--l_mandatory/heading="Mandatory or-Optional"
sfsend:form
sfsend:code
sfsend:eff_date 
--sfsend:exp_date 
sfsend:form_edition 
sfsend:description 

sorted by --l_mandatory 
          sfsend:state
          sfsend:line_of_business
        --  sfsend:form 
          sfsend:form_edition

top of sfsend:state
box/noblanklines/noheadings 
  sfsend:state 
  sfsstate:description  
end box

top of sfsend:line_of_business 
box/noblanklines/noheadings 
  sfsend:line_of_business 
  sfsline_heading:description --/newline 
end box
 
end of sfsend:form_edition  
box/noblanklines/noheadings 
 -- sfsend:state /align=sfsend:state 
 -- sfsend:line_of_business/align=sfsend:line_of_business 
  sfsend:form/align=sfsend:form 
  sfsend:code/align=sfsend:code 
  sfsend:eff_date /align=sfsend:eff_date 
 -- sfsend:exp_date /align=sfsend:exp_date 
  sfsend:form_edition /align=sfsend:form_edition 
  sfsend:description /align=sfsend:description 
end box

include "reporttop.inc"
""/newline=2
