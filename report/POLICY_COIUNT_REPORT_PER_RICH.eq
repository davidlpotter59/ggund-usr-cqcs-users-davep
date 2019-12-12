
define date l_starting_date = parameter/prompt="Please Enter The Starting Date: (MMDDYYYY)"
define date l_ending_date   = parameter/prompt="Please Enter The Ending Date : (MMDDYYYY) "
--unsigned ascii number l_agent_no[ 4 ] = parameter/prompt="Enter Agent No" ;
--unsigned ascii number l_line = parameter/prompt="Enter Line of Business" ;

where 

(prsmaster has trans_code one of 10,11,12,13,14,15,16

and trans_eff >= l_starting_date 

and trans_eff <= l_ending_date 

and trans_date <= l_ending_date 

and exp_date >= l_ending_date 

and eff_date >=l_starting_date 

and sfsline:description not one of "SEC INJURY FUND SURCHARGE"

and sfsline:description not one of "UNINSURED EMP FUND SURCHARGE"

--and prsmaster:agent_no = l_agent_no 

and sfpname:status one of "CURRENT","EXPIRED","NONRENEWED"

--and prsmaster:line_of_business = l_line

--and sfpname:new_renewal one of "N"

)      

or 

(prsmaster has trans_code one of 10,11,12,13,14,15,16

and trans_eff < l_starting_date 

and trans_date <= l_ending_date 

and trans_date >= l_starting_date 

and eff_date >= l_starting_date 

and exp_date <=l_ending_date 

and sfsline:description not one of "SEC INJURY FUND SURCHARGE"

and sfsline:description not one of "UNINSURED EMP FUND SURCHARGE"

--and prsmaster:agent_no = l_agent_no 

and sfpname:status one of "CURRENT","EXPIRED","NONRENEWED"

--and prsmaster:line_of_business = l_line

--and sfpname:new_renewal one of "N"
)

or
(prsmaster:trans_code one of 10,11,12,13,14,15,16

and sfpname:status one of "CANCELLED"

and prsmaster:trans_eff > l_ending_date 

and prsmaster:trans_date <= l_ending_date 

and prsmaster:eff_date >= l_starting_date 

and prsmaster:eff_date <= l_ending_date 

and sfsline:description not one of "SEC INJURY FUND SURCHARGE"

and sfsline:description not one of "UNINSURED EMP FUND SURCHARGE"

--and prsmaster:agent_no = l_agent_no

--and prsmaster:line_of_business = l_line

--and sfpname:new_renewal one of "N"

)

or

(prsmaster:trans_code one of 10,11,12,13,14,15,16

and sfpname:status one of "CANCELLED"

and prsmaster:trans_eff > l_ending_date 

and prsmaster:trans_date > l_ending_date 

and prsmaster:eff_date <= l_ending_date 

and prsmaster:eff_date >= l_starting_date 

and sfsline:description not one of "SEC INJURY FUND SURCHARGE"

and sfsline:description not one of "UNINSURED EMP FUND SURCHARGE"

--and prsmaster:agent_no = l_agent_no

--and prsmaster:line_of_business = l_line

--and sfpname:new_renewal one of "N"

)

or

(prsmaster:trans_code one of 10,11,12,13,14,15,16

and sfpname:status one of "CANCELLED"

and prsmaster:trans_eff <= l_ending_date 

and prsmaster:trans_date > l_ending_date 

and prsmaster:eff_date <= l_ending_date 

and prsmaster:eff_date >= l_starting_date 

and sfsline:description not one of "SEC INJURY FUND SURCHARGE"

and sfsline:description not one of "UNINSURED EMP FUND SURCHARGE"

--and prsmaster:agent_no = l_agent_no

--and prsmaster:line_of_business = l_line

--and sfpname:new_renewal one of "N"

)


list

/domain="prsmaster"

/nobanner

/title="Direct Written Premiums by LOB for Inforce Policies Only"

/nodetail 

 

prsmaster:policy_no/duplicates /column=1

sfpname:status /column = 15
sfpname:name/column=25
--prsmaster:line_of_business /column=25/heading="LOB"

prsmaster:trans_date /column=40

prsmaster:trans_eff /column=55

prsmaster:eff_date/column=70

prsmaster:exp_date /column=85 

prsmaster:premium /column=95

prsmaster:pol_year /column=115

prsmaster:trans_code /column=120/heading="TC"

sfpname:original_eff_date /column=125/heading="Original-Eff Date"

sfpname:new_renewal /column=140

prsmaster:comm_rate/column=150


sorted by line_of_business prsmaster:eff_date prsmaster:policy_no 


top of prsmaster:line_of_business 

""/newline

sfsline_heading:description/noheading 

 

end of prsmaster:policy_no 

box/noblanklines/noheadings 

    prsmaster:policy_no/column=1

    sfpname:status /column= 15
    sfpname:name/column=25 
    --prsmaster:line_of_business /column=25

    prsmaster:trans_date /column=40

    prsmaster:trans_eff /column=55

    prsmaster:eff_date/column=70

    prsmaster:exp_date /column=85 

    total[prsmaster:premium] /column=95

    prsmaster:pol_year /column=115

    prsmaster:trans_code /column=120

    sfpname:original_eff_date /column=125

    sfpname:new_renewal/column=140    

    prsmaster:comm_rate/column=150

    
       
end box


end of prsmaster:line_of_business 

box/noblanklines/noheadings 

    ""/newline 

    "Line TOTAL "/column=5
    
    total[prsmaster:premium]/column=95
   
end box

top of report
  str(l_starting_date,"MM/DD/YYYY")/heading="Starting Date"/column=1/newline  
  str(l_ending_date,"MM/DD/YYYY")/heading="Ending Date"/column=1/newline
  --sfpname:agent_no/column=1/newline
  --sfsagent:name/column=1/newline
  --line_of_business /column=1/newline

end of report count[sfpname:status]/duplicates/heading = "Total Policies Inforce"
