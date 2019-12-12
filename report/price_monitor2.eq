define wdate l_ending_date = 01.31.2015
define wdate l_starting_date = dateadd(l_ending_date,0,-11) 

define unsigned ascii number l_year1 = year(price_monitor2:eff_date[1])
define unsigned ascii number l_year2 = year(price_monitor2:eff_date[2])

define signed ascii number l_rate_1 = round((price_monitor2:written_premium[1] divide price_monitor2:exposure[1]),5)
define signed ascii number l_rate_2 = round((price_monitor2:written_premium[2] divide price_monitor2:exposure[2]),5)

list
/nobanner
/domain="price_monitor2"

  price_monitor2:policy_no /column=1
  price_monitor2:trans_code[1] /column=15
  price_monitor2:insured_name[1] /column=30

  price_monitor2:line_of_business[1]/heading="Line of-Business" /column=70
---  price_monitor2:line_of_business[2]/heading="LOB" /column=90

  price_monitor2:exposure[1] /column=110/heading=str(l_year1)+"-Exposure"
  price_monitor2:exposure[2] /column=130/heading=str(l_year2)+"-Exposure"

  price_monitor2:written_premium[1]/mask="(ZZZ,ZZZ,ZZZ.99)" /column=150/heading=str(l_year1)+"-Written-Premium"
  price_monitor2:written_premium[2]/mask="(ZZZ,ZZZ,ZZZ.99)" /column=170/heading=str(l_year2)+"-Witten-Premium"

 -- price_monitor2:rate_change[1]/mask="(Z,ZZZ.99999)"/column=190/heading="Rate-Change"

  round((price_monitor2:written_premium[1] divide price_monitor2:exposure[1]),5)/column=210/heading=str(l_year1)+"-Rate"/mask="(ZZ9.99999)"
  round((price_monitor2:written_premium[2] divide price_monitor2:exposure[2]),5)/column=230/heading=str(l_year2)+"-Rate"/mask="(ZZ9.99999)"

  round(((l_rate_2 - l_rate_1) divide l_rate_2),5)/column=250/heading="Percent-Change"/mask="(ZZ9.99999)"

--  price_monitor2:rate_change[2]/mask="(Z,ZZZ.99999)"/column=210/heading="Year 2-Rate-Change"

--  price_monitor2:percent_changed[1] /column=230/heading="Year 1-Percent-Changed"
--  price_monitor2:percent_changed[2] /column=250/heading="Percent-Changed"

/* price_monitor2:trans_date[1]/mask="MM/DD/YYYY" /column=270/heading=str(l_year1)+"-Trans-Date"
  price_monitor2:trans_date[2]/mask="MM/DD/YYYY" /column=290/heading=str(l_year2)+"-Trans-Date"

  price_monitor2:trans_eff[1]/mask="MM/DD/YYYY" /column=310/heading=str(l_year1)+"-Trans-Eff"
  price_monitor2:trans_eff[2]/mask="MM/DD/YYYY" /column=330/heading=str(l_year2)+"-Trans-Eff"

  price_monitor2:trans_exp[1]/mask="MM/DD/YYYY" /column=350/heading=str(l_year1)+"-Trans-Exp"
  price_monitor2:trans_exp[2]/mask="MM/DD/YYYY" /column=370/heading=str(l_year2)+"-Trans-Exp"

  price_monitor2:eff_date[1]/mask="MM/DD/YYYY" /column=390/heading=str(l_year1)+"-Eff-Date"
  price_monitor2:eff_date[2]/mask="MM/DD/YYYY" /column=410/heading=str(l_year2)+"-Eff-Date"
*/

 -- price_monitor2:month_written[1] /column=270/heading=str(l_year1)+"-Month-Written"
 -- price_monitor2:month_written[2] /column=290/heading=str(l_year2)+"-Month-Written"

  --price_monitor2:year_written[1]/column=310/heading=str(l_year1)+"-Year-Written"
  --price_monitor2:year_written[2]/column=330/heading=str(l_year2)+"-Year-Written"

top of page
enquiryname /column=1/heading="  Report Name"/newline 
price_monitor2:month_written/column=1/heading="  Month" 
--price_monitor2:year_written/column=15/mask="9999"/heading=" Year" /newline
l_year2/column=15/mask="9999"/heading=" Year" /newline
