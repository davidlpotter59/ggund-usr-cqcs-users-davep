viewpoint native;

where 
  sfsline:line_type one of
    "X"

list/nobanner/domain="sfsline"
  sfsline:line_of_business 
  sfsline:lob_subline 
  sfsline:record_rdf 
  sfsline:description 
  sfsline:prem_fee_flag 
 -- sfsline:comm_rate 
  sfsline:bureau_lob 
  sfsline:stmt_lob 
  sfsline:stmt_subline 
  sfsline:minimum_premium 
  sfsline:alpha 
  sfsline:line_type 
  sfsline:business_type 
  sfsline:use 
  sfsline:lob_code 
  sfsline:tpa 
  sfsline:subline_total 
  sfsline:claim_alpha 
  sfsline:option 
  sfsline:stat_program_quote 
  sfsline:stat_program_policy 
  sfsline:print_expiring_premiums_wording 
  sfsline:print_claims_notice_wording 
  sfsline:filler2 
  sfsline:lapse_days_to_cancel 
  sfsline:lapse_mailing_days 
  sfsline:aplus_code 
  sfsline:loss_rating 
  sfsline:no_claims 
  sfsline:apt_rating 
  sfsline:reins_no 
  sfsline:reins_comm 
  sfsline:length_prev_policy_no 
  sfsline:irpm_decrease 
  sfsline:irpm_amount 
  sfsline:subline_totals_position 
  sfsline:multi_year 
  sfsline:cx_days_to_cancel 
  sfsline:cx_mailing_days 
  sfsline:cx_grace_days 
  sfsline:mso_subline 
  sfsline:update_irpm 
  sfsline:mtg_mailbook_update 
  sfsline:uds_coverage_code 
  sfsline:wc_loss_type 
  sfsline:wc_filler 
  sfsline:version730_use 
  sfsline:imaging_drawer 
  sfsline:subject_to_surplus 
  sfsline:exclude_from_reinsurance 
  sfsline:form 
  sfsline:zeros_in_policy_no 
  sfsline:use_irpm_reinsurance 
  sfsline:broker_proof_code 
  sfsline:personal_commercial 
  sfsline:fail_all_renewals 
  sfsline:portfolio_lob 
  sfsline:rating_line_of_business

sorted by sfsline:line_of_business /newlines 
          sfsline:lob_subline
