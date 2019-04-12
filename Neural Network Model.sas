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

      label H11 = 'Hidden: H1=1' ;

      label H12 = 'Hidden: H1=2' ;

      label H13 = 'Hidden: H1=3' ;

      label H14 = 'Hidden: H1=4' ;

      label H15 = 'Hidden: H1=5' ;

      label H16 = 'Hidden: H1=6' ;

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
*** Writing the Node intvl ;
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
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     0.08455977187015 * S_DemMedHomeValue  +     0.22011154397563 *
        S_GiftTimeLast  +    -0.08990770710579 * S_LOG_GiftAvgAll
          +    -0.20197104240615 * S_LOG_GiftCnt36 ;
   H12  =     1.21514987598849 * S_DemMedHomeValue  +    -0.05205222194029 *
        S_GiftTimeLast  +    -0.42574139322592 * S_LOG_GiftAvgAll
          +     0.43133233864076 * S_LOG_GiftCnt36 ;
   H13  =     0.35140690592001 * S_DemMedHomeValue  +      0.1113548866849 *
        S_GiftTimeLast  +    -0.45030963536787 * S_LOG_GiftAvgAll
          +     0.57408526144677 * S_LOG_GiftCnt36 ;
   H14  =    -0.31718348919217 * S_DemMedHomeValue  +      0.4267522827528 *
        S_GiftTimeLast  +     0.04367149642123 * S_LOG_GiftAvgAll
          +     1.02482965104002 * S_LOG_GiftCnt36 ;
   H15  =     0.04023836738548 * S_DemMedHomeValue  +      0.3194097087729 *
        S_GiftTimeLast  +     0.30597961146295 * S_LOG_GiftAvgAll
          +     0.10357986458761 * S_LOG_GiftCnt36 ;
   H16  =     0.35692806801958 * S_DemMedHomeValue  +     0.17658664507665 *
        S_GiftTimeLast  +    -0.30331126952116 * S_LOG_GiftAvgAll
          +     0.46662632730375 * S_LOG_GiftCnt36 ;
   H11  =     1.42281781577252 + H11 ;
   H12  =     1.65744408123072 + H12 ;
   H13  =    -0.93856448596235 + H13 ;
   H14  =    -1.59126761927973 + H14 ;
   H15  =    -1.37382013168029 + H15 ;
   H16  =    -1.27435199448799 + H16 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
   H15  = TANH(H15 );
   H16  = TANH(H16 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
   H15  = .;
   H16  = .;
END;
*** *************************;
*** Writing the Node TARGET_B ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_TARGET_B1  =    -1.86967505493108 * H11  +     0.56152746859671 * H12
          +     1.09204258570427 * H13  +    -0.58996295950809 * H14
          +     0.26332942231113 * H15  +    -0.63045550276638 * H16 ;
   P_TARGET_B1  =     1.12447715862222 + P_TARGET_B1 ;
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
H11
H12
H13
H14
H15
H16
;
drop S_:;
