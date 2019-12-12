viewpoint native;

define
  wdate l_accounting_date = parameter
    prompt "Enter Accounting Date (12/31/YYYY) :";
  
  date l_accounting_date2 = dateadd(l_accounting_date,0,-1);
  
  date l_accounting_date3 = dateadd(l_accounting_date,0,-2);
  
  signed ascii number l_year2_include_premium[ 9 ] =
  contingentagent:eligable_premium[2];
  
  signed ascii number l_3year_premium[ 9 ] = contingentagent:premium[1] +
  contingentagent:premium[2] + contingentagent:premium[3];
  
  signed ascii number l_current_exclude_premium[ 9 ] =
  contingentagent:ineligable_premium[1];
  
  signed ascii number l_year2_exclude_premium[ 9 ] =
  contingentagent:ineligable_premium[2];
  
  signed ascii number l_year3_exclude_premium[ 9 ] =
  contingentagent:ineligable_premium[3];
  
  signed ascii number l_3year_ineligable_premium[ 9 ] =
  l_current_exclude_premium + l_year2_exclude_premium +
  l_year3_exclude_premium;
  
  signed ascii number l_3year_stop_loss_adjustment[ 9 ] =
  contingentagent:stop_loss_adjustment[1] +
  contingentagent:stop_loss_adjustment[2] +
  contingentagent:stop_loss_adjustment[3];
  
  signed ascii number l_3year_paid_commissions[ 9 ] =
  contingentagent:eligable_paid_commissions[1] +
  contingentagent:eligable_paid_commissions[2] +
  contingentagent:eligable_paid_commissions[3];
  
  signed ascii number l_3year_allowences[ 9 ] =
  contingentagent:allowences[1] + contingentagent:allowences[2] +
  contingentagent:allowences[3];
  
  signed ascii number l_3year_total_compensation[ 9 ] =
  l_3year_paid_commissions + l_3year_allowences;
  
  signed ascii number l_3year_eligable_premium[ 9 ] =
  contingentagent:eligable_PREMIUM[1] +
  contingentagent:eligable_PREMIUM[2] +
  contingentagent:eligable_PREMIUM[3];
  
  signed ascii number l_3year_compensation_ratio[ 9 ] =
  (round((l_3year_total_compensation divide
  l_3year_eligable_premium),3)*100);
  
  signed ascii number l_3year_eligable_incurred_losses[ 9 ] =
  contingentagent:incurred[1] + contingentagent:incurred[2] +
  contingentagent:incurred[3];
  
  signed ascii number l_3year_eligable_earned_premium[ 9 ] =
  contingentagent:eligable_earned_PREMIUM[1] +
  contingentagent:eligable_earned_PREMIUM[2] +
  contingentagent:eligable_earned_PREMIUM[3];
  
  signed ascii number l_3year_adjusted_loss_ratio[ 9 ] =
  (round((l_3year_eligable_incurred_losses divide
  l_3year_eligable_earned_premium),4) + 0.0003) * 100;
  
  signed ascii number l_3year_combined_ratio[ 9 ] =
  l_3year_compensation_ratio + l_3year_adjusted_loss_ratio;
  
  signed ascii number l_year2_earned_premium[ 9 ] =
  contingentagent:eligable_earned_premium[2];
  
  signed ascii number l_current_incurred[ 9 ] =
  contingentagent:incurred[1];
  
  signed ascii number l_year2_incurred[ 9 ] = contingentagent:incurred[2];
  
  signed ascii number l_year3_incurred[ 9 ] = contingentagent:incurred[3];
  
  signed ascii number l_year2_stop_loss[ 9 ] =
  contingentagent:stop_loss_adjustment[2];
  
  signed ascii number l_year3_stop_loss[ 9 ] =
  contingentagent:stop_loss_adjustment[3];
  
  signed ascii number l_year2_commission[ 9 ] =
  contingentagent:eligable_paid_commissions[2];
  
  signed ascii number l_year3_commission[ 9 ] =
  contingentagent:eligable_paid_commissions[3];
  
  signed ascii number l_year2_allowences[ 9 ] =
  contingentagent:allowences[2];
  
  signed ascii number l_year3_allowences[ 9 ] =
  contingentagent:allowences[3];
  
  signed ascii number l_current_commission[ 9 ] =
  contingentagent:eligable_paid_commissions[1];
  
  signed ascii number l_current_allowences[ 9 ] =
  contingentagent:allowences[1];
  
  signed ascii number l_current_include_premium[ 9 ] =
  contingentagent:eligable_premium[1];
  
  signed ascii number l_current_stop_loss[ 9 ] =
  contingentagent:stop_loss_adjustment[1];
  
  signed ascii number l_current_earned_premium[ 9 ] =
  contingentagent:eligable_earned_premium[1];
  
  file sfsagenta = access sfsagent,
    set sfsagent:company_id = contingentagent:company_id,
    sfsagent:agent_no = contingentagent:agent_no;
  
