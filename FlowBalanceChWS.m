function FlowBalanceChWS
% calculate flow by flow balance

% Input     :VlvAAC,INV_PCH1,INV_CP2,INV_CP3,VlvCP3,
% Output    :
% Nomenclature
% Flg_Error1    :error flg for the convergence of this flow calance calculation
% GAAC          :AAC flow[m3/min]
% GPCH1          :PCH1 flow[m3/min]
% INV_CP2        :CP2 inverter(0~1)
% VlvAAC        :VlvAAC opening(0~1, 0:closed,1:opened)
% dP            :differential pressure[kPa]
% P             :pump total head[kPa]

global Flg_Error1
global Vlv_AAC dP_AAC 
global d0_PCH1 d1_PCH1 d2_PCH1
global G_PCH1 INV_PCH1 P_PCH1 Kr_PpRR Kr_RR
global G_AAC Kr_PpAAC Kr_AAC
global G_ByHdr Kr_PpByHdr Vlv_ByHdr
global Mv_G_AAC Mv_G_PCH1 Int_G_AAC Int_G_PCH1 dP_Hdr

Flg_Error1 = 0;

% Vlv_AAC = 0.8;
% % d2_PCH1 = -1543.4;
% % d1_PCH1 = 37.3212;
% % d0_PCH1 = 278.2225157;
% INV_PCH1 = 1;
% Kr_PpRR = 6100;
% Kr_RR = 7560;
% Kr_PpAAC = 500;
% Kr_AAC = 1000;
% Kr_PpByHdr = 2450;
% Vlv_ByHdr = 0;
% dP_Hdr = -30;

% [G_ByHdr] = Branch11(dP_Hdr,Kr_PpByHdr,0,Vlv_ByHdr,100,99)
% [~,G_PCH1,~,P_PCH1] = Branch10(dP_Hdr,INV_PCH1,0,1900,d2_PCH1,d1_PCH1,d0_PCH1,Kr_PpRR,Kr_RR,99)

if INV_PCH1 == 0
    G_AAC = 0;
    G_ByHdr = 0;
    G_PCH1 = 0;
    P_PCH1 = 0;
    dP_AAC = 0;
    dP_Hdr = 0;
else
    % initial value for convergence
    G_PCH1 = 0;
    G_ByHdr = 0;
    G_AAC = 0.05;
    G_AACmax = 0.2;
    G_AACmin = 0;
    cnt = 0;
    while (G_PCH1 - G_ByHdr - G_AAC > 0.00001) || (G_PCH1 - G_ByHdr - G_AAC < - 0.00001)
        
        % count for the case that cannot converge
        cnt = cnt + 1;
        
        % suppose G_AAC
        G_AAC = (G_AACmax + G_AACmin) / 2;
        
        % calculate dP_AAC from G_AAC, Vlv_AAC
        [dP_AAC] = Branch00(G_AAC,0,Kr_AAC,Vlv_AAC,100);
        
        % calculate dP_PpAAC
        [dP_PpAAC] = Branch00(G_AAC,Kr_PpAAC,0,1,100);
        
        dP_Hdr = dP_AAC + dP_PpAAC;
        
        % calculate G_ByHdr, G_CP from dPAAC, INVCP
        [G_ByHdr] = Branch11(dP_Hdr,Kr_PpByHdr,0,Vlv_ByHdr,50,99);
        [~,G_PCH1,~,P_PCH1] = Branch10(dP_Hdr,INV_PCH1,0,1900,d2_PCH1,d1_PCH1,d0_PCH1,Kr_PpRR,Kr_RR,99);
%         [~,G_PCH1,G_ByHdr,P_PCH1] = Branch10(dP_Hdr,INV_PCH1,Vlv_ByHdr,1900,d2_PCH1,d1_PCH1,d0_PCH1,Kr_PpRR,Kr_RR,Kr_PpByHdr);
               
        % revise GAAC
        if G_PCH1 - G_ByHdr - G_AAC > 0
            G_AACmin = G_AAC;
        elseif G_PCH1 - G_ByHdr - G_AAC < 0
            G_AACmax = G_AAC;
        end
        
        % escape from this roop
        if cnt > 30
            Flg_Error1 = G_PCH1 - G_ByHdr - G_AAC;
            break
        end
        
        
        
    end    
end

% Mesured value
Mv_G_AAC = G_AAC;
Mv_G_PCH1 = G_PCH1;

% dP_Hdr
% G_ByHdr
% dP_AAC
% dP_PpAAC
% P_PCH1
% Flg_Error1

Int_G_AAC = Int_G_AAC + Mv_G_AAC;
Int_G_PCH1 = Int_G_PCH1 + Mv_G_PCH1;

dP_AAC = abs(dP_AAC);

% differential pressure between headers
dP_Hdr = abs(dP_Hdr);

