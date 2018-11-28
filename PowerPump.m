function [PP,Nm,FlgError] = PowerPump(Gm,dPPmp,INV,b2,b1,b0,N)
% ポンプINV、流量、性能曲線からポンプ消費電力を計算する
% Nomenclature%%%%%
% PP        :ポンプ消費電力[kW]
% INV       :ポンプインバータ(0.0~1.0)
% Gm        :流量[m3/min]
% G         :定格流量[m3/min]
% Pm        :軸動力[kW]
% Nm        :効率(0.0~1.0)
% N         :定格での効率(0.0~100.0)
% nn        :入力INV時の最高効率
% K         :効率換算係数（K=Nm/N,Nは定格時の効率）
% a         :軸動力曲線に関する定数
% b         :効率曲線に関する定数
% H         :水頭[m]

% 効率は0~1の値とする!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

% 流量と全揚程がある場合のみ消費電力を計算する
if (Gm > 0)&&(dPPmp > 0)
    
    %INV=1.0時の流量を求める
    G = Gm / INV;
  
%     % 水頭を求める
%     H = dPPmp * 10 / 98;

%     定格時の最高効率を求めるここでは80%としている。!!!!本来は計算によって求める!!!!
%     N = 0.8;

%     nnを求める
    nn = 1.0 - (1.0 - N) / (INV^0.2);
%     効率換算係数Kを求める
    K = nn / N;
%     効率を求める
    Nm = K * (b0 + b1 * G + b2 * G^2);

    %     軸動力を求める http://www.jeca.or.jp/files/66.pdf 参照
    if Nm > 0
        PP = 1.0 * Gm * dPPmp / (60 * Nm);
    else
        PP = 0;
        Nm = 0;
    end
    
    %モーター入力ではない!!!!!!!!
    FlgError = 0;
    if PP < 0
        PP = 0;
        Nm = 0;
        FlgError = 1;
    end

else

    PP = 0.0;
    Nm = 0.0;
    FlgError = 0;

end