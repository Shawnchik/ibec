function CtrlVlvAAC
% control AAC valve  (MV2-01)
% Nomenclature
% Sp_GAAC       :set point flow of AAC[m3/min]
% GLd           :heat load flow[m3/min]
% VlvAAC        :opening of valve adjacent to AAC(0~1)
% GAAC          :AAC flow[m3/min]

global Sp_GAAC G_Ld Vlv_AAC G_AAC G_AAC0
global Sp_GAAC0 Sig_GAAC Flg_PIDVlvAAC Kp_VlvAAC Ti_VlvAAC

% set point flow of AHU
Sp_GAAC = G_Ld;

% When heat load is 0, VlvAAC is fully opened.
if Sp_GAAC == 0
    Vlv_AAC = 0;
    
else
    % PI contorl VlvAAC
    [Vlv_AAC,Sp_GAAC0,G_AAC0,Sig_GAAC,Flg_PIDVlvAAC] = ...
        PID(1.0,0.0001,1,Kp_VlvAAC,Ti_VlvAAC,0,Sp_GAAC,Sp_GAAC0,G_AAC,G_AAC0,Sig_GAAC,Vlv_AAC,1,Flg_PIDVlvAAC);
    
end
