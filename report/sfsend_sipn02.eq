where pos("SIPN",sfsend:code) <>  0

list
/nobanner
/domain="sfsend"

sfsend:state 
sfsend:line_of_business 
sfsend:form 
sfsend:code 
sfsend:eff_date 
sfsend:exp_date 

sorted by sfsend:state/newpage
          sfsend:line_of_business /newlines 
          sfsend:form
