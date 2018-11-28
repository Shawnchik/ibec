function Flow
% Control pumps and valves and calculate flow rate in chilled water system


% Control heat pump (RR-1)
CtrlRR

% Control primary water pump (PCH-1) 
CtrlPCH1

% Control ByHdr valve (MV1-01) 
CtrlVlvByHdr

% Control AAC valve (MV2-01) 
CtrlVlvAAC

% Calculate flow by flow balance
FlowBalanceChWS
