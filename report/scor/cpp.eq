define wdate l_starting_date = 10.01.2016
define wdate l_ending_date   = 09.30.2017

define string l_package = if sfpname:package one of 1 then "Package Policy" else "Mono Line Policy"

define file sfpmastera = access sfpmaster, set sfpmaster:policy_no = cppliability:policy_no, 
                                               sfpmaster:pol_year  = cppliability:pol_year, 
                                               sfpmaster:end_sequence= cppliability:end_sequence 

define file sfslinea = access sfsline, set sfsline:company_id= cppliability:company_id, 
                                           sfsline:line_of_business= sfpname:line_of_business,
                                           sfsline:lob_subline= "00"

--where sfsline:lob_code  one of "UMBRELLA"
where ((sfpmastera:trans_date => l_starting_date and 
     sfpmastera:trans_date <= l_ending_date and 
     sfpmastera:trans_eff  <= l_ending_date ) or 
    (sfpmastera:trans_date < l_starting_date and 
     sfpmastera:trans_eff => l_starting_date and 
     sfpmastera:trans_eff <= l_ending_date))

and with cppliability:exposure[1] <> 0 --or limit[2] <> 0

list
/nobanner
/domain="cppliability" 

cppliability:policy_no  
cppliability:exposure[1]

sorted by sfslinea:description /newlines
