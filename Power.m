function Power
% 消費電力の計算
% Nomenclature%%%%%
% Pw_PCH1     :PCH1消費電力[kW]
% n_PCH1      :PCH1効率(0~1)
% G_PCH1      :PCH1一台当たり流量[m3/min]
% P_PCH1      :PCH1吐出圧[kPa]
% INV_PCH1    :PCH1INV_(0~1)

global Pw_PCH1 n_PCH1 G_PCH1 P_PCH1 INV_PCH1 c0_PCH1 c1_PCH1 c2_PCH1
global Flg_Error3
global Int_Pw_PCH1 Int_Pw_RR Pw_RR

% pumps
[Pw_PCH1,n_PCH1,Flg_Error3] = PowerPump(G_PCH1,P_PCH1,INV_PCH1,c2_PCH1,c1_PCH1,c0_PCH1,0.501);
% Power integration
Int_Pw_PCH1 = Int_Pw_PCH1 + Pw_PCH1/60;
Int_Pw_RR = Int_Pw_RR + Pw_RR/60;