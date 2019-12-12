viewpoint native;

define file sfsoptend1a = access sfsoptend1, 
set sfsoptend1:COMPANY_ID       = sfsoptend:company_id, 
    sfsoptend1:STATE            = sfsoptend:state,
    sfsoptend1:LINE_OF_BUSINESS = sfsoptend:line_of_business,
    sfsoptend1:CODE             = sfsoptend:code, 
    sfsoptend1:REFF_DATE        = sfsoptend:eff_date 

where 1 = 1 
  -- and sfsoptend:print_form one of 1
  and sfsoptend:exp_date = 00.00.0000
  and with pos("GS", sfsoptend:form_edition ) <> 0

/*
and (pos("MCP010",sfsoptend:code) <> 0 or 
     pos("MCP016",sfsoptend:code) <> 0 or 
     pos("MCP014",sfsoptend:code) <> 0 or
     pos("MCL010",sfsoptend:code) <> 0 or
     pos("MCL030",sfsoptend:code) <> 0 or
     pos("MCL050",sfsoptend:code) <> 0 or
     pos("MCA010",sfsoptend:code) <> 0 or
     pos("BU0401",sfsoptend:code) <> 0 or
     pos("BU0406",sfsoptend:code) <> 0 or
     pos("SISC0001",sfsoptend:code) <> 0 or
     pos("SICP7001",sfsoptend:code) <> 0 or
     pos("SIS", sfsend:code) <> 0 or 
     pos("SISC-0001", sfsoptend:form_edition) <> 0 or 
     pos("SIR007", sfsoptend:code) <> 0 or
     pos("policy", sfsoptend:form_file_name) <> 0 or
     pos("policu", sfsoptend:description) <> 0 )
*/
--and pos("MIM012",sfsoptend:code) <> 0
--and sfsoptend:print_form one of 1 
--and sfsoptend:typed_form one of 1
--and sfsoptend1a:pcl_doc_was_converted not one of 1 
and sfsoptend:line_of_business one of 8

list/nobanner/domain="sfsoptend"
  sfsoptend:state 
  sfsoptend:line_of_business 
  --sfsline_heading:description 
 -- sfsoptend:form 
  sfsoptend:code 
  sfsoptend:description 
  sfsoptend:eff_date 
  sfsoptend:exp_date 
  sfsoptend:form_edition 
  sfsoptend:form_print 
  sfsoptend:edition_print 
  sfsoptend:print_form 
  sfsoptend:form_file_name typed_form
  sfsoptend1a:pcl_doc_was_converted /heading="(sfsoptend1)-PCL DOC-WAS CONVERTED"

sorted by --sfsoptend:line_of_business--/newlines  
          sfsoptend:form_file_name 
       --   sfsoptend:form /newlines 
          --sfsoptend:state

/*end of sfsoptend:form_file_name 
box/noblanklines/noheadings 
  sfsoptend:state 
  sfsoptend:line_of_business 
  --sfsline_heading:description 
 -- sfsoptend:form 
  sfsoptend:code 
  sfsoptend:description 
  sfsoptend:eff_date 
  sfsoptend:exp_date 
  sfsoptend:form_edition 
  sfsoptend:form_print 
  sfsoptend:edition_print 
  sfsoptend:print_form 
  sfsoptend:form_file_name typed_form
--  sfsoptend1a:pcl_doc_was_converted /heading="(sfsoptend1)-PCL DOC-WAS CONVERTED"
end box
*/
