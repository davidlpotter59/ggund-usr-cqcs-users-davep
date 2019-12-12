-- MCL 202 06 05

where pos("MCL202",sfsoptend:code ) <> 0
and sfsoptend:exp_date = 00.00.0000

list
/nobanner
/domain="sfsoptend"
/title="MCL 202 06 05"

sfsoptend:state
sfsoptend:line_of_business 
sfsline_heading:description 
sfsoptend:code 
sfsoptend:form_edition 
sfsoptend:description 
sfsoptend:eff_date 
sfsoptend:exp_date 
sfsoptend:trigger_endorsement
sfsoptend:form_print
sfsoptend:typed_form 

sorted by sfsoptend:state /newlines 
          sfsoptend:line_of_business
