include "startend.inc"

define wdate l_eff_date_start = parameter/prompt= "Enter Beginning Effective Date" default l_starting_date 
define wdate l_eff_date_end = parameter/prompt= "Enter Ending Effective Date" default l_ending_date 

define wdate l_quarter1_end = if dateadd(l_starting_date,3) <= l_ending_date then  
dateadd(l_starting_date,3)-1 else l_ending_date 

define wdate l_quarter2_start = if l_quarter1_end + 1 <= l_ending_date then l_quarter1_end + 1 else 00.00.0000
define wdate l_quarter2_end = if dateadd(l_quarter1_end,3) <= l_ending_date then dateadd(l_quarter1_end,3) else 00.00.0000

define wdate l_quarter3_start = if l_quarter2_end + 1 <= l_ending_date  then l_quarter2_end + 1 else 00.00.0000
define wdate l_quarter3_end = if dateadd(l_quarter2_end,3) <= l_ending_date then dateadd(l_quarter1_end,3) else l_ending_date 

define wdate l_quarter4_start = if l_quarter3_end + 1 <= l_ending_date then l_quarter3_end + 1 else 00.00.000
define wdate l_quarter4_end = if dateadd(l_quarter3_end,3) <= l_ending_date then dateadd(l_quarter3_end,3) else l_ending_date 

define l_month1_start = l_starting_date
define l_month1_end   = dateadd(l_starting_date , 1) -1 

define l_month2_start = l_starting_date
define l_month2_end   = dateadd(l_starting_date , 2) -1 

define l_month3_start = l_starting_date
define l_month3_end   = dateadd(l_starting_date , 3) -1 

define l_month4_start = l_starting_date
define l_month4_end   = dateadd(l_starting_date , 4) -1 

define l_month5_start = l_starting_date
define l_month5_end   = dateadd(l_starting_date , 5) -1 

define l_month6_start = l_starting_date
define l_month6_end   = dateadd(l_starting_date , 6) -1 

define l_month7_start = l_starting_date
define l_month7_end   = dateadd(l_starting_date , 7) -1 

define l_month8_start = l_starting_date
define l_month8_end   = dateadd(l_starting_date , 8) -1 

define l_month9_start = l_starting_date
define l_month9_end   = dateadd(l_starting_date , 9) -1 

define l_month10_start = l_starting_date
define l_month10_end   = dateadd(l_starting_date , 10) -1 

define l_month11_start = l_starting_date
define l_month11_end   = dateadd(l_starting_date , 11) -1 

define l_month12_start = l_starting_date
define l_month12_end   = dateadd(l_starting_date , 12) -1 

define signed ascii number l_date1_written = if l_ending_date => l_month1_end then 
 if ((prsmaster:trans_date => l_month1_start and 
      prsmaster:trans_date <= l_month1_end and 
      prsmaster:trans_eff  <= l_month1_end) or 
     (prsmaster:trans_date <  l_month1_start and 
      prsmaster:trans_eff  => l_month1_start and 
      prsmaster:trans_eff  <= l_month1_end)) then prsmaster:premium else 0.00
else 0.00

define signed ascii number l_date2_written = if l_ending_date => l_month2_end then 
 if ((prsmaster:trans_date => l_month2_start and 
      prsmaster:trans_date <= l_month2_end and 
      prsmaster:trans_eff  <= l_month2_end) or 
     (prsmaster:trans_date <  l_month2_start and 
      prsmaster:trans_eff  => l_month2_start and 
      prsmaster:trans_eff  <= l_month2_end)) then prsmaster:premium else 0.00
else 0.00

define signed ascii number l_date3_written = if l_ending_date => l_month3_end then 
 if ((prsmaster:trans_date => l_month3_start and 
      prsmaster:trans_date <= l_month3_end and 
      prsmaster:trans_eff  <= l_month3_end) or 
     (prsmaster:trans_date <  l_month3_start and 
      prsmaster:trans_eff  => l_month3_start and 
      prsmaster:trans_eff  <= l_month3_end)) then prsmaster:premium else 0.00
