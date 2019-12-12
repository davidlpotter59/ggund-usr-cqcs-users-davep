where prsmaster:trans_eff => 12.01.2018

sum
/domain="prsmaster"

prsmaster:premium

across  
month(prsmaster:trans_eff)

by sfsline_heading:description
