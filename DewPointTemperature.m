function [Tdp] = DewPointTemperature(Tda,rh)
% 乾球温度Tdaと相対湿度rhから露点温度Tdpを求める
% Tda   :Temperature of dry air ['C]
% rh    :relative humidity [%]
% cpd   :乾き空気の定圧比熱 [J / kg(DA)'C]
% gamma :飽和水蒸気の蒸発潜熱 [J/kg]
% cpv   :水蒸気の定圧比熱 [J / kg(DA)'C]
% x     :絶対湿度 [kg/kg(DA)]

% 飽和水蒸気圧Ps[mmHg]の計算
c = 373.16 / (273.16 + Tda);
b = c - 1;
a = -7.90298 * b + 5.02808 * log10(c) - 1.3816 * 10^(-7) * (10^(11.344 * b / c) - 1) + 8.1328 * 10^(-3) * (10^(-3.49149 * b) - 1);
Ps = 760 * 10^a;
% 入力した絶対湿度
x = 0.622 * (rh * Ps) / 100 / (760 - rh * Ps / 100);



% % 次のリンクの近似式による
% 計算時間がかかる場合は近似式を使う！！！
% % http://bacspot.dip.jp/virtual_link/www/other_lecture/%E7%A9%BA%E8%AA%BF%E8%A8%AD%E8%A8%88%E3%81%AE%E5%9F%BA%E7%A4%8E(%E7%A9%BA%E8%AA%BF%E7%A9%BA%E6%B0%97%E3%81%A8%E7%A9%BA%E6%B0%97%E7%B7%9A%E5%9B%B3%E8%A8%88%E7%AE%97%E8%A1%A8)/%E6%B9%BF%E3%82%8A%E7%A9%BA%E6%B0%97%E3%81%AE%E7%89%B9%E6%80%A7%E3%82%92%E8%A8%88%E7%AE%97%E3%81%99%E3%82%8B%E5%BC%8F%20-%20wet.pdf
% Y = log(Ps * rh / 100 / 760 * 101.325 * 1000);
% 
% Tdp = -77.199 + 13.198 * Y - 0.63772 * Y^2 + 0.071098 * Y^3;


% 収束計算による解放

% この絶対湿度で相対湿度100%となる飽和水蒸気圧Ps
Ps = 100 * 760 * x / (100 * (0.622 + x));
Ps0 = 0;
Tdpmax = Tda;
Tdpmin = 0;
Tdp = 0;
Ps00 = zeros(1,10);
% 飽和水蒸気圧が上のPsの値となる温度Twb
while (Ps - Ps0 < -0.01)||(Ps - Ps0 > 0.01)
    
    Tdp = (Tdpmax + Tdpmin) / 2;
    
    c = 373.16 / (273.16 + Tdp);
    b = c - 1;
    a = -7.90298 * b + 5.02808 * log10(c) - 1.3816 * 10^(-7) * (10^(11.344 * b / c) - 1) + 8.1328 * 10^(-3) * (10^(-3.49149 * b) - 1);
    Ps0 = 760 * 10^a;
    
    if Ps - Ps0 > 0
        Tdpmin = Tdp;
    else
        Tdpmax = Tdp;
    end
    
    FlgError = 0;
    % 収束しない場合
    for i = 10:-1:2
        Ps00(i) = Ps00(i-1) ;
    end
    Ps00(1) = Ps0;    
    if Ps00 == Ps00(1)
        FlgError = 1;
        break
    end
end



