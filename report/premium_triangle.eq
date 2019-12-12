include "startend.inc" -- use these dates for the Time Period (Effectice date range)

define wdate l_ending_date2 = parameter/prompt="Enter AS OF DATE<NL>Evaluation Date" -- combine this date with l_starting_date for eval period
/* PRSCOLLECT.inc 

   SCIPS.com

   December 21, 1998

   Include file to select premium records for a given Date Range 
   
   WARNING:  Starting date and Ending date must be defined prior to this
             include.  You must place this just before the list statement.
             If the enquiry that you are editing has another where statement
             you may want to place this prior to that one, add your brackets and
             include a "and" between the 2 conditions.  You will also have to
             remove the other "where" that is in the actual code of the enquiry.
*/

where 

/* TRANSACTED PRIOR TO START DATE WITH EFFECTIVE DATES WITHIN
   THE START DATE and THE END DATE */

((prsmaster:trans_date < l_starting_date and
 prsmaster:trans_eff => l_starting_date and
 prsmaster:trans_eff <= l_ending_date) or

/* TRANSACTED WITHIN THE START DATE and THE END DATE WITH
   EFFECTIVE DATES NOT > THE l_ending_date */

(prsmaster:trans_date => l_starting_date and
 prsmaster:trans_date <= l_ending_date2 and
 prsmaster:trans_eff <= l_ending_date))

and

prsmaster:trans_eff <> prsmaster:trans_exp

and

 prsmaster:premium <> 0

and prsmaster:eff_date => l_starting_date 
and prsmaster:eff_date <= l_ending_date 
and prsmaster:trans_code < 17
and sfsline:line_type not one of "W"

list
/nobanner
/domain="prsmaster"
/nodetail 

prsmaster:policy_no 
prsmaster:line_of_business
prsmaster:lob_subline 
sfsline:description 
prsmaster:eff_date 
prsmaster:trans_date 
prsmaster:trans_eff 
prsmaster:premium/mask="(ZZZ,ZZZ,ZZZ.99)"

sorted by sfsline:description

end of sfsline:description 
box/noblanklines/noheadings 
sfsline:description 
sfsline:lob_code 
sfsline:line_type 
total[prsmaster:premium]/mask="(ZZZ,ZZZ,ZZZ.99)"
xob
