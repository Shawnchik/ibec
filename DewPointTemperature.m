function [Tdp] = DewPointTemperature(Tda,rh)
% �������xTda�Ƒ��Ύ��xrh����I�_���xTdp�����߂�
% Tda   :Temperature of dry air ['C]
% rh    :relative humidity [%]
% cpd   :������C�̒舳��M [J / kg(DA)'C]
% gamma :�O�a�����C�̏������M [J/kg]
% cpv   :�����C�̒舳��M [J / kg(DA)'C]
% x     :��Ύ��x [kg/kg(DA)]

% �O�a�����C��Ps[mmHg]�̌v�Z
c = 373.16 / (273.16 + Tda);
b = c - 1;
a = -7.90298 * b + 5.02808 * log10(c) - 1.3816 * 10^(-7) * (10^(11.344 * b / c) - 1) + 8.1328 * 10^(-3) * (10^(-3.49149 * b) - 1);
Ps = 760 * 10^a;
% ���͂�����Ύ��x
x = 0.622 * (rh * Ps) / 100 / (760 - rh * Ps / 100);



% % ���̃����N�̋ߎ����ɂ��
% �v�Z���Ԃ�������ꍇ�͋ߎ������g���I�I�I
% % http://bacspot.dip.jp/virtual_link/www/other_lecture/%E7%A9%BA%E8%AA%BF%E8%A8%AD%E8%A8%88%E3%81%AE%E5%9F%BA%E7%A4%8E(%E7%A9%BA%E8%AA%BF%E7%A9%BA%E6%B0%97%E3%81%A8%E7%A9%BA%E6%B0%97%E7%B7%9A%E5%9B%B3%E8%A8%88%E7%AE%97%E8%A1%A8)/%E6%B9%BF%E3%82%8A%E7%A9%BA%E6%B0%97%E3%81%AE%E7%89%B9%E6%80%A7%E3%82%92%E8%A8%88%E7%AE%97%E3%81%99%E3%82%8B%E5%BC%8F%20-%20wet.pdf
% Y = log(Ps * rh / 100 / 760 * 101.325 * 1000);
% 
% Tdp = -77.199 + 13.198 * Y - 0.63772 * Y^2 + 0.071098 * Y^3;


% �����v�Z�ɂ����

% ���̐�Ύ��x�ő��Ύ��x100%�ƂȂ�O�a�����C��Ps
Ps = 100 * 760 * x / (100 * (0.622 + x));
Ps0 = 0;
Tdpmax = Tda;
Tdpmin = 0;
Tdp = 0;
Ps00 = zeros(1,10);
% �O�a�����C�������Ps�̒l�ƂȂ鉷�xTwb
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
    % �������Ȃ��ꍇ
    for i = 10:-1:2
        Ps00(i) = Ps00(i-1) ;
    end
    Ps00(1) = Ps0;    
    if Ps00 == Ps00(1)
        FlgError = 1;
        break
    end
end



