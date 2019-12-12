viewpoint native;

where 1= 1 --sfsend:eff_date => 00--  09.01.2018
--and sfsend:exp_date = 00.00.0000
--and sfsend:form_edition[1,2]="SI"
--and sfsend:line_of_business one of 5,50,51

--and pos("SIR001",sfsend:form_edition) <> 0 
--and with pos("*",sfsend:form_edition) <> 0
--and sfsend:state one of 29
--and pos("Policyholder",sfsend:description) <> 0
and sfsend:code one of "MCL050"
--and (pos("tpd", sfsend:form_file_name ) <> 0)
--or pos("GS", sfsend:form_edition ) <> 0)
-- and sfsend:line_of_business one of 7 
--and sfsend:state one of 29
and sfsend:exp_date = 00.00.0000

list/nobanner/domain="sfsend"
  sfsend:state 
  sfsend:line_of_business 
  sfsend:form 
  sfsend:code 
  sfsend:eff_date 
  sfsend:exp_date 
  sfsend:form_print
  sfsend:form_edition 
  sfsend:form_file_name 
  sfsend:description 

sorted by sfsend:state /newlines 
          sfsend:line_of_business 
          sfsend:form_edition
