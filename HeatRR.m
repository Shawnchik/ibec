function HeatRR

global G_AAC Tout_ChRR0 G_ByHdr T_air
global G_PCH1 Tin_ChRR Tout_AAC0 
global Tout_ChRR COP_RR Pw_RR Tin_ChRR0 Sp_ToutChRR RR_co Sp_ToutHdr
global Mv_Tin_ChRR Mv_Tout_ChRR

% RR inlet temperature
if (G_PCH1 > 0)&&(G_ByHdr + G_AAC > 0)
    T_ByHdr = Tout_ChRR0;
    Tin_ChRR = (T_ByHdr * G_ByHdr + Tout_AAC0 * G_AAC) / (G_ByHdr + G_AAC);
end

% RR outlet temperature and RR calculation
Sp_ToutChRR = Sp_ToutHdr;
[Tout_ChRR,COP_RR,Pw_RR] = CalRR(Tin_ChRR0,Sp_ToutChRR,G_PCH1,T_air,RR_co);

% Mesured value
Mv_Tin_ChRR = Tin_ChRR;
Mv_Tout_ChRR = Tout_ChRR;
