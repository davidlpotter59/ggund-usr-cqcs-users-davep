where sfsline:lob_code one of "AUTO"
and sfpname:status = "CURRENT"

list
/nobanner
/domain="sfpname"
/nodetail 

sfpname:policy_no 
--sfpname:pol_year 
--sfpname:end_sequence 
sfsline_heading:description /duplicates 

sorted by sfpname:policy_no 

end of sfpname:policy_no 
box/noblanklines /noheadings 
   sfpname:policy_no 
--   sfpname:pol_year 
  -- sfpname:end_sequence 
   sfsline_heading:description 
end box
