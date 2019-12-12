viewpoint native;

where 
  sfscause:line_of_business not one of
    1,
    3,
    4,
    10,
    12,
    14,
    24,
    40

list/nobanner/domain="sfscause"
  sfscause:line_of_business 
  sfscause:lob_subline 
  sfscause:cause_of_loss 
  sfscause:cause_loss_subline 
  sfscause:description 
  sfscause:line_type 
  sfscause:mso_cause_loss 
  sfscause:nars_coverage_code

sorted by sfscause:line_of_business /newlines 
          sfscause:lob_subline 
          sfscause:cause_of_loss /newlines 
          sfscause:cause_loss_subline 

top of sfscause:line_of_business 
box/noblanklines/noheadings 
str(sfscause:line_of_business) + " " trim(sfsline_heading:description )
end box 
""/newline
