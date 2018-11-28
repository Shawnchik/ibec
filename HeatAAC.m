function HeatAAC
% Nomenclature
% Tin_AAC        :AAC inlet temperature['C]
% Tout_AAC       :AAC outlet temperature['C]
% G_AAC          :AAC flow[m3/min]
% Q_Ld           :load heat[GJ/min]
global G_PCH1 G_AAC Tin_AAC Tin_AAC0 Tout_ChRR0 Tout_AAC Q_Ld Flg_Error2 Vlv_AAC 
global Mv_Tin_AAC Mv_Tout_AAC
global Td_in_AAC Td_out_AAC Td_in_AAC0 Td_out_AAC0 T_room

% Calculate Tout_AAC
if (G_PCH1 > 0)&&(G_AAC > 0)&&(Vlv_AAC > 0)
    Tin_AAC = Tout_ChRR0;
    Tout_AAC = Tin_AAC0 + Q_Ld * 10^9 / (4.184 * 10^3) / ((G_AAC) * 10^3);
    Td_in_AAC =  repmat(Tin_AAC,1,31);
    Td_out_AAC = repmat(Tout_AAC,1,31);
    
elseif Vlv_AAC == 0   
    [Td_in_AAC,Tin_AAC] = PipeTemperatureDistribution(Td_in_AAC0,T_room,0.060,0.004,0.002,60,1.251e-5,45);
    [Td_out_AAC,Tout_AAC] = PipeTemperatureDistribution(Td_out_AAC0,T_room,0.060,0.004,0.002,60,1.251e-5,45);

end

% flag
Flg_Error2 = 0;
if Tout_AAC >= 25
    Tout_AAC = 25;
    Flg_Error2 = 1;
end

Mv_Tin_AAC = Tin_AAC;
Mv_Tout_AAC = Tout_AAC;