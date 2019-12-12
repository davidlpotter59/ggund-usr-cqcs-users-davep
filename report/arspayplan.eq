viewpoint native;


/* end of file */ where 
  arspayplan:line_of_business not one of
    1,
    3,
    4,
    12,
    14,
    24,
    10

list/nobanner/domain="arspayplan"/title=sfscompany:name[1]
  
  --company_id 
  --arspayplan:line_of_business
  sfsline_heading:description 
  arspayplan:payment_plan 
  arspayplan:description 
  arspayplan:invoice_days_between 
  arspayplan:installment_months_between 
  arspayplan:number_of_payments /nototal 
  arspayplan:installment_charge_rate/nototal 
  arspayplan:late_fee/nototal 
  --""/heading="New Installment-Charge Rate"
  
sorted by arspayplan:line_of_business /newlines
          arspayplan:payment_plan 

top of report
box/noblanklines/noheadings 
  " Payment Plan Table"/column=70
end box
