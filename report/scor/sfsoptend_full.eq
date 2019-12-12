viewpoint native;
where 1 = 1 
--and sfsoptend:state one of 29
--and sfsoptend:line_of_business one of 5 
--and sfsoptend:code one of "SIR007"
--and sfsoptend:typed_form one of 1
and pos("GSIL-7001",sfsoptend:form_edition) <> 0

--and sfsoptend:exp_date = 00.00.0000
--and pos("Breakdown",sfsoptend:description) <> 0

list/nobanner/domain="sfsoptend"
  sfsoptend:state 
  sfsoptend:line_of_business 
  sfsoptend:code 
  sfsoptend:eff_date  
  sfsoptend:description 
  sfsoptend:form_edition 
  sfsoptend:description_1[1] 
  sfsoptend:limit[1] 
  sfsoptend:premium_1[1] 
  sfsoptend:quote_screen 
  sfsoptend:policy_screen 
  sfsoptend:print_form 
  sfsoptend:typed_form 
  sfsoptend:form_print 
  sfsoptend:edition_print 
  sfsoptend:exp_date 
  sfsoptend:liability_only 
  sfsoptend:trigger_endorsement 
  sfsoptend:end_lob_code 
  sfsoptend:automatically_rates 
  sfsoptend:property_only 
  sfsoptend:terrorism_form 
  sfsoptend:form_file_name 
  sfsoptend:crime_form 
  sfsoptend:system_rate 
  sfsoptend:rating_code 
  sfsoptend:property_liability 
  sfsoptend:edition 
  sfsoptend:wc_version_id 
  sfsoptend:copyright 
  sfsoptend:year 
  sfsoptend:dont_allow_agent_access 
  sfsoptend:company_rated

sorted by sfsoptend:state /newlines 
          sfsoptend:line_of_business
