function[G,G_Pmp,G_Vlv,P_Pmp] = Branch10(dP,INV,Vlv,Cv_max,d2,d1,d0,Kr_PpTR,Kr_TR,Kr_PpVlv)
% ポンプを一つ有する枝において、出入口圧力差とポンプINVから流量を求める計算
% [総流量,ポンプ流量,バイパス弁流量,ポンプ全揚程] =
% Branch10(圧力差,ポンプINV,バイパス弁開度,流量係数,ポンプ係数0次,ポンプ係数1次,ポンプ係数2次,配管抵抗係数,冷凍機抵抗係数)
% 圧力は、圧力損失が負、ポンプによる加圧が正とする。
% 流量は、ポンプの向きを正とする。
% Nomenclature %%%%%
% dP            :枝の出入口圧力差[kPa]
% maxG,minG     :流量の最大値、最小値(0.0)[m3/min]
% INV           :ポンプINV(0~1)
% Vlv         :バイパス弁(1:全開,0:全閉)
% d0~d2         :ポンプ性能曲線の係数
% Kr_Pp          :配管圧損係数[kPa/(m3/min)^2]
% Kr_TR          :冷凍機圧損係数[kPa/(m3/min)^2]
% G             :総流量[m3/min]
% G_Pmp           :冷凍機流量[m3/min]
% G_Vlv        :バイパス弁流量[m3/min]
% P_Pmp         :ポンプによる圧力[kPa]
% dP_Pp          :配管による圧力損失[kPa]
% dPVlv         :配管用二方弁による圧力損失[kPa]
% dP_Vlv       :冷凍機バイパス弁による圧力損失[kPa]

% INVが0かつバイパス弁が閉じている時
if (INV == 0)&&(Vlv == 0)
    G_Pmp = 0;
    G_Vlv = 0;
    G = 0;
    P_Pmp = 0;
% INVは0だがバイパス弁は開いている時
elseif INV == 0
    G_Pmp = 0;
    P_Pmp = 0;
    
    if dP <= 0
        G_Vlv = 0;
        G = 0;
    else
        dP_Vlv = -2000;
        dP_PpVlv = 0;
        Gmax = 20;
        Gmin = 0;
        cnt = 0;
        G_Vlv = 0;
        G = 0;
        while (dP_Vlv + dP_PpVlv + dP > 0.0001)||(dP_Vlv + dP_PpVlv + dP < - 0.0001)
            cnt = cnt + 1;
            G = (Gmin + Gmax) / 2;
            G_Vlv = G;
            R = 100;
            Cv = Cv_max * R^(Vlv - 1);
            dP_Vlv = - 1743 * (G * 1000 / 60)^2 / Cv^2;
            dP_PpVlv = - Kr_PpVlv * G^2;
            if dP_Vlv + dP_PpVlv + dP > 0
                Gmin = G;
            else
                Gmax = G;
            end
            if cnt > 25
                break
            end
        end
    end
    

% バイパス弁は閉じているがINVが0より大きい時
elseif Vlv == 0
    
    G_Vlv = 0;
    
    % whileに入るための初期値,二分法初期値
    P_Pmp = 1000;
    dP_TR = 0;
    dP_Pp = 0;
    Gmax = 0.5;
    Gmin = 0;
    cnt = 0;
    G_Pmp = 0;
    G = 0;
    while (P_Pmp + dP_TR + dP_Pp + dP > 0.0001)||(P_Pmp + dP_TR + dP_Pp + dP < - 0.0001)
        cnt = cnt + 1;
        G = (Gmin + Gmax) / 2;
        G_Pmp = G;
        P_Pmp = (d0 + d1 *  (G_Pmp / INV) + d2 *  (G_Pmp / INV)^2) * INV^2;
        dP_TR = - Kr_TR * G_Pmp^2;
        dP_Pp = - Kr_PpTR * G_Pmp^2;
        if P_Pmp + dP_TR + dP_Pp + dP > 0
            Gmin = G;
        else
            Gmax = G;
        end
        
        if cnt > 25
            break
        end
    
    end
    

% INVが0より大きく、バイパス弁も開いている時
else 
    % whileに入るための初期値,二分法初期値
    P_Pmp = 1000;
    dP_TR = 0;
    dP_Pp = 0;
    Gmax = 0.129;
    Gmin = 0;
    G_Pmp = 0;
    cnt = 0;
    G = 0;
    G_Vlv = 0;
    while (P_Pmp + dP_TR + dP_Pp + dP > 0.0001)||(P_Pmp + dP_TR + dP_Pp + dP < - 0.0001)
        cnt = cnt + 1;
        G = (Gmin + Gmax) / 2;
        [P_Pmp,dP_TR,G_Pmp,G_Vlv] = Branch01(G,1,INV,Vlv,Cv_max,d2,d1,d0,Kr_TR,Kr_PpVlv);
        dP_Pp = - Kr_PpTR * G^2;
        if P_Pmp + dP_TR + dP_Pp + dP > 0
            Gmin = G;
        else
            Gmax = G;
        end
        
        if cnt > 25
            break
        end
    
    end
end