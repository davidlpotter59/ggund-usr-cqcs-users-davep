define file sfsend2 = access axis_sfsend, set axis_sfsend:company_id       = sfsend:company_id, 
                                              axis_sfsend:state            = sfsend:state, 
                                              axis_sfsend:line_of_business = sfsend:line_of_business, 
                                              axis_sfsend:form             = sfsend:form, 
                                              axis_sfsend:code             = sfsend:code,
                                              axis_sfsend:eff_date         = sfsend:eff_date 
list
/nobanner
/domain="sfsend"

sfsend:state 
sfsend2:state /heading="AXIS-State"

sfsend:line_of_business 
sfsend2:line_of_business /heading="AXIS-LOB" 

sfsend:form
sfsend2:form  /heading="AXIS-Form"

sfsend:code 
sfsend2:code  /heading="AXIS-Code"

sfsend:eff_date
sfsend2:eff_date  /heading="AXIS-Eff Date"

sfsend:form_edition 
sfsend2:form_edition  /heading="AXIS-Edition"

sfsend:form_print 
sfsend2:form_print  /heading="AXIS-Form Print"

sfsend:print_form 
sfsend2:print_form  /heading="AXIS-Form"

sfsend:form_file_name 
sfsend2:form_file_name  /heading="AXIS-Form-Filename"

sfsend:pcl_doc_was_converted 
sfsend2:pcl_doc_was_converted  /heading="AXIS-PCL-Converted"

sorted by sfsend:state 
          sfsend:line_of_business 
          sfsend:form 
          sfsend:code
