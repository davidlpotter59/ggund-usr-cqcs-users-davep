 include "startend.inc"

--where prspremloss_combined:policy_no one of 23807, 900000132, 23712, 800000792, 20136, 50000657, 80000243, 510000179, 900000727
--and prspremloss_combined:claim_no <> 0
--where prspremloss_combined:agent_no one of 9990
--where prspremloss_combined:claim_no one of 20010530038, 20010611017, 20010618001,
--        20010618005, 44409100002, 44410010039, 44410020004, 44410050003,
--        44410070034, 44410120013, 44411010002, 44411040008
--where prspremloss_combined:agent_no one of 9990
--or prspremloss_combined:claim_no one of 77710030001
          
where prspremloss_combined:start_date_yyyy = year(l_starting_date) and
      prspremloss_combined:start_date_mm   = month(l_starting_date) and
      prspremloss_combined:end_date_yyyy   = year(l_ending_date) and
      prspremloss_combined:end_date_mm     = month(l_ending_date) 
--where prspremloss_combined:start_date_yyyy = 2018
list
/nobanner
/domain="prspremloss_combined"
/duplicates 
--/nodetail 

prspremloss_combined:policy_no 
--prspremloss_combined:agent_no 
--line_of_business 
--claim_no 
--written_premium /total 
--start_date_yyyy start_date_mm 
--end_date_yyyy end_date_mm 
--unearned_premium_prior/total  
--loss_paid_prior/total  
--loss_paid_current/total  
--loss_reserve_prior/total  
--loss_reserve_current/total 
 --ulae_reserve_prior ulae_reserve_current alae_reserve_prior alae_reserve_current
alae_paid_prior /total 
alae_paid_current /total 
ulae_paid_prior /total 
ulae_paid_current /total 
ulae_reserve_current /total 
ulae_reserve_prior /total 
alae_reserve_prior /total 
alae_reserve_current/total 
--loss_paid_prior 
--loss_paid_current/total 2

sorted by prspremloss_combined:claim_no 
--prspremloss_combined:agent_no

/*
end of prspremloss_combined:claim_no 
box/noblanklines/noheadings 
prspremloss_combined:policy_no 
prspremloss_combined:agent_no 
claim_no 
written_premium
--unearned_premium_prior loss_paid_prior loss_paid_current alae_paid_prior alae_paid_current ulae_paid_prior ulae_paid_current loss_reserve_prior loss_reserve_current
-- ulae_reserve_prior ulae_reserve_current alae_reserve_prior alae_reserve_current

xob
*/
