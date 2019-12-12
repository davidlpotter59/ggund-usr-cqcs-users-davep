define file sfppointa = access sfppoint, set sfppoint:policy_no= sfpname_sync:policy_no, 
                                             sfppoint:pol_year = sfpname_sync:pol_year 

define file sfpcurrenta = access sfpcurrent, set sfpcurrent:policy_no= sfpname_sync:policy_no 

where sfpname_sync:pol_year => 2010

list
/domain="sfpname_sync"


if sfpname_sync:policy_no <> sfppointa:policy_no or 
   sfpname_sync:pol_year  <> sfppointa:pol_year or 
   sfpname_sync:end_sequence <> sfppointa:end_sequence then 
   {
     sfpname_sync:policy_no /heading="SFPNAME-POLICY-NUMBER"
     sfppointa:policy_no /heading="SFPPOINT-POLICY-NUMBER"
     "E R R O R SFPPOINT"
   }

if sfpname_sync:policy_no <> sfpcurrenta:policy_no or 
   sfpname_sync:pol_year  <> sfpcurrenta:pol_year or 
   sfpname_sync:end_sequence <> sfpcurrenta:end_sequence then 
   {
    sfpname_sync:policy_no /heading="SFPNAME-POLICY-NUMBER"
    sfpname_sync:pol_year  /heading="SFPNAME-POL-YEAR"
    sfpname_sync:end_sequence /heading="SFPNAME-END-SEQUENCE"
    sfpcurrenta:policy_no /heading="SFPCURRENT-POLICY-NUMBER"
    sfpcurrenta:pol_year /heading="SFPCURRENT-POL-YEAR"
    sfpcurrenta:end_sequence /heading="SFPCURRENT-END-SEQUENCE"
     "E R R O R SFPCURRENT"
   }
