function[P_Pmp,dP_PpPmp,G_Pmp,G_VlvPmp] = Branch01(G,Nm_Pmp,INV,Vlv_Pmp,Cv_max,d2,d1,d0,Kr_PpPmp,Kr_PpVlvPmp)
% ポンプを複数並列に有する枝において、出口流量、ポンプINV・バイパス弁開度から圧力、各流量を計算する。
% 圧力は、圧力損失が負、ポンプによる加圧が正とする。
% 流量は、ポンプの向きを正とする。
% Nomenclature %%%%%
% dP            :枝の出入口圧力差[kPa]
% dPHEX        :熱交換器前後の圧力差(=熱交換器バイパス弁前後の圧力差)[kPa]
% dPPmp        :二次ポンプ前後の圧力差(=二次ポンプバイパス弁前後の圧力差)[kPa]
% dPPp          :配管圧力損失
% dPVlvHEX      :熱交換器バイパス弁圧力損失
% dPVlvPmp      :ポンプバイパス弁圧力損失
% maxG,minG     :流量の最大値、最小値(0.0)[m3/min]
% Nm_Pmp           :ポンプ運転台数
% INV           :INVの回転数(0~1)
% c0~c4         :ポンプ性能曲線の係数
% c0n           :そのINV時の最大圧力（性能曲線の圧力切片）
% KrHEX         :熱交換器圧損係数[kPa/(m3/min)^2]
% KrPp          :配管圧損係数[kPa/(m3/min)^2]
% G             :総流量[m3/min]
% GPmp          :ポンプ一台あたりの流量[m3/min]
% GHEX          :熱交換器流量[m3/min],一台あたりの流量。
% Ph            :ポンプによる圧力[kPa]
% Phn           :定格（INV=0)時換算の圧力
% VlvPmp        :ポンプバイパス弁開度(0~1,0が全閉)[-]
% VlvHEX        :熱交換器バイパス弁開度(0~1)[-]
% global d0_CP3 d1_CP3 d2_CP3
% d0 = d0_CP3;
% d1 = d1_CP3;
% d2 = d2_CP3;
% 
% G = 0.6;
% Nm_Pmp = 1;
% INV = 0.5;
% Vlv_Pmp  = 0.1;
% Cv_max = 2000;
% Kr_PpPmp = 1;
% Kr_PpVlvPmp = 1;

if (G == 0)||(INV == 0)&&(Vlv_Pmp == 0)
    P_Pmp = 0;
    dP_PpPmp = 0;
    G_Pmp = 0;
    G_VlvPmp = 0;
% dPが0kPa以上あるとき(圧力損失が負になっていないとき、つまりdPが正になっていないとき)
else
    % バイパス弁が閉じている時
    if Vlv_Pmp == 0
        G_Pmp = G / Nm_Pmp;
        P_Pmp = (d0 + d1 *  (G_Pmp / INV) + d2 *  (G_Pmp / INV)^2) * INV^2;
        dP_PpPmp = - Kr_PpPmp * G_Pmp^2;
        G_VlvPmp = 0;
    else
        G_VlvPmpmax = 0.129;
        G_VlvPmpmin = 0;
        dP_VlvPmp = 10;
        dP_PpVlvPmp = 0;
        P_Pmp = 0;
        dP_PpPmp = 0;
        cnt = 0;
        while (dP_VlvPmp + dP_PpVlvPmp + P_Pmp + dP_PpPmp > 0.001)||(dP_VlvPmp + dP_PpVlvPmp + P_Pmp + dP_PpPmp < -0.001)
            
            cnt = cnt + 1;
            
            G_VlvPmp = (G_VlvPmpmax + G_VlvPmpmin) / 2;

            R = 100;
            Cv = Cv_max * R^(Vlv_Pmp - 1);
            dP_VlvPmp = - 1743 * (G_VlvPmp * 1000 / 60)^2 / Cv^2;
            dP_PpVlvPmp = - Kr_PpVlvPmp * G_VlvPmp^2;

            G_Pmp = (G + G_VlvPmp) / Nm_Pmp;
            P_Pmp = (d0 + d1 *  (G_Pmp / INV) + d2 *  (G_Pmp / INV)^2) * INV^2;
            dP_PpPmp = - Kr_PpPmp * G_Pmp^2;

            if dP_VlvPmp + dP_PpVlvPmp + P_Pmp + dP_PpPmp > 0
                G_VlvPmpmin = G_VlvPmp;
            else
                G_VlvPmpmax = G_VlvPmp;
            end

            if cnt > 25
                break
            end
            
        end
        
    end
end
