function [dP] = Branch00(G,KrPp,KrEq,Vlv,Cv_max)
% ポンプのない枝において、流量から圧力損失を求めるサブルーチン
% [圧力損失] = Branch0(流量,配管圧損係数,機器圧損係数,バルブ開度)
% Nomenclature
% G         :流量[m3/min]
% dP        :枝の出入口圧力差[kPa]  
% KrPp      :管の圧損係数[kPa/(m3/min)^2]
% KrEq      :機器の圧損係数[kPa/(m3/min)^2]
% Vlv       :バルブ開度(1:全開,0:全閉)
% Cv_max    :流量係数。弁のパラメータ。

% (枝の圧損) = (管圧損) + (熱交圧損) + (機器圧損) + (バルブ圧損)

% 弁圧損計算。流量係数の定格値Cv_maxはイオンの温度制御弁とレンジアビリティRはバタフライバルブの20
% Cv_max = 2846;

% R = 20;
% R = 50;
R = 900;
Cv = Cv_max * R^(Vlv - 1);
dPVlv = - 1743 * (G * 1000 / 60)^2 / Cv^2;

dP = - KrPp * G^2 - KrEq * G^2 + dPVlv;
