include "startend.inc"

define string l_name1[50]=sfpname:name[1]
--define signed ascii number l_balance = if prsmaster:status one of "O" then prsmaster:installment_amount 
define unsigned ascii number l_commission = prsmaster:comm_rate

--date selection option 1 - written basis
where ((prsmaster:trans_date => l_starting_date and 
        prsmaster:trans_date <= l_ending_date and 
        prsmaster:trans_eff  <= l_ending_date) or 
       (prsmaster:trans_date <  l_starting_date and 
        prsmaster:trans_eff  => l_starting_date and 
        prsmaster:trans_eff  <= l_ending_date))


/* date selection option 2 - due date */
--where prsmaster:due_date => l_starting_date and 
--      prsmaster:due_date <= l_ending_date 

and prsmaster:trans_code <= 17

list
/nobanner
/hold="arspremium"
/nodetail
/domain="prsmaster"

sorted by prsmaster:policy_no 

end of prsmaster:policy_no 
prsmaster:policy_no/keyelement=1/name="policy_no"
total[prsmaster:premium]/name="premium"
