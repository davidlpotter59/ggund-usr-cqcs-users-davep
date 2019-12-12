viewpoint native;

where arsbilling:policy_no one of 
7252, 14096, 15648, 16364, 17121, 20112, 20516, 20860, 23062, 23808, 23816,
        119000001, 500000264, 500000311, 500000560, 500002420, 500003640,
        509000003, 509000015, 509000040, 509000041, 509000048, 510001340,
        519000005, 519000009, 600000548, 600000628, 600003168, 600003644,
        600003736, 600003964, 600004080, 600004144, 600004148, 600004687,
        600005048, 600005364, 600005576, 609000010, 609000012, 609000019,
        700001364, 800000316, 800000695, 800002806, 800003057, 800003064,
        800003378, 800003428, 800003576, 800003624, 800003648, 800003652,
        809000027, 809000101, 809000123
and arsbilling:status one of "B"

list/nobanner/domain="arsbilling"/pagelength=0
  arsbilling:policy_no 
  arsbilling:trans_date 
  arsbilling:trans_exp 
  arsbilling:trans_code 
  arsbilling:line_of_business 
  arsbilling:lob_subline 
  arsbilling:comm_rate 
  arsbilling:billed_date 
  arsbilling:status 
  arsbilling:status_date 
  arsbilling:due_date 
  arsbilling:total_amount_paid 
  arsbilling:installment_amount 
  arsbilling:premium

sorted by arsbilling:policy_no /newlines 
          arsbilling:trans_code
