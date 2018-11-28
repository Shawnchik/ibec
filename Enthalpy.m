function [h,x] = Enthalpy(Tda,rh)
% �������xTda�Ƒ��Ύ��xrh�����G���^���s�[h�����߂�
% h     :enthalpy [J/kg]
% Tda   :Temperature of dry air ['C]
% rh    :relative humidity [%]
% cpd   :������C�̒舳��M [J / kg(DA)'C]
% gamma :�O�a�����C�̏������M [J/kg]
% cpv   :�����C�̒舳��M [J / kg(DA)'C]
% x     :��Ύ��x [kg/kg(DA)]

cpd = 1007;
gamma = 2499 * 10^3;
cpv = 1845;

% �O�a�����C��Ps[mmHg]�̌v�Z
c = 373.16 / (273.16 + Tda);
b = c - 1;
a = -7.90298 * b + 5.02808 * log10(c) - 1.3816 * 10^(-7) * (10^(11.344 * b / c) - 1) + 8.1328 * 10^(-3) * (10^(-3.49149 * b) - 1);
Ps = 760 * 10^a;

x = 0.622 * (rh * Ps) / 100 / (760 - rh * Ps / 100);

h = cpd * Tda + (gamma + cpv * Tda) * x;

