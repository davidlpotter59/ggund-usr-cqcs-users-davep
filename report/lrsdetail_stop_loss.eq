define file sfsagtstoplossa = access sfsagtstoploss, 
set sfsagtstoploss:company_id= lrssetup:company_id,
    sfsagtstoploss:agent_no  = lrssetup:agent_no,generic, one to many  

define l_stop_loss_amount = if lrssetup:reported_date => sfsagtstoplossa:reff_date and 
                               lrssetup:reported_date <= sfsagtstoplossa:rexp_date and
                               lrssetup:agent_no = sfsagtstoplossa:agent_no then 
                                  sfsagtstoplossa:stop_loss_amount else 99999999
   
where 1 = 1 
--and sfsagent:agent_master_code one of 128, 150, 173, 224, 262
and sfsagent:agent_master_code one of 262

and lrssetup:reported_date => 01.01.2005

list
/nobanner
/domain="lrsdetail"
/duplicates 

lrssetup:agent_no 
lrsdetail:claim_no 
lrssetup:reported_date 
l_stop_loss_amount/nototal /duplicates 

sorted by lrssetup:agent_no/newpage
