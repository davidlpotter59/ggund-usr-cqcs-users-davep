viewpoint native;

where 1 = 1
 --pos("AXIS",sfsend:form_edition) <> 0
and sfsend:line_of_business one of 5
and sfsend:state one of 7,29,37
--and pos("axis_cover",sfsend:form_file_name) <> 0
and sfsend:exp_date = 00.00.0000

list/nobanner/domain="sfsend"
 -- sfsend:company_id 
  sfsend:state 
  sfsend:line_of_business
  sfsend:form 
  sfsend:code
  sfsend:eff_date 
  sfsend:description 
  sfsend:form_edition 
  sfsend:form_print 
 -- sfsend:edition_print 
  sfsend:print_form 
 -- sfsend:renewal 
 -- sfsend:exp_date 
 -- sfsend:new 
 -- sfsend:renewal_eff_date 
 -- sfsend:new_eff_date 
 -- sfsend:end_lob_code 
  sfsend:form_file_name 
 -- sfsend:renewal_exp_date 
 -- sfsend:new_exp_date 
  sfsend:lob_code 
 -- sfsend:include_to_opt_end 
 -- sfsend:policyholder_notice 
  sfsend:pcl_doc_was_converted 
 -- sfsend:static_form
 -- sfsend:expansion

sorted by sfsend:code
          sfsend:form
