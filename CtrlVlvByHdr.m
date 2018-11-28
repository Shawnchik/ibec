function CtrlVlvByHdr
% control ByHdr valve  (MV1-01)
% Nomenclature
% Sp_GByHdr       :set point flow of ByHdr[m3/min]
% VlvByHdr        :opening of valve adjacent to ByHdr(0~1)
% GByHdr          :ByHdr flow[m3/min]

global Sp_GByHdr Sp_GAAC Sp_GPCH1 Vlv_ByHdr G_ByHdr G_ByHdr0 Sp_dP_Hdr Sp_dP_Hdr0 dP_Hdr dP_Hdr0
global Sp_GByHdr0 Sig_GByHdr Flg_PIDVlvByHdr Kp_VlvByHdr Ti_VlvByHdr Nm_RR

% set point dP_Hdr
if Nm_RR == 1
    Sp_dP_Hdr = 30;
else
    Sp_dP_Hdr = 0;
    Sp_dP_Hdr0 = 0;
end


% When heat load is 0, VlvByHdr is fully opened.
if Sp_dP_Hdr == 0
    Vlv_ByHdr = 0;

else
    % PI contorl VlvByHdr
%     Sp_dP_Hdr
%     Sp_dP_Hdr0
%     abs(dP_Hdr)
%     abs(dP_Hdr0)
%     Sig_GByHdr
%     Vlv_ByHdr
    [Vlv_ByHdr,Sp_dP_Hdr0,dP_Hdr0,Sig_GByHdr,Flg_PIDVlvByHdr] = ...
        PID(1.0,0.001,1,Kp_VlvByHdr,Ti_VlvByHdr,0,Sp_dP_Hdr,Sp_dP_Hdr0,dP_Hdr,dP_Hdr0,Sig_GByHdr,Vlv_ByHdr,-1,Flg_PIDVlvByHdr);

end