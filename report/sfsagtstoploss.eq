define file sfsagenta = access sfsagent, 
set sfsagent:company_id= sfsagtstoploss:company_id,
    sfsagent:agent_no  = sfsagtstoploss:agent_no, generic 

where 1 = 1
and sfsagenta:agent_master_code one of 128, 150, 173, 224, 262

list
/nobanner
/domain="sfsagtstoploss"

sfsagenta:agent_master_code /noduplicates 
sfsagtstoploss:agent_no /noduplicates 
sfsagtstoploss:reff_date 
sfsagtstoploss:rexp_date 
sfsagtstoploss:stop_loss_amount 

sorted by sfsagenta:agent_master_code/newlines =2
          sfsagtstoploss:agent_no /newlines 
          sfsagtstoploss:reff_date
