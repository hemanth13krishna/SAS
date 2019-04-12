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
_NODE_  =                    1;
_LEAF_  =                    1;
P_TARGET_B1  =                 0.05;
P_TARGET_B0  =                 0.95;
Q_TARGET_B1  =     0.49989675820772;
Q_TARGET_B0  =     0.50010324179227;
V_TARGET_B1  =                 0.05;
V_TARGET_B0  =                 0.95;
I_TARGET_B  = '0' ;
U_TARGET_B  =                    0;
 
****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;
 
drop _LEAF_;
