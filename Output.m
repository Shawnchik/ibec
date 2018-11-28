function Output
% 値の出力
global CalStep Results
global G_Ld Mv_G_AAC Vlv_AAC  dP_AAC G_ByHdr Vlv_ByHdr
global INV_PCH1 Sp_GPCH1 Sp_ToutChRR
global Pw_PCH1 Pw_RR Int_Pw_PCH1 Int_Pw_RR
global Flg_Error1 Flg_Error2 Flg_Error3 
global Mv_G_PCH1 Mv_Tin_ChRR Mv_Tout_ChRR Mv_Tin_AAC Mv_Tout_AAC Int_G_AAC Int_G_PCH1
global dP_Hdr P_PCH1
global Results_Td_in_AAC Results_Td_out_AAC Td_in_AAC Td_out_AAC

i = floor(CalStep / 7200);

% 日時、運転モード
Results(CalStep - 7200 * i + 1,1) = CalStep;

%確認用
Results(CalStep - 7200 * i + 1,2) = G_Ld;
Results(CalStep - 7200 * i + 1,3) = Mv_G_AAC;

%以下、BEMSと同じ並び
Results(CalStep - 7200 * i + 1,4) = Mv_Tout_ChRR;
Results(CalStep - 7200 * i + 1,5) = Mv_Tin_ChRR;
Results(CalStep - 7200 * i + 1,6) = 0;
Results(CalStep - 7200 * i + 1,7) = 0;
Results(CalStep - 7200 * i + 1,8) = (Mv_Tin_ChRR - Mv_Tout_ChRR)*Mv_G_PCH1*4.184*60;
Results(CalStep - 7200 * i + 1,9) = INV_PCH1 * 50;
Results(CalStep - 7200 * i + 1,10) = 0;
Results(CalStep - 7200 * i + 1,11) = 0;
Results(CalStep - 7200 * i + 1,12) = 0;
Results(CalStep - 7200 * i + 1,13) = 0;
Results(CalStep - 7200 * i + 1,14) = 0;
Results(CalStep - 7200 * i + 1,15) = Mv_Tin_AAC;
Results(CalStep - 7200 * i + 1,16) = Mv_Tout_AAC;
Results(CalStep - 7200 * i + 1,17) = 0;
Results(CalStep - 7200 * i + 1,18) = 0;
Results(CalStep - 7200 * i + 1,19) = Mv_G_AAC;
Results(CalStep - 7200 * i + 1,20) = 0;
Results(CalStep - 7200 * i + 1,21) = 0;
Results(CalStep - 7200 * i + 1,22) = 0;
Results(CalStep - 7200 * i + 1,23) = 0;
Results(CalStep - 7200 * i + 1,24) = Int_Pw_PCH1;
Results(CalStep - 7200 * i + 1,25) = 0;
Results(CalStep - 7200 * i + 1,26) = Int_G_PCH1;
Results(CalStep - 7200 * i + 1,27) = Int_G_AAC;
Results(CalStep - 7200 * i + 1,28) = Int_Pw_RR;
Results(CalStep - 7200 * i + 1,29) = 0;
Results(CalStep - 7200 * i + 1,30) = 0;
Results(CalStep - 7200 * i + 1,31) = 0;
Results(CalStep - 7200 * i + 1,32) = 0;
Results(CalStep - 7200 * i + 1,33) = 0;
Results(CalStep - 7200 * i + 1,34) = Mv_G_PCH1;
Results(CalStep - 7200 * i + 1,35) = Pw_PCH1;
Results(CalStep - 7200 * i + 1,36) = 0;
Results(CalStep - 7200 * i + 1,37) = Pw_RR;

% BEMSにないデータ
Results(CalStep - 7200 * i + 1,38) = Vlv_AAC;
Results(CalStep - 7200 * i + 1,39) = dP_AAC;
Results(CalStep - 7200 * i + 1,40) = G_ByHdr;
Results(CalStep - 7200 * i + 1,41) = Vlv_ByHdr;
Results(CalStep - 7200 * i + 1,42) = 0;
Results(CalStep - 7200 * i + 1,43) = Sp_ToutChRR;

% Flg Error
Results(CalStep - 7200 * i + 1,44) = Flg_Error1;
Results(CalStep - 7200 * i + 1,45) = Flg_Error2;
Results(CalStep - 7200 * i + 1,46) = Flg_Error3;

Results(CalStep - 7200 * i + 1,47) = abs(dP_Hdr);
Results(CalStep - 7200 * i + 1,48) = P_PCH1;

Results_Td_in_AAC(CalStep - 7200 * i + 1,:) = Td_in_AAC;
Results_Td_out_AAC(CalStep - 7200 * i + 1,:) = Td_out_AAC;