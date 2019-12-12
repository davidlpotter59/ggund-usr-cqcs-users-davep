define wdate l_accounting_date = parameter/prompt="Enter Accounting Date (12/31/YYYY) :"

define l_accounting_date2 = dateadd(l_accounting_date,0,-1)
define l_accounting_date3 = dateadd(l_accounting_date,0,-2)

define signed ascii number l_current_exclude_premium[9]=if sfsline2:exclude_from_contingent one of 1 then contingent:current_year_premium 
define signed ascii number l_year2_exclude_premium[9]=if sfsline2:exclude_from_contingent one of 1 then contingent:prior1_year_premium 
define signed ascii number l_year3_exclude_premium[9]=if sfsline2:exclude_from_contingent one of 1 then contingent:prior2_year_premium 

define signed ascii number l_current_include_premium[9]=if sfsline2:exclude_from_contingent not one of 1 then contingent:current_year_premium 
define signed ascii number l_year2_include_premium[9]=if sfsline2:exclude_from_contingent not one of 1 then contingent:prior1_year_premium 
define signed ascii number l_year3_include_premium[9]=if sfsline2:exclude_from_contingent not one of 1 then contingent:prior2_year_premium 

define signed ascii number l_current_earned_premium[9]=if sfsline2:exclude_from_contingent not one of 1 then 
(contingent:prior1_year_unearned + contingent:current_year_premium - contingent:current_year_unearned ) else 0.00

define signed ascii number l_year2_earned_premium[9]=if sfsline2:exclude_from_contingent not one of 1 then 
(contingent:prior2_year_unearned + contingent:prior1_year_premium - contingent:prior1_year_unearned ) else 0.00

define signed ascii number l_year3_earned_premium[9]=if sfsline2:exclude_from_contingent not one of 1 then 
(contingent:prior3_year_unearned + contingent:prior2_year_premium - contingent:prior2_year_unearned ) else 0.00

define signed ascii number l_current_incurred[9]=if sfsline2:exclude_from_contingent not one of 1 then 
contingent:current_incurred  else 0

define signed ascii number l_year2_incurred[9]=if sfsline2:exclude_from_contingent not one of 1 then 
contingent:year2_incurred   else 0

define signed ascii number l_year3_incurred[9]=if sfsline2:exclude_from_contingent not one of 1 then 
contingent:year3_incurred   else 0

define signed ascii number l_current_stop_loss[9]=if sfsline2:exclude_from_contingent not one of 1 then 
contingent:current_stop_loss   else 0

define signed ascii number l_year2_stop_loss[9]=if sfsline2:exclude_from_contingent not one of 1 then 
contingent:year2_stop_loss else 0

define signed ascii number l_year3_stop_loss[9]=if sfsline2:exclude_from_contingent not one of 1 then 
contingent:year3_stop_loss else 0

define signed ascii number l_current_commission[9]= if sfsline2:exclude_from_contingent not one of 1 then 
contingent:current_commission_paid else 0.00

define signed ascii number l_year2_commission[9]= if sfsline2:exclude_from_contingent not one of 1 then 
contingent:prior1_commission_paid else 0.00

define signed ascii number l_year3_commission[9]= if sfsline2:exclude_from_contingent not one of 1 then 
contingent:prior2_commission_paid else 0.00

define signed ascii number l_current_allowences[9]= if sfsline2:exclude_from_contingent not one of 1 then 
0 else 0.00

define signed ascii number l_year2_allowences[9]= if sfsline2:exclude_from_contingent not one of 1 then 
0 else 0.00

define signed ascii number l_year3_allowences[9]= if sfsline2:exclude_from_contingent not one of 1 then 
0 else 0.00


define signed ascii number l_current_combined_ratio = ((l_current_commission  + l_current_allowences) divide l_current_include_premium) +
                                                      (((l_current_stop_loss divide l_current_earned_premium) + 0.03) * 100)


define file sfsline2a=access sfsline2, set sfsline2:company_id= contingent:company_id, 
                                          sfsline2:line_of_business= contingent:line_of_business,
                                          sfsline2:lob_subline= contingent:lob_subline 


where contingent:accounting_date = l_accounting_date
--and agent_no one of 212
list
/nobanner
/domain="contingent"
--/nodetail
/nodefaults 

sorted by contingent:agent_no /newpage  --/newlines/total
 --         contingent:line_of_business /newlines/total 
 --         contingent:lob_subline

end of contingent:agent_no 
"1.  Direct Written Premium  "/column=1

box/noblanklines/noheadings 
    total[contingent:current_year_premium]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=50
    total[contingent:prior1_year_premium]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=80
    total[contingent:prior2_year_premium]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=100
end box

""/newline=2 
"2.  Ineligable Premium      "/column=1

box/noblanklines/noheadings 
    total[l_current_exclude_premium]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=50
    total[l_year2_exclude_premium]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=80
    total[l_year3_exclude_premium]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=100
end box

""/newline=2 
"3.  Eligable Premium        "/column=1

box/noblanklines/noheadings 
    total[l_current_include_premium]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=50
    total[l_year2_include_premium]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=80
    total[l_year3_include_premium]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=100
end box

""/newline=2 
"4.  Eligable Earned Premium "/column=1

