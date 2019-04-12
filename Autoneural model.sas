***********************************;
*** Begin Scoring Code for Neural;
***********************************;
DROP _DM_BAD _EPS _NOCL_ _MAX_ _MAXP_ _SUM_ _NTRIALS;
 _DM_BAD = 0;
 _NOCL_ = .;
 _MAX_ = .;
 _MAXP_ = .;
 _SUM_ = .;
 _NTRIALS = .;
 _EPS =                1E-10;
LENGTH _WARN_ $4
;
      label S_DemMedHomeValue = 'Standard: DemMedHomeValue' ;

      label S_GiftTimeLast = 'Standard: GiftTimeLast' ;

      label S_LOG_GiftAvgAll = 'Standard: LOG_GiftAvgAll' ;

      label S_LOG_GiftCnt36 = 'Standard: LOG_GiftCnt36' ;

      label H1x1_1 = 'Hidden: H1x1_=1' ;

      label I_TARGET_B = 'Into: TARGET_B' ;

      label U_TARGET_B = 'Unnormalized Into: TARGET_B' ;

      label P_TARGET_B1 = 'Predicted: TARGET_B=1' ;

      label P_TARGET_B0 = 'Predicted: TARGET_B=0' ;

      label  _WARN_ = "Warnings";

*** *************************;
*** Checking missing input Interval
*** *************************;

IF NMISS(
   DemMedHomeValue ,
   GiftTimeLast ,
   LOG_GiftAvgAll ,
   LOG_GiftCnt36   ) THEN DO;
   SUBSTR(_WARN_, 1, 1) = 'M';

   _DM_BAD = 1;
END;
*** *************************;
*** Writing the Node interval ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   S_DemMedHomeValue  =    -1.11872953907802 +     0.00001000109306 *
        DemMedHomeValue ;
   S_GiftTimeLast  =    -4.47648364703294 +     0.24804762305443 *
        GiftTimeLast ;
   S_LOG_GiftAvgAll  =    -5.30486405789344 +     2.13626925922183 *
        LOG_GiftAvgAll ;
   S_LOG_GiftCnt36  =     -2.7052965605367 +     2.06332307899909 *
        LOG_GiftCnt36 ;
END;
ELSE DO;
   IF MISSING( DemMedHomeValue ) THEN S_DemMedHomeValue  = . ;
   ELSE S_DemMedHomeValue  =    -1.11872953907802 +     0.00001000109306 *
        DemMedHomeValue ;
   IF MISSING( GiftTimeLast ) THEN S_GiftTimeLast  = . ;
   ELSE S_GiftTimeLast  =    -4.47648364703294 +     0.24804762305443 *
        GiftTimeLast ;
   IF MISSING( LOG_GiftAvgAll ) THEN S_LOG_GiftAvgAll  = . ;
   ELSE S_LOG_GiftAvgAll  =    -5.30486405789344 +     2.13626925922183 *
        LOG_GiftAvgAll ;
   IF MISSING( LOG_GiftCnt36 ) THEN S_LOG_GiftCnt36  = . ;
   ELSE S_LOG_GiftCnt36  =     -2.7052965605367 +     2.06332307899909 *
        LOG_GiftCnt36 ;
END;
*** *************************;
*** Writing the Node H1x1_ ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H1x1_1  =     0.22969266386246 * S_DemMedHomeValue
          +    -0.11213754315567 * S_GiftTimeLast  +    -0.12589934008975 *
        S_LOG_GiftAvgAll  +     0.27976349442494 * S_LOG_GiftCnt36 ;
   H1x1_1  =    -0.13397816563962 + H1x1_1 ;
   H1x1_1  = TANH(H1x1_1 );
END;
ELSE DO;
   H1x1_1  = .;
END;
*** *************************;
*** Writing the Node TARGET_B ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_TARGET_B1  =     0.92600492840384 * H1x1_1 ;
   P_TARGET_B1  =     0.03922487034268 + P_TARGET_B1 ;
   P_TARGET_B0  = 0;
   _MAX_ = MAX (P_TARGET_B1 , P_TARGET_B0 );
   _SUM_ = 0.;
   P_TARGET_B1  = EXP(P_TARGET_B1  - _MAX_);
   _SUM_ = _SUM_ + P_TARGET_B1 ;
   P_TARGET_B0  = EXP(P_TARGET_B0  - _MAX_);
   _SUM_ = _SUM_ + P_TARGET_B0 ;
   P_TARGET_B1  = P_TARGET_B1  / _SUM_;
   P_TARGET_B0  = P_TARGET_B0  / _SUM_;
END;
ELSE DO;
   P_TARGET_B1  = .;
   P_TARGET_B0  = .;
END;
IF _DM_BAD EQ 1 THEN DO;
   P_TARGET_B1  =     0.49989675820772;
   P_TARGET_B0  =     0.50010324179227;
END;


*** Update Posterior Probabilities;
P_TARGET_B1 = P_TARGET_B1 * 0.05 / 0.49989675820772;
P_TARGET_B0 = P_TARGET_B0 * 0.95 / 0.50010324179227;
drop _sum; _sum = P_TARGET_B1 + P_TARGET_B0 ;
if _sum > 4.135903E-25 then do;
   P_TARGET_B1 = P_TARGET_B1 / _sum;
   P_TARGET_B0 = P_TARGET_B0 / _sum;
end;


*** End Decision Processing ;
*** *************************;
*** Writing the I_TARGET_B  AND U_TARGET_B ;
*** *************************;
_MAXP_ = P_TARGET_B1 ;
I_TARGET_B  = "1           " ;
U_TARGET_B  =                    1;
IF( _MAXP_ LT P_TARGET_B0  ) THEN DO;
   _MAXP_ = P_TARGET_B0 ;
   I_TARGET_B  = "0           " ;
   U_TARGET_B  =                    0;
END;
********************************;
*** End Scoring Code for Neural;
********************************;
drop
H1x1_1
;
drop S_:;
