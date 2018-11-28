function SetParameters
% PI control
global Kp_INVPCH1 Ti_INVPCH1 Kp_VlvByHdr Ti_VlvByHdr Kp_VlvAAC Ti_VlvAAC
parameters = dlmread('Input/Parameters_KpTi.csv',',',1,1);
Kp_INVPCH1 = parameters(1,1);
Ti_INVPCH1 = parameters(1,2);
Kp_VlvAAC = parameters(2,1);
Ti_VlvAAC = parameters(2,2);
Kp_VlvByHdr = parameters(3,1);
Ti_VlvByHdr = parameters(3,2);

% parameters for PI controls
% integral reset time
time = 60;
% INV_PCH1
global Sig_INVPCH1 Flg_PIDINVPCH1
Sig_INVPCH1 = 0;
Flg_PIDINVPCH1 = zeros(1,time);
% Vlv_AAC
global Sig_GAAC Flg_PIDVlvAAC
Sig_GAAC = 0;
Flg_PIDVlvAAC = zeros(1,time);
% VlvByHdr
global Sig_GByHdr Flg_PIDVlvByHdr
Sig_GByHdr = 0;
Flg_PIDVlvByHdr = zeros(1,time);

% Coefficient for pressure loss
global Kr_AAC Kr_PpAAC
global Kr_RR Kr_PpRR
global Kr_PpByHdr

% read file
parameters = dlmread('Input/Parameters_Kr.csv',',',1,1);
Kr_AAC = parameters(1,1);
Kr_PpAAC = parameters(2,1);
Kr_RR = parameters(3,1);
Kr_PpRR = parameters(4,1);
Kr_PpByHdr = parameters(5,1);

% Coefficient for RR COP curve
global RR_co
RR_co = dlmread('Input/Parameters_RR_co.csv',',',1,1);

% Coefficient for pump curve
global Pump_co
global d0_PCH1 d1_PCH1 d2_PCH1 
Pump_co = dlmread('Input/Parameters_Pump_co.csv',',',1,1);
d2_PCH1 = Pump_co(1,1);
d1_PCH1 = Pump_co(1,2);
d0_PCH1 = Pump_co(1,3);

global c0_PCH1 c1_PCH1 c2_PCH1
c2_PCH1 = Pump_co(2,1);
c1_PCH1 = Pump_co(2,2);
c0_PCH1 = Pump_co(2,3);