else 0.00

define signed ascii number l_date4_written = if l_ending_date => l_month4_end then 
 if ((prsmaster:trans_date => l_month4_start and 
      prsmaster:trans_date <= l_month4_end and 
      prsmaster:trans_eff  <= l_month4_end) or 
     (prsmaster:trans_date <  l_month4_start and 
      prsmaster:trans_eff  => l_month4_start and 
      prsmaster:trans_eff  <= l_month4_end)) then prsmaster:premium else 0.00
else 0.00

define signed ascii number l_date5_written = if l_ending_date => l_month5_end then 
 if ((prsmaster:trans_date => l_month5_start and 
      prsmaster:trans_date <= l_month5_end and 
      prsmaster:trans_eff  <= l_month5_end) or 
     (prsmaster:trans_date <  l_month5_start and 
      prsmaster:trans_eff  => l_month5_start and 
      prsmaster:trans_eff  <= l_month5_end)) then prsmaster:premium else 0.00
else 0.00

define signed ascii number l_date6_written = if l_ending_date => l_month6_end then 
 if ((prsmaster:trans_date => l_month6_start and 
      prsmaster:trans_date <= l_month6_end and 
      prsmaster:trans_eff  <= l_month6_end) or 
     (prsmaster:trans_date <  l_month6_start and 
      prsmaster:trans_eff  => l_month6_start and 
      prsmaster:trans_eff  <= l_month6_end)) then prsmaster:premium else 0.00
else 0.00

define signed ascii number l_date7_written = if l_ending_date => l_month7_end then 
 if ((prsmaster:trans_date => l_month7_start and 
      prsmaster:trans_date <= l_month7_end and 
      prsmaster:trans_eff  <= l_month7_end) or 
     (prsmaster:trans_date <  l_month7_start and 
      prsmaster:trans_eff  => l_month7_start and 
      prsmaster:trans_eff  <= l_month7_end)) then prsmaster:premium else 0.00
else 0.00

define signed ascii number l_date8_written = if l_ending_date => l_month8_end then 
 if ((prsmaster:trans_date => l_month8_start and 
      prsmaster:trans_date <= l_month8_end and 
      prsmaster:trans_eff  <= l_month8_end) or 
     (prsmaster:trans_date <  l_month8_start and 
      prsmaster:trans_eff  => l_month8_start and 
      prsmaster:trans_eff  <= l_month8_end)) then prsmaster:premium else 0.00
else 0.00

define signed ascii number l_date9_written = if l_ending_date => l_month9_end then 
 if ((prsmaster:trans_date => l_month9_start and 
      prsmaster:trans_date <= l_month9_end and 
      prsmaster:trans_eff  <= l_month9_end) or 
     (prsmaster:trans_date <  l_month9_start and 
      prsmaster:trans_eff  => l_month9_start and 
      prsmaster:trans_eff  <= l_month9_end)) then prsmaster:premium else 0.00
else 0.00

define signed ascii number l_date10_written =  if l_ending_date =>l_month10_end then 
 if ((prsmaster:trans_date => l_month10_start and 
      prsmaster:trans_date <= l_month10_end and 
      prsmaster:trans_eff  <= l_month10_end) or 
     (prsmaster:trans_date <  l_month10_start and 
      prsmaster:trans_eff  => l_month10_start and 
      prsmaster:trans_eff  <= l_month10_end)) then prsmaster:premium else 0.00
else 0.00

define signed ascii number l_date11_written = if l_ending_date => l_month11_end then 
 if ((prsmaster:trans_date => l_month11_start and 
      prsmaster:trans_date <= l_month11_end and 
      prsmaster:trans_eff  <= l_month11_end) or 
     (prsmaster:trans_date <  l_month11_start and 
      prsmaster:trans_eff  => l_month11_start and 
      prsmaster:trans_eff  <= l_month11_end)) then prsmaster:premium else 0.00
