viewpoint native;

where arscancel:trans_date = todaysdate 

list/nobanner/domain="arscancel"
  arscancel:policy_no 
  arscancel:trans_code 
  arscancel:trans_date 
  arscancel:trans_eff 
  arscancel:due_date 
  arscancel:cx_eff_date 
  arscancel:cx_date 
  arscancel:amount_past_due
  arsbilling:agent_no 

sorted by arscancel:trans_date
          arscancel:agent_no /newlines
