function CtrlPCH1
% Control primary water pump (PCH-1)

global Nm_RR G_Ld Sp_GPCH1 CalStep
global INV_PCH1 Sp_GPCH10 G_PCH10 Sig_INVPCH1 Flg_PIDINVPCH1 Kp_INVPCH1 Ti_INVPCH1
global Mv_G_PCH1

    if Nm_RR == 1
        INV_PCH1 = 1;
    else
        INV_PCH1 = 0;
    end
    
    
      
% else    
%     if Nm_RR == 1
%         Sp_GPCH1 = G_Ld;
%         if Sp_GPCH1 < 0.0258
%            Sp_GPCH1 = 0.0258;
%         end  
%     else
%         Sp_GPCH1 = 0;
%     end
% 
%     if Sp_GPCH1 == 0
%         INV_PCH1 = 0;
% 
%     else
%         [INV_PCH1,Sp_GPCH10,G_PCH10,Sig_INVPCH1,Flg_PIDINVPCH1] = ...
%             PID(1.0,0.001,1,Kp_INVPCH1,Ti_INVPCH1,0,Sp_GPCH1,Sp_GPCH10,Mv_G_PCH1,G_PCH10,Sig_INVPCH1,INV_PCH1,1,Flg_PIDINVPCH1);
%     end
% end