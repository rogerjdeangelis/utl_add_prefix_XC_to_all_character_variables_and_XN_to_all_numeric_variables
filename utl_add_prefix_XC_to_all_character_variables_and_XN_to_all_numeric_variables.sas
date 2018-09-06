Add prefix XC to all character variables and XN to all numeric variables

github
https://tinyurl.com/y6wguwxn
https://github.com/rogerjdeangelis/utl_add_prefix_XC_to_all_character_variables_and_XN_to_all_numeric_variables

see SAS Forum
https://tinyurl.com/ybrh2ntu
https://communities.sas.com/t5/SAS-Procedures/SAS-macro-to-change-column-names/m-p/492885

SAS dictionary tables can easily take 10 minutes to query on EG severs.
Program below is very fast.

Varlist macro by Søren Lassen, s.lassen@post.tele.dk
Do_over macro by Authors: Ted Clay, M.S.
                   Clay Software & Statistics
                   tclay@ashlandhome.net
                 David Katz, M.S. www.davidkatzconsulting.com

INPUT
=====

WORK.CLASS total obs=19

 NAME       SEX    AGE    HEIGHT    WEIGHT

 Alfred      M      14     69.0      112.5
 Alice       F      13     56.5       84.0
 Barbara     F      13     65.3       98.0
 Carol       F      14     62.8      102.5
 Henry       M      14     63.5      102.5
....

EXAMPLE OUTPUT
--------------

The input and output datasets are the same we will modify the SAS header

WORK.CLASS total obs=19

 XC_NAME    XC_SEX    XN_AGE    XN_HEIGHT    XN_WEIGHT

 Alfred       M         14         69.0        112.5
 Alice        F         13         56.5         84.0
 Barbara      F         13         65.3         98.0
 Carol        F         14         62.8        102.5
 Henry        M         14         63.5        102.5
 James        M         12         57.3         83.0
....

PROCESS
=======

* all the code

%array(nums,values=%varlist(class,keep=_numeric_));
%array(chrs,values=%varlist(class,keep=_character_));

proc datasets library=work nolist;
modify class;
rename
     %do_over(nums,phrase=%str( ? = XN_? ))
     %do_over(chrs,phrase=%str( ? = XC_? ))
;run;quit;


OUTPUT
======

WORK.CLASS total obs=19

 XC_NAME    XC_SEX    XN_AGE    XN_HEIGHT    XN_WEIGHT

 Alfred       M         14         69.0        112.5
 Alice        F         13         56.5         84.0
 Barbara      F         13         65.3         98.0
 Carol        F         14         62.8        102.5
 Henry        M         14         63.5        102.5
 James        M         12         57.3         83.0
....

*                _              _       _
 _ __ ___   __ _| | _____    __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \  / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/ | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|  \__,_|\__,_|\__\__,_|

;

data class;
  set sashelp.class;
run;quit;

