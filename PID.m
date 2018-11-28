function[PX,S0,P0,SIG,Flg] = PID(PXmax,PXmin,TSTEP,Kc,TI,TD,S1,S0,P1,P0,SIG,PX,Kg,Flg)
% PID control
% Nomenclature
% PXmax,PXmin   :制御値の最大・最小範囲
% TSTEP         :計算ステップ
% Kc            :比例ゲイン
% TI            :積分時間
% TD            :微分時間
% S1            :現時刻の制御する要素の設定値 (温度や圧力)  S0:前時刻
% P1            :現時刻の制御する要素の値   P0:前時刻
% SIG           :積分総和
% PX            :現時刻の制御に使用する要素の値(回転率、バルブ開度など)
% CTRL          :制御に使用する要素の制御量
% Kg            :CTRLの量を制御する要素の設定値に落とし込むための係数。(-1か1)
% Flg           :設定値に不全がある、または不具合で制御が長時間おかしくなっていた場合にSIGをリセットする
% example; Kc=0.06,TSTEP=1,TI=20,TD=0

% 前時刻の制御量
PX0 = PX;

if S1 > 0.001   %設定値がない（流量がない）場合、出力をOとする
    
    CTRL = Kc * ((S1-P1) + 1 / TI * (SIG) * TSTEP + TD * ((S1 - P1) - (S0 - P0)) / TSTEP);

    PX = PX0 + CTRL * Kg;

    % 前時刻からの偏差は5%未満とする
    if PX > PX0 + 0.05
        PX = PX0 + 0.05;
    elseif PX < PX0 - 0.05
        PX = PX0 - 0.05;
    end
    
    % 制御量は上下限値をもつ
    if PX > PXmax
        PX = PXmax;
    elseif PX < PXmin
        PX = PXmin;
    end

else
    
    PX = 0.0;
    
end

SIG = SIG + S1 - P1;
S0 = S1;
P0 = P1;

% sekibunnjikannrisetto
time = 60;
for i = time:-1:2
        Flg(i) = Flg(i-1);
end
if S1 - P1 > 0
    Flg(1) = 1;
elseif S1 - P1 < 0
    Flg(1) = -1;
else
    Flg(1) = 0;
end
if Flg == 1
    SIG = 0;
    Flg = zeros(1,time);
end
if Flg == -1
    SIG = 0;
    Flg = zeros(1,time);
end


