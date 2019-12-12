define wdate l_starting_date = 12.01.2018
define wdate l_ending_date = 12.31.2018

--where arspayment:payment_trans_date => l_starting_date and 
--      arspayment:payment_trans_date <= l_ending_date and
--      arspayment:amount <> 0 
where arspayment:Policy_no one of 120001250, 750001193, 800000415, 809000013,
        15668, 60004536

list/nobanner/domain="arspayment"
  arspayment:policy_no 
  arspayment:trans_date 
  arspayment:trans_eff 
  arspayment:trans_exp 
  arspayment:line_of_business 
  arspayment:trans_code 
  arspayment:comm_rate/nototal 
  arspayment:billing_ctr /nototal 
  arspayment:payment_ctr /nototal 
  arspayment:lob_subline 
  arspayment:payment_trans_date 
  arspayment:amount /total/mask="(ZZZ,ZZZ,ZZZ.99)"
  arspayment:check_reference/nototal 

  sorted by arspayment:trans_code/total/newlines 
            arspayment:policy_no
