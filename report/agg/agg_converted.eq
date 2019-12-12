define file sfppointa = access sfppoint, set sfppoint:policy_no= aggregate_limit_loc:policy_no, 
                                             sfppoint:pol_year = aggregate_limit_loc:pol_year 
where sfppointa:converted not one of "Y" and sfppointa:end_sequence = aggregate_limit_loc:end_sequence 

list
/nobanner
/domain="aggregate_limit_loc" 
/duplicates 

aggregate_limit_loc:policy_no 
pol_year 

end_sequence

sfppointa:converted 
sfppointa:end_sequence
