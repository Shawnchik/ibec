function PassTemperature
% Pass temperature in  next step
    % ~0        :former step

global Tin_AAC Tout_AAC
global Mv_Tin_AAC Mv_Tin_AAC0 Mv_Tout_AAC Mv_Tout_AAC0
global Tin_ChRR Tout_ChRR  
global Tin_AAC0 Tout_AAC0
global Tin_ChRR0 Tout_ChRR0 
global Mv_Tin_CnRR Mv_Tin_CnRR0 Mv_Tout_CnRR0  Mv_Tout_CnRR
global Td_in_AAC Td_out_AAC Td_in_AAC0 Td_out_AAC0
    
% AAC
Tin_AAC0 = Tin_AAC;
Tout_AAC0 = Tout_AAC;
Mv_Tin_AAC0 = Mv_Tin_AAC;  
Mv_Tout_AAC0 = Mv_Tout_AAC;
Td_in_AAC0 = Td_in_AAC;
Td_out_AAC0 = Td_out_AAC;

% TR
Tin_ChRR0 = Tin_ChRR;
Tout_ChRR0 = Tout_ChRR;
Mv_Tin_CnRR0 = Mv_Tin_CnRR;
Mv_Tout_CnRR0 = Mv_Tout_CnRR;