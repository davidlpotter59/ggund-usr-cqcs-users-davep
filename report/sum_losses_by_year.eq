define string l_include_lae = parameter /prompt="Include LAE (YES or NO)"/upper default "YES" error "Valid answers are NO or YES" if l_include_lae not one of "NO","YES"
define l_incurred_rerv = lrsdetail:loss_resv 
define l_incurred_paid = lrsdetail:loss_paid 
define l_incurred_lae  = if l_include_lae one of "YES" then lrsdetail:lae_paid else 0

define l_incurred_total = l_incurred_rerv + l_incurred_paid + l_incurred_lae 

sum
/nobanner 
/domain="lrsdetail"

--l_incurred_rerv/heading="Reserves" 
--l_incurred_paid/heading="Paid" 
--l_incurred_lae/heading="LAE" 
l_incurred_total /heading="Incurred-Transacted-Year"/total 

across year(lrsdetail:trans_date)/total 

by    year(lrssetup:eff_date)/heading="Effective-Year"
      lrsdetail:claim_no
