include "startend.inc"

define string l_program_no = "Policy Counts"

where policycount:trans_code not one of 12,13,15

sum
/nobanner
/domain="policycount"
/duplicates 

units 

across trans_code

by 
policy_no  
name
field1 /mask="(ZZZ,ZZZ,ZZZ.99)"/heading="Premium"/total 

/*
top of page
"Date Range : "
l_starting_date/column=15/noheading /mask="MM/DD/YYYY"
" - "
l_ending_date/noheading /newline /mask="MM/DD/YYYY"
""/newline 
*/
