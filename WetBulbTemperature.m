function [Twb] = WetBulbTemperature(Tda,rh)
% 解析的な手法により湿球温度を求める。
% http://bacspot.dip.jp/virtual_link/www/other_lecture/%E7%A9%BA%E8%AA%BF%E8%A8%AD%E8%A8%88%E3%81%AE%E5%9F%BA%E7%A4%8E(%E7%A9%BA%E8%AA%BF%E7%A9%BA%E6%B0%97%E3%81%A8%E7%A9%BA%E6%B0%97%E7%B7%9A%E5%9B%B3%E8%A8%88%E7%AE%97%E8%A1%A8)/%E6%B9%BF%E3%82%8A%E7%A9%BA%E6%B0%97%E3%81%AE%E7%89%B9%E6%80%A7%E3%82%92%E8%A8%88%E7%AE%97%E3%81%99%E3%82%8B%E5%BC%8F%20-%20wet.pdf
% 上のリンクを参照。
% cpw       :冷却水の比熱 [J/kg'C]

cpw = 4184;

[Tdp] = DewPointTemperature(Tda,rh);

Twbmax = Tda;
Twbmin = Tdp;
Twb = 1;
Twb0 = 0;
Twb00 = zeros(1,10);
while(Twb - Twb0 > 0.01)||(Twb - Twb0 < - 0.01)

    Twb = (Twbmax + Twbmin) / 2;

    [h,x] = Enthalpy(Tda,rh);
    
    [hs,xs] = Enthalpy(Twb,100);

    Twb0 = (hs - h) / ((xs - x) * cpw);
    
    if Twb - Twb0 > 0
        Twbmin = Twb;
    else
        Twbmax = Twb;
    end
      
    FlgError = 0;
    % 収束しない場合
    for i = 10:-1:2
        Twb00(i) = Twb00(i-1) ;
    end
    Twb00(1) = Twb0;    
    if Twb00 == Twb00(1)
        FlgError = 1;
        break
    end
    

end
