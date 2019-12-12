viewpoint native;

where 1 = 1 --sfsoptend:exp_date = 00.00.0000
--and pos("GSIL-7001",sfsoptend:form_edition) <> 0
--and pos("(",sfsoptend:form_print) <> 0
--and with pos("GSBU",sfsoptend:form_edition) <> 0
--and sfsoptend:form_edition[1,9] = "GSIL-7001"
--and with pos("(",sfsoptend:form_print) <> 0
--and sfsoptend:state one of 29
--and sfsoptend:line_of_business one of 6
--and sfsoptend:print_form one of 1
--and sfsoptend:typed_form one of 0
--and sfsoptend:code one of 'SIR007'
--and pos("SIBU", sfsoptend:code) <> 0
--and pos("MCL",sfsoptend:form_edition ) <> 0
-- or pos("GSBU-0001", sfsoptend:form_edition) <> 0 )
and sfsoptend:form_file_name[1,2]="gs"
and sfsoptend:exp_date = 00.00.0000

list/nobanner/domain="sfsoptend"/nodetail 
--  sfsoptend:state 
 -- sfsoptend:line_of_business 
  sfsoptend:code 
  sfsoptend:eff_date 
  sfsoptend:exp_date 
  sfsoptend:form_edition 
--  sfsoptend:print_form
  sfsoptend:form_file_name /heading="File on-Disk to-Print"
  sfsoptend:description 
  sfsoptend:print_form 
  sfsoptend:typed_form 
  sfsoptend:form_print 
  sfsoptend:edition_print
  sfsoptend:copyright 

sorted by sfsoptend:form_file_name
          --sfsoptend:state /newlines 
          --sfsoptend:line_of_business 
          --sfsoptend:form_edition/newlines 
         -- sfsoptend:state 
         -- sfsoptend:line_of_business

end of sfsoptend:form_file_name 
box/noheadings/noblanklines 
 -- sfsoptend:state 
 -- sfsoptend:line_of_business 
  sfsoptend:code 
  sfsoptend:eff_date 
  sfsoptend:exp_date 
  sfsoptend:form_edition 
--  sfsoptend:print_form
  sfsoptend:form_file_name 
  sfsoptend:description 
  sfsoptend:print_form 
  sfsoptend:typed_form 
  sfsoptend:form_print 
  sfsoptend:edition_print
  sfsoptend:copyright 
end box
