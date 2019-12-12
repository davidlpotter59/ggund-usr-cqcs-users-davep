include "startend.inc"
define unsigned ascii number l_include_month[2] = parameter/prompt="Enter month you which to include" 

define number year_01 = year(dateadd(l_starting_date,0,-11))
define number year_02 = year(dateadd(l_starting_date,0,-10))
define number year_03 = year(dateadd(l_starting_date,0,-09))
define number year_04 = year(dateadd(l_starting_date,0,-08))
define number year_05 = year(dateadd(l_starting_date,0,-07))
define number year_06 = year(dateadd(l_starting_date,0,-06))
define number year_07 = year(dateadd(l_starting_date,0,-05))
define number year_08 = year(dateadd(l_starting_date,0,-04))
define number year_09 = year(dateadd(l_starting_date,0,-03))
define number year_10 = year(dateadd(l_starting_date,0,-02))
define number year_11 = year(dateadd(l_starting_date,0,-01))
define number year_12 = year(l_starting_date)
define number year_13 = year(l_ending_date)  --not needed because it will be done in the same year and l_starting date.


define number yr01_activity = if price_monitor:year_written = year_01 then 1 else 0
define number yr02_activity = if price_monitor:year_written = year_02 then 1 else 0
define number yr03_activity = if price_monitor:year_written = year_03 then 1 else 0
define number yr04_activity = if price_monitor:year_written = year_04 then 1 else 0
define number yr05_activity = if price_monitor:year_written = year_05 then 1 else 0
define number yr06_activity = if price_monitor:year_written = year_06 then 1 else 0
define number yr07_activity = if price_monitor:year_written = year_07 then 1 else 0
define number yr08_activity = if price_monitor:year_written = year_08 then 1 else 0
define number yr09_activity = if price_monitor:year_written = year_09 then 1 else 0
define number yr10_activity = if price_monitor:year_written = year_10 then 1 else 0
define number yr11_activity = if price_monitor:year_written = year_11 then 1 else 0
define number yr12_activity = if price_monitor:year_written = year_12 then 1 else 0
define number yr13_activity = if price_monitor:year_written = year_13 then 1 else 0

define number yr01_exposure = if price_monitor:year_written = year_01 then price_monitor:exposure else 0
define number yr02_exposure = if price_monitor:year_written = year_02 then price_monitor:exposure else 0
define number yr03_exposure = if price_monitor:year_written = year_03 then price_monitor:exposure else 0
define number yr04_exposure = if price_monitor:year_written = year_04 then price_monitor:exposure else 0
define number yr05_exposure = if price_monitor:year_written = year_05 then price_monitor:exposure else 0
define number yr06_exposure = if price_monitor:year_written = year_06 then price_monitor:exposure else 0
define number yr07_exposure = if price_monitor:year_written = year_07 then price_monitor:exposure else 0
define number yr08_exposure = if price_monitor:year_written = year_08 then price_monitor:exposure else 0
define number yr09_exposure = if price_monitor:year_written = year_09 then price_monitor:exposure else 0
define number yr10_exposure = if price_monitor:year_written = year_10 then price_monitor:exposure else 0
define number yr11_exposure = if price_monitor:year_written = year_11 then price_monitor:exposure else 0
define number yr12_exposure = if price_monitor:year_written = year_12 then price_monitor:exposure else 0
define number yr13_exposure = if price_monitor:year_written = year_13 then price_monitor:exposure else 0

define number yr01_written_premium = if price_monitor:year_written = year_01 then price_monitor:written_premium else 0
define number yr02_written_premium = if price_monitor:year_written = year_02 then price_monitor:written_premium else 0
define number yr03_written_premium = if price_monitor:year_written = year_03 then price_monitor:written_premium else 0
define number yr04_written_premium = if price_monitor:year_written = year_04 then price_monitor:written_premium else 0
define number yr05_written_premium = if price_monitor:year_written = year_05 then price_monitor:written_premium else 0
define number yr06_written_premium = if price_monitor:year_written = year_06 then price_monitor:written_premium else 0
define number yr07_written_premium = if price_monitor:year_written = year_07 then price_monitor:written_premium else 0
define number yr08_written_premium = if price_monitor:year_written = year_08 then price_monitor:written_premium else 0
define number yr09_written_premium = if price_monitor:year_written = year_09 then price_monitor:written_premium else 0
define number yr10_written_premium = if price_monitor:year_written = year_10 then price_monitor:written_premium else 0
define number yr11_written_premium = if price_monitor:year_written = year_11 then price_monitor:written_premium else 0
define number yr12_written_premium = if price_monitor:year_written = year_12 then price_monitor:written_premium else 0
define number yr13_written_premium = if price_monitor:year_written = year_13 then price_monitor:written_premium else 0

define number l_rate_change1 = total[yr01_written_premium] divide total[yr01_exposure]
define number l_rate_change2 = total[yr02_written_premium] divide total[yr02_exposure]
define number l_rate_change3 = total[yr03_written_premium] divide total[yr03_exposure]
define number l_rate_change4 = total[yr04_written_premium] divide total[yr04_exposure]
define number l_rate_change5 = total[yr05_written_premium] divide total[yr05_exposure]
define number l_rate_change6 = total[yr06_written_premium] divide total[yr06_exposure]
define number l_rate_change7 = total[yr07_written_premium] divide total[yr07_exposure]
define number l_rate_change8 = total[yr08_written_premium] divide total[yr08_exposure]
define number l_rate_change9 = total[yr09_written_premium] divide total[yr09_exposure]
define number l_rate_change10 = total[yr10_written_premium] divide total[yr10_exposure]
define number l_rate_change11 = total[yr11_written_premium] divide total[yr11_exposure]
define number l_rate_change12 = total[yr12_written_premium] divide total[yr12_exposure]
define number l_rate_change13 = total[yr13_written_premium] divide total[yr13_exposure]


