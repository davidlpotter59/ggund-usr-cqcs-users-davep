viewpoint native;

where 
  cpsclass:class_code one of 2984, 2981, 19820, 983, 6982, 2980, 5980, 4981,
        1980, 1985, 3981, 3980, 39801, 1984, 1167


list/nobanner/domain="cpsclass"
  cpsclass:state 
  cpsclass:line_of_business 
  cpsclass:class_code 
  cpsclass:description[1]

  sorted by cpsclass:state /newlines 
            cpsclass:line_of_business 
            cpsclass:class_code
