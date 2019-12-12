define unsigned ascii number l_count=1

where sfpname:policy_no = sfpcurrent:policy_no and 
      sfpname:pol_year  = sfpcurrent:pol_year and 
      sfpname:end_sequence = sfpcurrent:end_sequence and 
      sfpname:status one of "CURRENT" and 
      sfpname:eff_date => 11.01.2018 and 
      sfpname:eff_date <= todaysdate  and 
      sfpname:trans_date => 11.12.2018
and (sfpname:pol_year = sfpcurrent:pol_year and
     sfpname:end_sequence = sfpcurrent:end_sequence)

list
/nobanner
/domain="sfpname"
/duplicates 
/nototals 

sfpname:policy_no 
sfpname:line_of_business 
sfsline_heading:description/noheading 
sfpname:eff_date exp_date 
""/heading="Counted"/hidden 

sorted by line_of_business/total
          policy_no

Top of sfpname:line_of_business 
box/noblanklines/noheadings 
    sfpname:line_of_business 
    sfsline_heading:description 
end box
""/newline 

end of sfpname:line_of_business 
""/newline 
box/noblanklines/noheadings 
    "Total Policy Count for " + str(sfpname:line_of_business) + " (" +trim(sfsline_heading:description)+")"/toggle/column=30
    total[l_count]/align=sfpname:eff_date /mask="ZZZ,ZZZ"
end box 

end of report 
""/newline=2
box/noblanklines/noheadings 
    "Total Policy Count for All Lines" /column=30
    total[l_count]/align=sfpname:eff_date /mask="ZZZ,ZZZ"
end box 

top of page  
enquiryname                      /heading="Report No      "/column=1/newline 
--L_prog_number                    /heading="Report No      "/column=1/newline 
trun(sfscompany:name[1])/column=1/heading="Company Name   "/newline  
trun(str(todaysdate,"MM/DD/YYYY") )/column=1/heading=
"As of Period   "/newline