where --yprice_monitor:eff_date     >= dateadd(l_starting_date,0,-11) and
--      price_monitor:eff_date     <= l_ending_date  
      price_monitor:month_written = l_include_month 

list
/domain="price_monitor"
/duplicates
  price_monitor:policy_no /column=1
  price_monitor:pol_year /column=12
  price_monitor:end_sequence /column=17
  price_monitor:trans_code /column=25
  price_monitor:insured_name /column=30
  price_monitor:line_of_business/heading="LOB" /column=70
  price_monitor:exposure /column=75
  price_monitor:written_premium/mask="(ZZZ,ZZZ,ZZZ.99)" /column=90
  price_monitor:rate_change/mask="(Z,ZZZ.99999)"/column=110
  price_monitor:percent_changed /column=130
  price_monitor:trans_date /column=150
  price_monitor:trans_eff /column=165
  price_monitor:trans_exp /column=180
  price_monitor:eff_date /column=195
  price_monitor:month_written /column=205
  price_monitor:year_written/column=215

sorted by 
  price_monitor:month_written 
  line_of_business 
  policy_no

end of policy_no
 ""/newline

end of month_written 
 line_of_business 
 ""/newline

end of line_of_business
 ""/newline

end of report
if total[yr01_activity] <> 0 then {
   year_01/nocommas/noheading 
   total[yr01_exposure]/heading="Exposure"
   total[yr01_written_premium]/heading="Written Premium"
   l_rate_change1/heading="Rate Change"
   /newline }
if total[yr02_activity] <> 0 then {
   year_02/nocommas/noheading 
   total[yr02_exposure]/heading="Exposure"
   total[yr02_written_premium]/heading="Written Premium"
   l_rate_change2/heading="Rate Change"/newline }
if total[yr03_activity] <> 0 then {
   year_03/nocommas/noheading 
   total[yr03_exposure]/heading="Exposure"
   total[yr03_written_premium]/heading="Written Premium"
   l_rate_change3/heading="Rate Change"

   /newline }
if total[yr04_activity] <> 0 then {
   year_04/nocommas/noheading 
   total[yr04_exposure]/heading="Exposure"
   total[yr04_written_premium]/heading="Written Premium"
   l_rate_change4/heading="Rate Change"

   /newline }
if total[yr05_activity] <> 0 then {
   year_05/nocommas/noheading 
   total[yr05_exposure]/heading="Exposure"
   total[yr05_written_premium]/heading="Written Premium"
   l_rate_change5/heading="Rate Change"
   /newline }

if total[yr06_activity] <> 0 then {
   year_06/nocommas/noheading 
   total[yr06_exposure]/heading="Exposure"
   total[yr06_written_premium]/heading="Written Premium"
   l_rate_change7/heading="Rate Change"/newline }

if total[yr07_activity] <> 0 then {
   year_07/nocommas/noheading 
   total[yr07_exposure]/heading="Exposure"
   total[yr07_written_premium]/heading="Written Premium"
   l_rate_change7/heading="Rate Change"
   /newline }
if total[yr08_activity] <> 0 then {
   year_08/nocommas/noheading 
   total[yr08_exposure]/heading="Exposure"
   total[yr08_written_premium]/heading="Written Premium"
   l_rate_change8/heading="Rate Change"
   /newline }
if total[yr09_activity] <> 0 then {
   year_09/nocommas/noheading 
   total[yr09_exposure]/heading="Exposure"
   total[yr09_written_premium]/heading="Written Premium"
   l_rate_change9/heading="Rate Change"
   /newline }
if total[yr10_activity] <> 0 then {
   year_10/nocommas/noheading 
   total[yr10_exposure]/heading="Exposure"
   total[yr10_written_premium]/heading="Written Premium"
   l_rate_change10/heading="Rate Change"
   (l_rate_change10 - l_rate_change9) divide l_rate_change9 * 100/heading="Precent Change"/column= 130
   /newline }

if total[yr11_activity] <> 0 then {
   year_11/nocommas/noheading 
   total[yr11_exposure]/heading="Exposure"/column= 20
   total[yr11_written_premium]/heading="Written Premium"/column= 50
   l_rate_change11/heading="Rate Change"/column=90
   (l_rate_change11 - l_rate_change10) divide l_rate_change10 * 100/heading="Precent Change"/column= 130

   /newline }

if total[yr12_activity] <> 0 then {
   year_12/nocommas/noheading 
   total[yr12_exposure]/heading="Exposure"/column= 20
   total[yr12_written_premium]/heading="Written Premium"/column= 50
   l_rate_change12/heading="Rate Change"/column =90
   (l_rate_change12 - l_rate_change11) divide l_rate_change11 * 100/heading="Precent Change"/column= 130
   /newline }

if total[yr13_activity] <> 0 and year_13 <> year_12 then 
  {
    year_13/nocommas/noheading/column= 20 
    total[yr13_exposure]/heading="Exposure"/column= 50
    total[yr13_written_premium]/heading="Written Premium"/column= 90 
    l_rate_change13/heading="Rate Change"/column= 130
    /newline
  }