where 
  contingentagent:accounting_date = 
    l_accounting_date
  and contingentagent:agent_no one of
    136,
    262,
    153
  
list/nobanner--/nodetail
/nodefaults/domain="contingentagent"
  sorted by
  contingentagent:agent_no/newpage           --/newlines/total
                                             --         contingentagent:line_of_business /newlines/total 
                                             --         contingentagent:lob_subline
  
end of contingentagent:agent_no 
  "1.  Direct Written Premium  "/column=1
  box/noblanklines/noheadings contingentagent:PREMIUM[1]
  /mask="(ZZZ,ZZZ,ZZZ.99)"/column=50
    contingentagent:PREMIUM[2]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=80
    contingentagent:PREMIUM[3]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=100
    l_3year_premium/mask="(ZZZ,ZZZ,ZZZ.99)"/column=130
  
  end box
  ""/newlines=2
  "2.  Ineligable Premium      "/column=1
  box/noblanklines/noheadings total[l_current_exclude_premium]
  /mask="(ZZZ,ZZZ,ZZZ.99)"/column=50
    total[l_year2_exclude_premium]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=80
    total[l_year3_exclude_premium]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=100
    l_3year_ineligable_premium/mask="(ZZZ,ZZZ,ZZZ.99)"/column=130
  end box
  ""/newlines=2
  "3.  Eligable Premium        "/column=1
  box/noblanklines/noheadings contingentagent:eligable_premium[1]
  /mask="(ZZZ,ZZZ,ZZZ.99)"/column=50
    contingentagent:eligable_premium[2]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=80
    contingentagent:eligable_premium[3]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=100
    l_3year_eligable_premium/mask="(ZZZ,ZZZ,ZZZ.99)"/column=130
  end box
  ""/newlines=2
  "4.  Eligable Earned Premium "/column=1
  box/noblanklines/noheadings contingentagent:eligable_earned_premium[1]
  /mask="(ZZZ,ZZZ,ZZZ.99)"/column=50
    contingentagent:eligable_earned_premium[2]/mask="(ZZZ,ZZZ,ZZZ.99)"
  /column=80
    contingentagent:eligable_earned_premium[3]/mask="(ZZZ,ZZZ,ZZZ.99)"
  /column=100
    l_3year_eligable_earned_premium /mask="(ZZZ,ZZZ,ZZZ.99)"/column=130
  end box
  ""/newlines=2
  "5.  Eligable Incurred Losses"/column=1
  box/noblanklines/noheadings total[l_current_incurred]
  /mask="(ZZZ,ZZZ,ZZZ.99)"/column=50
    total[l_year2_incurred]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=80
    total[l_year3_incurred]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=100
    l_3year_eligable_incurred_losses /mask="(ZZZ,ZZZ,ZZZ.99)"/column=130
  end box
  ""/newlines=2
  "6.  Stop Loss Adjustment    "/column=1
  box/noblanklines/noheadings total[l_current_stop_loss]
  /mask="(ZZZ,ZZZ,ZZZ.99)"/column=50
    total[l_year2_stop_loss]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=80
    total[l_year3_stop_loss]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=100
    l_3year_stop_loss_adjustment /mask="(ZZZ,ZZZ,ZZZ.99)"/column=130
  
  end box
  ""/newlines=2
  "7.  Adjusted Loss Ratio      "/column=1
  box/noblanklines/noheadings --(((total[l_current_incurred] - total[l_current_stop_loss]) divide total[l_current_earned_premium])*100)+0.03/mask="(ZZ,ZZZ,ZZZ.99%)"/column=50
  --    ((total[l_year2_stop_loss] divide total[l_year2_earned_premium] + 0.03)*100) /mask="(ZZ,ZZZ,ZZZ.99%)"/column=75
  --    ((total[l_year3_stop_loss] divide total[l_year3_earned_premium] + 0.03)*100) /mask="(ZZ,ZZZ,ZZZ.99%)"/column=95
   contingentagent:adjusted_loss_ratio[1]/mask="(ZZ,ZZZ,ZZZ.99%)"
  /column=50
   contingentagent:adjusted_loss_ratio[2]/mask="(ZZ,ZZZ,ZZZ.99%)"
  /column=80
   contingentagent:adjusted_loss_ratio[3]/mask="(ZZ,ZZZ,ZZZ.99%)"
  /column=100
   l_3year_adjusted_loss_ratio /mask="(ZZZ,ZZZ,ZZZ.99%)"/column=130
  end box
  ""/newlines=2
  "8.  Eligable Paid Commisions"/column=1
  box/noblanklines/noheadings total[l_current_commission]
  /mask="(ZZZ,ZZZ,ZZZ.99)"/column=50
    total[l_year2_commission]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=80
    total[l_year3_commission]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=100
    l_3year_paid_commissions /mask="(ZZZ,ZZZ,ZZZ.99)"/column=130
  end box
  ""/newlines=2
  "9.  Allowences             "/column=1
  box/noblanklines/noheadings total[l_current_allowences]
  /mask="(ZZZ,ZZZ,ZZZ.99)"/column=50
    total[l_year2_allowences]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=80
    total[l_year3_allowences]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=100
    l_3year_allowences /mask="(ZZZ,ZZZ,ZZZ.99)"/column=130
  end box
  ""/newlines=2
  "10. Total Compensation     "/column=1
  box/noblanklines/noheadings total[l_current_commission]  +
  total[l_current_allowences]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=50
    total[l_year3_commission]    + total[l_year2_allowences]
  /mask="(ZZZ,ZZZ,ZZZ.99)"/column=82
    total[l_year3_commission]    + total[l_year3_allowences]
  /mask="(ZZZ,ZZZ,ZZZ.99)"/column=100
    l_3year_total_compensation /mask="(ZZZ,ZZZ,ZZZ.99)"/column=130
  end box
  ""/newlines=2
  "11. Compensation Ratio     "/column=1
  box/noblanklines/noheadings ((total[l_current_commission]  +
  total[l_current_allowences]) divide total[l_current_include_premium]) *
  100 /mask="(ZZ,ZZZ,ZZZ.99%)"/column=50
    ((total[l_year3_commission]    + total[l_year2_allowences])  divide
  total[l_year2_include_premium]) * 100 /mask="(ZZ,ZZZ,ZZZ.99%)"/column=80
    ((total[l_year3_commission]    + total[l_year3_allowences]) divide
  total[l_year2_include_premium]) * 100 /mask="(ZZ,ZZZ,ZZZ.99%)"
  /column=100
    l_3year_compensation_ratio /mask="(ZZZ,ZZZ,ZZZ.99%)"/column=130
  end box
  ""/newlines=2
  "12. Adjust Loss & Exp Ratio"/column=1
  box/noblanklines/noheadings ((((total[l_current_commission]    +
  total[l_current_allowences])  divide
  total[l_current_include_premium])*100)
  + ((((total[l_current_incurred] - total[l_current_stop_loss]) divide
  total[l_current_earned_premium])*100)+0.03))/mask="(ZZZ,ZZZ,ZZZ.99%)"
  /column=50
  
    ((total[l_year2_commission]    + total[l_year2_allowences])  divide
  total[l_year2_include_premium]
  + (total[l_year2_stop_loss] divide total[l_year2_earned_premium] +
  0.03)) * 100 /mask="(ZZZ,ZZZ,ZZZ.99%)"/column=80
  
    ((total[l_year3_commission]    + total[l_year2_allowences])  divide
  total[l_year2_include_premium]
  + (total[l_year2_stop_loss] divide total[l_year2_earned_premium] +
  0.03)) * 100 /mask="(ZZZ,ZZZ,ZZZ.99%)"/column=100
  
    l_3year_combined_ratio /mask="(ZZZ,ZZZ,ZZZ.99%)"/column=130
  
  end box
  ""/newlines=2
  "13.  % Factor             "/column=1
  box/noblanklines/noheadings contingentagent:factor[1]
  /mask="(ZZZ,ZZZ,ZZZ.99%)"/column=50
    contingentagent:factor[2]/mask="(ZZZ,ZZZ,ZZZ.99%)"/column=130
  end box
  ""/newlines=2
  "14.  Contingent Commission"/column=1
  box/noblanklines/noheadings contingentagent:contingent_commission_year1 
  /mask="(ZZZ,ZZZ,ZZZ.99)"/column=51
  contingentagent:contingent_commission_year3 /mask="(ZZZ,ZZZ,ZZZ.99)"
  /column=130
  end box
  ""/newlines=2
  "15.  Loss Limitation Factor"/column=1
  box/noblanklines/noheadings contingentagent:loss_limitation_adjustment 
  /mask="(ZZZ,ZZZ,ZZZ.99)"/column=50
  end box
  ""/newlines=2
  "16.  Contingent Commission (1YR)"/column=1
  box/noblanklines/noheadings contingentagent:contingent_commission_year1 
  /mask="(ZZZ,ZZZ,ZZZ.99)"/column=45
  "                    "/column=80
  "                    "/column=100
  end box
  ""/newlines=2
  "17.  Contingent Commission (3YR)"/column=1
  box/noblanklines/noheadings contingentagent:contingent_commission_year3 
  /mask="(ZZZ,ZZZ,ZZZ.99)"/column=45
  "                    "/column=80
  "                    "/column=100
  
  end box
  ""/newlines=2
  "18.  Contingent Commissions (TOTAL)"/column=1
  box/noblanklines/noheadings contingentagent:contingent_commission_total 
  /mask="(ZZZ,ZZZ,ZZZ.99)"/column=42
  "                    "/column=80
  "                    "/column=100
  
  end box
  ""/newline

top of page 
  "G & G Underwriters, LLC"/column=50
  --sfscompany:name[1]/column=50
  
  str(year(l_accounting_date)) + " Contingent Commissions"/column=110
  "133 FRANKLIN CORNER ROAD"/column=50/newline
  "LAWRENCEVILLE, NJ  08648-2531"/column=50/newlines=3
  contingentagent:agent_no
  sfsagenta:name[1]/noheading
  "     Selected Stop Loss " + str(contingentagent:stop_Loss,"ZZZ,ZZZ")
  /newlines=2
  "Accounting Years            "/column=1
  year(l_accounting_date)/noheading/column=87
  year(l_accounting_date2)/noheading/column=117
  year(l_accounting_date3)/noheading/column=137
  "3 YEAR"/column=163/newlines=2
