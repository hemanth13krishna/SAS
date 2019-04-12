   
* ;
* Defining New Variables;
* ;
Length REP_StatusCat96NK $5;
Label REP_StatusCat96NK='Replacement: Status Category 96NK';
REP_StatusCat96NK= StatusCat96NK;
   
* ;
* Replace Specific Class Levels ;
* ;
length _UFormat200 $200;
drop   _UFORMAT200;
_UFORMAT200 = " ";
* ;
* Variable: StatusCat96NK;
* ;
_UFORMAT200 = strip(StatusCat96NK);
if _UFORMAT200 =  "A" then
REP_StatusCat96NK="A";
else
if _UFORMAT200 =  "S" then
REP_StatusCat96NK="A";
else
if _UFORMAT200 =  "F" then
REP_StatusCat96NK="N";
else
if _UFORMAT200 =  "N" then
REP_StatusCat96NK="N";
else
if _UFORMAT200 =  "E" then
REP_StatusCat96NK="L";
else
if _UFORMAT200 =  "L" then
REP_StatusCat96NK="L";
