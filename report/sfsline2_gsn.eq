viewpoint native;
where sfsline2:lob_subline one of "00"
and sfsline2:line_of_business not one of 1,3,4, 10, 12, 14, 24

list/nobanner/domain="sfsline2"
  sfsline2:line_of_business 
  sfsline2:lob_subline 
  sfsline:description 
  sfsline2:exclude_from_contingent 
  sfsline2:other_company_subline 
  sfsline2:additional_alpha_prefix 
  sfsline2:starting_date_with_new_company 
  sfsline2:use_pol_year_end_seq_suffix 
  sfsline2:iso_subline 
  sfsline2:iso_stmt_lob 
  sfsline2:late_fee 
  sfsline2:nonpay_long_forms 
  sfsline2:image_alpha_prefix 
  sfsline2:axis_mapping 
  sfsline2:awac_coverage_code
