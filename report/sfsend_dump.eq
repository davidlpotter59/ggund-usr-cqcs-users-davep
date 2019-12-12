-- MCL 202 06 05

--where pos("MCL202",sfsend:code ) <> 0
--and sfsend:exp_date = 00.00.0000
where sfsend:exp_date = 00.00.0000

list
/nobanner
/domain="sfsend"
--/title="MCL 202 06 05"

sfsend:state
sfsend:line_of_business 
sfsline_heading:description 
sfsend:code 
sfsend:form_edition 
sfsend:description 
sfsend:eff_date 
sfsend:exp_date 
--sfsend:trigger_endorsement
sfsend:form_print
--sfsend:typed_form 

sorted by sfsend:state /newlines 
          sfsend:line_of_business
