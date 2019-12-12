define wdate l_starting_date = parameter/prompt="Enter your starting Date" default todaysdate -1
define wdate l_ending_date = parameter/prompt="Enter your ending Date" default todaysdate 

define file polmanhold = access polman, set polman:policy_no= sfpname:policy_no, many to one, exact  

define string l_status = if polmanhold:policy_no = sfpname:policy_no and polmanhold:then "Exits" else "Missing"

where sfpname:trans_date => l_starting_date and 
      sfpname:trans_date =< l_ending_date  and
      sfppoint:converted <> "N" and 
      l_status one of "Missing"

list
/nobanner
/title="Policies Missing from the Portal"
/domain="sfpname"
/duplicates 
/nototals 

sfpname:policy_no 
sfpname:pol_year 
sfpname:end_sequence 
sfpname:name[1] 
sfpname:agent_no 
sfpname:trans_date/heading="Rating Trans-Date"

polmanhold:policy_no  /heading="Policy-Management-Policy Number"
l_status /heading="Action-Type"

sorted by sfpname:agent_no
          sfpname:policy_no/newlines 

top of sfpname:agent_no 
box/noblanklines/noheadings 
  str(sfpname:agent_no) + " - " + trim(sfsagent:name[1])
end box
""/newline

include "reporttop.inc"
