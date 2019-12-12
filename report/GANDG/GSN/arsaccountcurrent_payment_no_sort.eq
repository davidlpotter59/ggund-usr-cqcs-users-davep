include "startend.inc"

define file arspayplana = access arspayplan, set arspayplan:company_id       = arspayment:company_id, 
                                                 arspayplan:line_of_business = arspayment:line_of_business,
                                                 arspayplan:payment_plan     = arsbilling:payment_plan 

access arspremium, set arspremium:policy_no= arspayment:policy_no 
access arspremium_total, set arspremium_total:code= 9

define file arsrefund = access arscheck_refund, set arscheck_refund:policy_no = arspayment:policy_no

define signed ascii number l_balance = arsbilling:installment_amount - arspayment:amount 

define unsigned ascii number l_comm_rate = 25.00

define string l_name[50] = sfpname:name[1]

define signed ascii number l_fees = if arspayment:trans_code one of 18 then arspayment:amount else 0
define signed ascii number l_comm_amount = arspremium_total:premium  * (l_comm_rate * 0.01)
define signed ascii number l_net = arspayment:amount - l_fees - l_comm_amount

where 1 = 1 -- arspayment:comm_rate <> 0
--and arspayment:policy_no one of 572
--and (arspayment:trans_date => l_starting_date and 
--     arspayment:trans_date <= l_ending_date and 
--     arschksu:internal_check = 0) 
and (arschksu:trans_date => l_starting_date and 
     arschksu:trans_date <= l_ending_date) 
and arschksu:internal_check one of 0

list
/nobanner
/domain="arspayment"
--/nodetail 
/title="GSN Account Current"

  arspayment:policy_no 
  l_name/heading="Insureds Name"
  arspayment:trans_date 
  arspayment:trans_eff 
  arspayment:trans_exp 
  arspayment:payment_trans_date 
  l_comm_rate /heading="Comm-Rate" 
  0/heading="Deposit"/name="deposit"
  arspremium:premium /heading="Total DWP"/mask="(ZZZ,ZZZ,ZZZ.99)"
  arspayment:amount/heading="Total-Paid" 
  arsbilling:due_date 
  arsbilling:billing_ctr /heading="Installment #"
  arsbilling:installment_amount /heading="Amount-Due"
--  arsbilling:total_amount_paid 
  l_fees/heading="Fees"
  arspayplana:number_of_payments /duplicates /name="installments"
  l_balance/heading="Balance"
  arsrefund:check_amount

sorted by arspayment:policy_no--/newlines 
          arsbilling:due_date
