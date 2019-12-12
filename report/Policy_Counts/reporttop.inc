/*  reporttop.inc

    February 10, 2004

    SCIPS.com, Inc.

    top of page headings for standard printing
*/

top of page  
L_prog_number                    /heading="Report No      "/column=1/newline 
--enquiryname                                                                               /heading="Report No      "/left/column=1/newline
trun(sfscompany:name[1])                                                                  /heading="Company Name   "/left/column=1/newline  
trun(str(l_starting_date,"MM/DD/YYYY") + " - " + str(l_ending_date,"MM/DD/YYYY"))/column=1/heading="Report Period  "/left/newline
