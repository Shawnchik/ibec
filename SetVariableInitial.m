function SetVariableInitial
% initial value and setting
% result
global Results Results_Td_in_AAC Results_Td_out_AAC
Results = zeros(7200,46);
Results_Td_in_AAC = zeros(7200,31);
Results_Td_out_AAC = zeros(7200,31);
% time
global year month hour day minute
year = 2012;
month = 12;
day = 24;
hour = 0;
minute = 0;

% AAC
global dP_AAC G_AAC G_AAC0 Sp_GAAC0 Tin_AAC Tout_AAC Tin_AAC0 Tout_AAC0 Vlv_AAC
global Mv_G_AAC Mv_Tin_AAC Mv_Tin_AAC0 Mv_Tout_AAC Mv_Tout_AAC0 Td_in_AAC0 Td_out_AAC0
G_AAC = 0;
G_AAC0 = 0;
Sp_GAAC0 = 0;
dP_AAC = 100;
Vlv_AAC = 0.5;
Tin_AAC = 12;
Tout_AAC = 12;
Tin_AAC0 = 12;
Tout_AAC0 = 12;
Mv_G_AAC = 0;
Mv_Tin_AAC = 0;
Mv_Tout_AAC = 0;
Mv_Tin_AAC0 = 0;  
Mv_Tout_AAC0 = 0;
Td_in_AAC0 = repmat(12,1,31);
Td_out_AAC0 = repmat(12,1,31);

% RR
global INV_PCH1 G_PCH1 G_PCH10 Sp_GPCh10 Tin_ChRR Tout_ChRR Tin_ChRR0 Tout_ChRR0
global Mv_G_PCH1 Mv_Tin_ChRR Mv_Tout_ChRR Mv_Tin_CnRR0 Mv_Tout_CnRR0
global Nm_RR Int_Pw_PCH1 Int_Pw_RR Int_G_AAC Int_G_PCH1
INV_PCH1 = 0.3; 
G_PCH1 = 0;
G_PCH10 = 0;
Sp_GPCh10 = 0;
Tin_ChRR = 7;
Tout_ChRR = 7;
Tin_ChRR0 = 7;
Tout_ChRR0 = 7;
Mv_G_PCH1 = 0;
Mv_Tin_ChRR = 7;
Mv_Tout_ChRR = 7;
Mv_Tin_CnRR0 = 7;
Mv_Tout_CnRR0 = 7;
Nm_RR = 1;
Int_Pw_PCH1 = 8415;
Int_Pw_RR = 25408;
Int_G_AAC = 6615;
Int_G_PCH1 = 62158;

% Bypass of header
global Vlv_ByHdr G_ByHdr G_ByHdr0 Sp_GByHdr0 dP_Hdr dP_Hdr0
Vlv_ByHdr = 0.5;
G_ByHdr = 0;
G_ByHdr0 = 0;
Sp_GByHdr0 = 0;
dP_Hdr = 0;
dP_Hdr0 = 0;

global Flg_Error1 Flg_Error2 Flg_Error3
Flg_Error1 = 0;
Flg_Error2 = 0;
Flg_Error3 = 0;
