****************************************************************;
******             DECISION TREE SCORING CODE             ******;
****************************************************************;
 
******         LENGTHS OF NEW CHARACTER VARIABLES         ******;
LENGTH I_TARGET_B  $   12;
LENGTH _WARN_  $    4;
 
******              LABELS FOR NEW VARIABLES              ******;
LABEL _NODE_  = 'Node' ;
LABEL _LEAF_  = 'Leaf' ;
LABEL P_TARGET_B1  = 'Predicted: TARGET_B=1' ;
LABEL P_TARGET_B0  = 'Predicted: TARGET_B=0' ;
LABEL Q_TARGET_B1  = 'Unadjusted P: TARGET_B=1' ;
LABEL Q_TARGET_B0  = 'Unadjusted P: TARGET_B=0' ;
LABEL V_TARGET_B1  = 'Validated: TARGET_B=1' ;
LABEL V_TARGET_B0  = 'Validated: TARGET_B=0' ;
LABEL I_TARGET_B  = 'Into: TARGET_B' ;
LABEL U_TARGET_B  = 'Unnormalized Into: TARGET_B' ;
LABEL _WARN_  = 'Warnings' ;
 
 
******      TEMPORARY VARIABLES FOR FORMATTED VALUES      ******;
LENGTH _ARBFMT_12 $     12; DROP _ARBFMT_12;
_ARBFMT_12 = ' '; /* Initialize to avoid warning. */
 
 
******             ASSIGN OBSERVATION TO NODE             ******;
IF  NOT MISSING(GiftCnt36 ) AND
  GiftCnt36  <                  2.5 THEN DO;
  IF  NOT MISSING(DemMedHomeValue ) AND
    DemMedHomeValue  <                67350 THEN DO;
    _NODE_  =                    4;
    _LEAF_  =                    1;
    P_TARGET_B1  =     0.02955253117693;
    P_TARGET_B0  =     0.97044746882306;
    Q_TARGET_B1  =     0.36643026004728;
    Q_TARGET_B0  =     0.63356973995271;
    V_TARGET_B1  =     0.03376329643223;
    V_TARGET_B0  =     0.96623670356776;
    I_TARGET_B  = '0' ;
    U_TARGET_B  =                    0;
    END;
  ELSE DO;
    _NODE_  =                    5;
    _LEAF_  =                    2;
    P_TARGET_B1  =     0.04408965112583;
    P_TARGET_B0  =     0.95591034887416;
    Q_TARGET_B1  =     0.46694502435629;
    Q_TARGET_B0  =      0.5330549756437;
    V_TARGET_B1  =      0.0415740997401;
    V_TARGET_B0  =     0.95842590025989;
    I_TARGET_B  = '0' ;
    U_TARGET_B  =                    0;
    END;
  END;
ELSE DO;
  IF  NOT MISSING(GiftAvgLast ) AND
    GiftAvgLast  <                  7.5 THEN DO;
    _NODE_  =                    6;
    _LEAF_  =                    3;
    P_TARGET_B1  =     0.08690892100216;
    P_TARGET_B0  =     0.91309107899783;
    Q_TARGET_B1  =     0.64383561643835;
    Q_TARGET_B0  =     0.35616438356164;
    V_TARGET_B1  =      0.0927182654771;
    V_TARGET_B0  =      0.9072817345229;
    I_TARGET_B  = '0' ;
    U_TARGET_B  =                    0;
    END;
  ELSE DO;
    IF  NOT MISSING(GiftTimeLast ) AND
      GiftTimeLast  <                 17.5 THEN DO;
      _NODE_  =                   14;
      _LEAF_  =                    4;
      P_TARGET_B1  =      0.0700455672154;
      P_TARGET_B0  =     0.92995443278459;
      Q_TARGET_B1  =     0.58856502242152;
      Q_TARGET_B0  =     0.41143497757847;
      V_TARGET_B1  =     0.06574424791116;
      V_TARGET_B0  =     0.93425575208883;
      I_TARGET_B  = '0' ;
      U_TARGET_B  =                    0;
      END;
    ELSE DO;
      _NODE_  =                   15;
      _LEAF_  =                    5;
      P_TARGET_B1  =      0.0475411533285;
      P_TARGET_B0  =     0.95245884667149;
      Q_TARGET_B1  =     0.48664688427299;
      Q_TARGET_B0  =       0.513353115727;
      V_TARGET_B1  =     0.04675770668465;
      V_TARGET_B0  =     0.95324229331534;
      I_TARGET_B  = '0' ;
      U_TARGET_B  =                    0;
      END;
    END;
  END;
 
****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;
 
drop _LEAF_;
