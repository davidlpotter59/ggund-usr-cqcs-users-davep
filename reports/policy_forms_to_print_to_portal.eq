viewpoint native; 

where 1 = 1 
  -- and sfsend:print_form one of 1
  and sfsend:exp_date = 00.00.0000
  
/*(pos("MCP010",sfsend:code) <> 0 or 
     pos("MCP016",sfsend:code) <> 0 or 
     pos("MCP014",sfsend:code) <> 0 or
     pos("MCL010",sfsend:code) <> 0 or
     pos("MCL030",sfsend:code) <> 0 or
     pos("MCL050",sfsend:code) <> 0 or
     pos("MCA010",sfsend:code) <> 0 or
     pos("BU0401",sfsend:code) <> 0 or
     pos("BU0406",sfsend:code) <> 0 or
     pos("SIC0001",sfsend:code) <> 0 or
     pos("SICP7001",sfsend:code) <> 0 or 
     pos("MSC710D", sfsend:code) <> 0 or 
     pos("MCP702D",sfsend:code) <> 0 or
     pos("SIR007", sfsend:code) <> 0 or
     pos("AXIS", sfsend:code) <> 0)*/
--and (pos("AXIS",sfsend:code) <> 0 or (pos("MCM810", sfsend:code) <> 0))
and sfsend:line_of_business one of  8
--and sfsend:state one of 37

list/nobanner/domain="sfsend"
  sfsend:state 
  sfsend:line_of_business 
  sfsline:description 
  sfsend:form 
  sfsend:code 
  sfsend:description 
  sfsend:eff_date 
  sfsend:exp_date 
  sfsend:form_edition 
 -- sfsend:form_print 
  sfsend:edition_print 
  sfsend:print_form 
  sfsend:form_file_name
  sfsend:pcl_doc_was_converted 
sfsend:lob_code 
end_lob_code
include_to_opt_end policyholder_notice pcl_doc_was_converted static_form 
 -- sfsend1a:pcl_doc_was_converted /heading="(sfsend1)-PCL DOC-WAS CONVERTED"

sorted by sfsend:line_of_business/newlines  
          sfsend:code /newlines 
          sfsend:state/newlines 
          sfsend:form