else 0.00

define signed ascii number l_date12_written = if l_ending_date => l_month12_end then 
 if ((prsmaster:trans_date => l_month12_start and 
      prsmaster:trans_date <= l_month12_end and 
      prsmaster:trans_eff  <= l_month12_end) or 
     (prsmaster:trans_date <  l_month12_start and 
      prsmaster:trans_eff  => l_month12_start and 
      prsmaster:trans_eff  <= l_month12_end)) then prsmaster:premium else 0.00
else 0.00

define signed ascii number l_written = 
 if ((prsmaster:trans_date => l_starting_date and 
      prsmaster:trans_date <= l_ending_date and 
      prsmaster:trans_eff  <= l_ending_date) or 
     (prsmaster:trans_date <  l_starting_date and 
      prsmaster:trans_eff  => l_starting_date and 
      prsmaster:trans_eff  <= l_ending_date)) then prsmaster:premium else 0.00

include "prscollect.inc"
and with prsmaster:trans_code < 17 
and with (prsmaster:trans_eff => l_eff_date_start and 
          prsmaster:trans_eff <= l_eff_date_end)

list
/nobanner
/domain="prsmaster"
/nodetail 
/title="Premiums by Processing Month within Reinsurance Treaty Period"
/xls="Premiums_by_processing_date_and_line_of_business_running_total"
/pagelength=0

sorted by prsmaster:line_of_business
          prsmaster:lob_subline 

top of page  
enquiryname                                                                               /heading="Report No      "/left/column=1
/newline
trun(sfscompany:name[1,1,30])                                                                  /heading="Company Name   "/left/column
=1/newline  
trun(str(l_starting_date,"MM/DD/YYYY") + " - " + str(l_ending_date,"MM/DD/YYYY"))/column=1/heading="Report Period  "/left/newline
 
""/newline 
"Reinsurance Period "/column=1/left 
str(l_eff_date_start,"MM/DD/YYYY") + " - " + str(l_eff_date_end,"MM/DD/YYYY")/column=30/newline
 
"Processing Month"/column=130
""/newline=2 
str(l_month1_end,"MMM YYYY")/column=90
str(l_month2_end,"MMM YYYY")/column=110
str(l_month3_end,"MMM YYYY")/column=130
str(l_month4_end,"MMM YYYY")/column=150
str(l_month5_end,"MMM YYYY")/column=170
str(l_month6_end,"MMM YYYY")/column=190
str(l_month7_end,"MMM YYYY")/column=210
str(l_month8_end,"MMM YYYY")/column=230
str(l_month9_end,"MMM YYYY")/column=250
str(l_month10_end,"MMM YYYY")/column=270
str(l_month11_end,"MMM YYYY")/column=290
str(l_month12_end,"MMM YYYY")/column=310
""/newline 

end of prsmaster:line_of_business  
box/noblanklines/noheadings 
  sfsline_heading:description/column=1/width=30
  total [l_date1_written]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=90
  total [l_date2_written]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=110
  total [l_date3_written]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=130
  total [l_date4_written]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=150
  total [l_date5_written]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=170
  total [l_date6_written]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=190
  total [l_date7_written]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=210
  total [l_date8_written]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=230
  total [l_date9_written]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=250
  total [l_date10_written]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=270
  total [l_date11_written]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=290
  total [l_date12_written]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=310
end box

end of report 
box/noblanklines/noheadings 
  ""/newline=2 
  "GRAND TOTAL"
  total [l_date1_written]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=90
  total [l_date2_written]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=110
  total [l_date3_written]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=130
  total [l_date4_written]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=150
  total [l_date5_written]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=170
  total [l_date6_written]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=190
  total [l_date7_written]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=210
  total [l_date8_written]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=230
  total [l_date9_written]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=250
  total [l_date10_written]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=270
  total [l_date11_written]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=290
  total [l_date12_written]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=310
end box
