drop _temp_;
if (P_TARGET_B1 ge 0.62121212121212) then do;
b_TARGET_B = 1;
end;
else
if (P_TARGET_B1 ge 0.61254612546125) then do;
b_TARGET_B = 2;
end;
else
if (P_TARGET_B1 ge 0.58943089430894) then do;
_temp_ = dmran(1234);
b_TARGET_B = floor(3 + 2*_temp_);
end;
else
if (P_TARGET_B1 ge 0.52886115444617) then do;
_temp_ = dmran(1234);
b_TARGET_B = floor(5 + 3*_temp_);
end;
else
if (P_TARGET_B1 ge 0.47422680412371) then do;
b_TARGET_B = 8;
end;
else
if (P_TARGET_B1 ge 0.4587973273942) then do;
_temp_ = dmran(1234);
b_TARGET_B = floor(9 + 6*_temp_);
end;
else
if (P_TARGET_B1 ge 0.34296977660972) then do;
_temp_ = dmran(1234);
b_TARGET_B = floor(15 + 4*_temp_);
end;
else
do;
_temp_ = dmran(1234);
b_TARGET_B = floor(19 + 2*_temp_);
end;
