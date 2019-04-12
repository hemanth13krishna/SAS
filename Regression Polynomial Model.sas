*************************************;
*** begin scoring code for regression;
*************************************;

length _WARN_ $4;
label _WARN_ = 'Warnings' ;

length I_TARGET_B $ 12;
label I_TARGET_B = 'Into: TARGET_B' ;
*** Target Values;
array REG2DRF [2] $12 _temporary_ ('1' '0' );
label U_TARGET_B = 'Unnormalized Into: TARGET_B' ;
*** Unnormalized target values;
ARRAY REG2DRU[2]  _TEMPORARY_ (1 0);

drop _DM_BAD;
_DM_BAD=0;

*** Check DemMedHomeValue for missing values ;
if missing( DemMedHomeValue ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check GiftTimeLast for missing values ;
if missing( GiftTimeLast ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check DemPctVeterans for missing values ;
if missing( DemPctVeterans ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check LOG_GiftAvgLast for missing values ;
if missing( LOG_GiftAvgLast ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check LOG_GiftCnt36 for missing values ;
if missing( LOG_GiftCnt36 ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check LOG_GiftCntCardAll for missing values ;
if missing( LOG_GiftCntCardAll ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
*** If missing inputs, use averages;
if _DM_BAD > 0 then do;
   _P0 = 0.4998967582;
   _P1 = 0.5001032418;
   goto REG2DR1;
end;

*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;

***  Effect: DemMedHomeValue*DemPctVeterans ;
_TEMP = DemMedHomeValue  * DemPctVeterans ;
_LP0 = _LP0 + (  4.5024159372987E-8 * _TEMP);

***  Effect: GiftTimeLast*LOG_GiftAvgLast ;
_TEMP = GiftTimeLast  * LOG_GiftAvgLast ;
_LP0 = _LP0 + (   -0.01248742217825 * _TEMP);

***  Effect: LOG_GiftCnt36*LOG_GiftCntCardAll ;
_TEMP = LOG_GiftCnt36  * LOG_GiftCntCardAll ;
_LP0 = _LP0 + (    0.14198966968051 * _TEMP);

*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =     0.13332173893529 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;

REG2DR1:



*** Update Posterior Probabilities;
_P0 = _P0 * 0.05 / 0.49989675820772;
_P1 = _P1 * 0.95 / 0.50010324179227;
drop _sum; _sum = _P0 + _P1 ;
if _sum > 4.135903E-25 then do;
   _P0 = _P0 / _sum;
   _P1 = _P1 / _sum;
end;


*** End Decision Processing ;

*** Posterior Probabilities and Predicted Level;
label P_TARGET_B1 = 'Predicted: TARGET_B=1' ;
label P_TARGET_B0 = 'Predicted: TARGET_B=0' ;
P_TARGET_B1 = _P0;
_MAXP = _P0;
_IY = 1;
P_TARGET_B0 = _P1;
if (_P1 >  _MAXP + 1E-8) then do;
   _MAXP = _P1;
   _IY = 2;
end;
I_TARGET_B = REG2DRF[_IY];
U_TARGET_B = REG2DRU[_IY];

*************************************;
***** end scoring code for regression;
*************************************;
