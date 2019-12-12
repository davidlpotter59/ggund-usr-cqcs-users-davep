viewpoint native;

list/nobanner/domain="conttable"
  conttable:company_id 
  conttable:base_premium 
  conttable:base_loss_ratio upper_ratio 
  conttable:effective_date 
  conttable:commission1 /heading="Less than-10.0%"
  conttable:commission2 /heading="10.0% to - 24.9%"
  conttable:commission3 /heading="25.0% or-Greater"
--  conttable:commission4 
--  conttable:commission5 
  conttable:partb/heading="Part B"

sorted by conttable:base_premium/newlines
          conttable:base_loss_ratio
