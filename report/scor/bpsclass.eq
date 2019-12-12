viewpoint native;

define l_occupancy_code = switch(bpsclass:class_code)
case 2 :   2
case 30 :  2
case 80 : 47
case 22 : 47
case 64 :  6
case 167 : 6
case 26 :  6
case 51 :  8
case 70 :  8
case 41 : 5
case 54 : 5
case 58 : 5
case 62 : 5
case 25 : 5
case 37 : 5
case 5 : 5
case 77 : 5
case 9 : 5
case 34 : 5
case 19 : 5
case 2980 : 18
case 2981 : 18
case 5980 : 18
case 1980 : 18
case 4951 : 18
case 2985 : 18
case 4982 : 18
case 10 : 52
case 685 : 13
case 119 : 13
case 71 : 13
case 31 : 43
case 3 : 40
case 18 : 40
case 75 : 40
case 90 : 22
case 93 : 44
case 74 : 37
case 87 : 23
case 746 : 23
case 3980 : 23
case 106 : 39
case 310 : 39

where 
  bpsclass:class_code one of 2, 30, 80, 22, 64, 167, 26, 51, 70, 41, 54, 58,
        62, 25, 37, 5, 77, 9, 34, 19, 2980, 2981, 5980, 1980, 4951, 2985,
        4982, 10, 685, 119, 71, 31, 3, 18, 75, 90, 93, 74, 87, 746, 3980,
        106, 310


list/nobanner/domain="bpsclass"
  bpsclass:state 
  bpsclass:line_of_business 
  bpsclass:class_code 
  l_occupancy_code /heading="Occupany-Code"/nototal 
  bpsclass:iso_class_code 
  bpsclass:sic 
  bpsclass:description[1]

  sorted by bpsclass:state /newlines 
            bpsclass:line_of_business /newlines 
            bpsclass:class_code
