define unsigned ascii number l_building_limit = aggregate_limit_loc:building_limit/total
define unsigned ascii number l_contents_limit = aggregate_limit_loc:contents_limit/total
define unsigned ascii number l_ale_bi_limit = aggregate_limit_loc:ale_bi_limit/total
  
define file sfppointa = access sfppoint, 
                           set sfppoint:policy_no= aggregate_limit_loc:policy_no, 
                               sfppoint:pol_year = aggregate_limit_loc:pol_year 
    
--where aggregate_limit_loc:policy_no one of 2094, 2104, 2285, 2481, 6618, 6717, 23041                                                                             
--where aggregate_limit_loc:eff_date => 01.25.2016

list
/nobanner
/domain="aggregate_limit_loc" 
/nodetail
 
company_id
policy_no
prem_no
build_no /column=40
address/column= 50
city /column=110
str_state /column= 135
zip_code  /column= 145
construction_code/column= 155/heading="const"
class_code/column= 170/heading="class"
class_code_description/column= 180
year_of_construction /column= 250
building_limit /column= 275
building_deductable /column= 290
contents_limit /column= 305
contents_deductable /column= 320
ale_bi_limit /column= 335
ale_bi_deductible /column= 350
property_premium /column= 365
trans_date/column= 380
trans_eff /column= 395
trans_code /column= 410
line_of_business /column= 425
agent_no /column= 440
county  /column= 455
valueable_papers_limit /column= 485
water_damage_limit /column= 500
employee_dishonesty /column= 515
computer_coverage /column= 530
outdoor_signs/column= 545
spoilage_coverage/column= 560
cppisocrime_total /column= 575
square_footage /column= 590
eff_date/column= 605
hurricane_deductible/column= 620
inland_marine_limit /column= 635
no_of_stories /column= 650
distance_to_shore/column= 665
if exclude_wind = "X" then
  "YES"
else
  "NO"/heading="Exclude Wind"/column= 680
if blanket = 1 then
  "Yes"
else
  "No"/heading="Blanket"/column= 695
pol_year/column= 710
end_sequence /column= 720
sprinklered/heading="Sprinkler" /column=770
protection/heading="Protection"/column=790

sorted by policy_no prem_no build_no 

end of build_no 

box 
/noheadings 
/noblanklines 

company_id
policy_no 
prem_no 
build_no /column=40
address/column= 50
city /column=110
str_state /column= 135
zip_code[1,5]/column= 145
construction_code/column= 155
if aggregate_limit_loc:class_code = 0 then
  0
else
  class_code/column= 170
class_code_description/column= 180
year_of_construction /column= 250
l_building_limit /column= 275
building_deductable /column= 290
l_contents_limit/column= 305
contents_deductable /column= 320
l_ale_bi_limit/column= 335
ale_bi_deductible /column= 350
property_premium /column= 365
trans_date/column= 380
trans_eff /column= 395
trans_code /column= 410
line_of_business /column= 425
agent_no /column= 440
county  /column= 455
valueable_papers_limit /column= 485
water_damage_limit /column= 500
employee_dishonesty /column= 515
computer_coverage /column= 530
outdoor_signs/column= 545
spoilage_coverage/column= 560
cppisocrime_total /column= 575
square_footage /column= 590
eff_date/column= 605
hurricane_deductible/column= 620
inland_marine_limit /column= 635
no_of_stories /column= 650
distance_to_shore/column= 665
if exclude_wind = "X" then
  "Yes"
else
  "No"/noheading/column= 680

if blanket = 1 then
  "Yes"
else
  "No"/column= 695
xob
pol_year/noheading/column= 710
end_sequence/noheading /column= 720
if aggregate_limit_loc:sprinklered one of "Y","1" then "Yes" else "No"/noheading /column=770
aggregate_limit_loc:protection /noheading /column=790