box/noblanklines/noheadings 
    total[l_current_earned_premium]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=50
    total[l_year2_earned_premium]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=80
    total[l_year3_earned_premium]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=100
end box

""/newline=2 
"5.  Eligable Incurred Losses"/column=1

box/noblanklines/noheadings 
    total[l_current_incurred]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=50
    total[l_year2_incurred]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=80
    total[l_year3_incurred]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=100
end box

""/newline=2 
"6.  Stop Loss Adjustment    "/column=1

box/noblanklines/noheadings 
    total[l_current_stop_loss]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=50
    total[l_year2_stop_loss]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=80
    total[l_year3_stop_loss]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=100
end box

""/newline=2 
"7.  Adjusted Loss Ratio      "/column=1

box/noblanklines/noheadings 
(((total[l_current_incurred] - total[l_current_stop_loss]) divide total[l_current_earned_premium])*100)+0.03/mask="(ZZ,ZZZ,ZZZ.99%)"/column=50
    ((total[l_year2_stop_loss] divide total[l_year2_earned_premium] + 0.03)*100) /mask="(ZZ,ZZZ,ZZZ.99%)"/column=75
    ((total[l_year3_stop_loss] divide total[l_year3_earned_premium] + 0.03)*100) /mask="(ZZ,ZZZ,ZZZ.99%)"/column=95
end box

""/newline=2 
"8.  Eligable Paid Commisions"/column=1

box/noblanklines/noheadings 
    total[l_current_commission]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=50
    total[l_year2_commission]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=80
    total[l_year3_commission]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=100
end box

""/newline=2 
"9.  Allowences             "/column=1

box/noblanklines/noheadings 
    total[l_current_allowences]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=50
    total[l_year2_allowences]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=80
    total[l_year3_allowences]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=100
end box

""/newline=2 
"10. Total Compensation     "/column=1

box/noblanklines/noheadings 
    total[l_current_commission]  + total[l_current_allowences]/mask="(ZZ,ZZZ,ZZZ.99)"/column=50
    total[l_year3_commission]    + total[l_year2_allowences]/mask="(ZZ,ZZZ,ZZZ.99)"/column=80
    total[l_year3_commission]    + total[l_year3_allowences]/mask="(ZZ,ZZZ,ZZZ.99)"/column=100
end box

""/newline=2 
"11. Compensation Ratio     "/column=1

box/noblanklines/noheadings 
    ((total[l_current_commission]  + total[l_current_allowences]) divide total[l_current_include_premium]) * 100 /mask="(ZZ,ZZZ,ZZZ.99%)"/column=50
    ((total[l_year3_commission]    + total[l_year2_allowences])  divide total[l_year2_include_premium]) * 100 /mask="(ZZ,ZZZ,ZZZ.99%)"/column=80
    ((total[l_year3_commission]    + total[l_year3_allowences]) divide total[l_year2_include_premium]) * 100 /mask="(ZZ,ZZZ,ZZZ.99%)"/column=100
end box

""/newline=2 
"12. Adjust Loss & Exp Ratio"/column=1

box/noblanklines/noheadings 

    ((((total[l_current_commission]    + total[l_current_allowences])  divide total[l_current_include_premium])*100)
  + ((((total[l_current_incurred] - total[l_current_stop_loss]) divide total[l_current_earned_premium])*100)+0.03))/mask="(ZZZ,ZZZ,ZZZ.99)"/column=50

    ((total[l_year2_commission]    + total[l_year2_allowences])  divide total[l_year2_include_premium]
  + (total[l_year2_stop_loss] divide total[l_year2_earned_premium] + 0.03)) * 100 /mask="(ZZZ,ZZZ,ZZZ.99)"/column=80

    ((total[l_year3_commission]    + total[l_year2_allowences])  divide total[l_year2_include_premium]
  + (total[l_year2_stop_loss] divide total[l_year2_earned_premium] + 0.03)) * 100 /mask="(ZZZ,ZZZ,ZZZ.99)"/column=100

end box

""/newline=2 
"13.  % Factor             "/column=1

box/noblanklines/noheadings 
    total[l_current_allowences]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=50
    total[l_year2_allowences]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=80
    total[l_year3_allowences]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=100
end box

""/newline=2
"14.  Contingent Commission"/column=1

""/newline=2
"15.  Loss Limitation Factor"/column=1

""/newline=2
"16.  Contingent Commission (1YR)"/column=1

""/newline=2
"17.  Contingent Commission (3YR)"/column=1

""/newline=2
"18.  Contingent Commissions (TOTAL)"/column=1




""/newline 

top of page
"G & G Underwriters, LLC"/column=50
--sfscompany:name[1]/column=50
str(year(l_accounting_date)) + " Contingent Commissions"/column=110
pagenumber /newline

"133 FRANKLIN CORNER ROAD"/column=50/newline 
"LAWRENCEVILLE, NJ  08648-2531"/column=50/newline=3

contingent:agent_no
sfsagent:name[1]/noheading/newline=2

"Accounting Years            "/column=1
year(l_accounting_date)/noheading/column=87
year(l_accounting_date2)/noheading/column=117
year(l_accounting_date3)/noheading/column=137
/newline=2
