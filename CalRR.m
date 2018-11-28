function [ToutCh,COP,Pw] = CalRR(TinCh,SpToutCh,GCh,T_DAir,RR_co)
% �Ⓚ�@RR3�̌v�Z
% Nomenclature
% ToutCn        :��p���o�����x['C]
% COP           :�Ⓚ�@COP[-]
% Pw            :�Ⓚ�@����d��[kW]
% TinCh         :�␅�������x['C]
% ToutCh        :�␅�o�����x['C]
% GCh           :�␅����[kg/s]
% TinCn         :��p���������x['C]
% GCn           :��p������[m3/min]
% LF            :�Ⓚ�@���ח�[%]

a13 = RR_co(1,1);
b13 = RR_co(1,2);
c13 = RR_co(1,3);
d13 = RR_co(1,4);
e13 = RR_co(1,5);
% a17 = RR_co(2,1);
% b17 = RR_co(2,2);
% c17 = RR_co(2,3);
% d17 = RR_co(2,4);
% e17 = RR_co(2,5);
% a21 = RR_co(3,1);
% b21 = RR_co(3,2);
% c21 = RR_co(3,3);
% d21 = RR_co(3,4);
% e21 = RR_co(3,5);
% a25 = RR_co(4,1);
% b25 = RR_co(4,2);
% c25 = RR_co(4,3);
% d25 = RR_co(4,4);
% e25 = RR_co(4,5);
% a29 = RR_co(5,1);
% b29 = RR_co(5,2);
% c29 = RR_co(5,3);
% d29 = RR_co(5,4);
% e29 = RR_co(5,5);
% a33 = RR_co(6,1);
% b33 = RR_co(6,2);
% c33 = RR_co(6,3);
% d33 = RR_co(6,4);
% e33 = RR_co(6,5);
% a37 = RR_co(7,1);
% b37 = RR_co(7,2);
% c37 = RR_co(7,3);
% d37 = RR_co(7,4);
% e37 = RR_co(7,5);


% �␅��p���Ƃ��ɗ��ʂ�����ꍇ�A�␅�������x��5�x���傫���ꍇ
if (GCh > 0)&&(TinCh > 7)
    % ���ח��A�␅�o�����x�̌v�Z�B���ח�100%�𒴂�����o�����x���㏸����B
    % �����������Əo�����x��7�x�ȏ�ɂȂ�A��C�ɐ��䂪�s����ɂȂ�
    % �����̂��ߏo�����x5�x�ŌŒ�B���ח���100%�Ƃ���COP���v�Z����

    ToutCh = SpToutCh;
    
   % LF = (TinCh - ToutCh) * GCh / (10 * 4.98) * 100;
    LF = (TinCh - ToutCh) * GCh / ( 5 * 0.215) * 100;
    if LF > 100
        LF = 100;
        ToutCh = TinCh - 5 * 0.215 / GCh;
    end
    if LF < 10
        LF = 10;
    end
    
    % �O�C�������x�x�[�X��COP�Z�o���B
        COP = a13 * LF^4 + b13 * LF^3 + c13 * LF^2 + d13 * LF + e13;
    
%     % �O�C�������x�x�[�X��COP�Z�o���B
%     if T_DAir < 13      % 13�x�ȉ���13�x�Ƃ��Čv�Z
%         COP = a13 * LF^4 + b13 * LF^3 + c13 * LF^2 + d13 * LF + e13;
%     elseif T_DAir < 17
%         a = a13 * LF^4 + b13 * LF^3 + c13 * LF^2 + d13 * LF + e13;
%         b = a17 * LF^4 + b17 * LF^3 + c17 * LF^2 + d17 * LF + e17;
%         COP = b + (a - b) * (17 - T_DAir) / 4;
%     elseif T_DAir < 21
%         a = a17 * LF^4 + b17 * LF^3 + c17 * LF^2 + d17 * LF + e17;
%         b = a21 * LF^4 + b21 * LF^3 + c21 * LF^2 + d21 * LF + e21;
%         COP = b + (a - b) * (21 - T_DAir) / 4;
%     elseif T_DAir < 25
%         a = a21 * LF^4 + b21 * LF^3 + c21 * LF^2 + d21 * LF + e21;
%         b = a25 * LF^4 + b25 * LF^3 + c25 * LF^2 + d25 * LF + e25;
%         COP = b + (a - b) * (25 - T_DAir) / 4;
%     elseif T_DAir < 29
%         a = a25 * LF^4 + b25 * LF^3 + c25 * LF^2 + d25 * LF + e25;
%         b = a29 * LF^4 + b29 * LF^3 + c29 * LF^2 + d29 * LF + e29;
%         COP = b + (a - b) * (29 - T_DAir) / 4;
%     elseif T_DAir < 33
%         a = a29 * LF^4 + b29 * LF^3 + c29 * LF^2 + d29 * LF + e29;
%         b = a33 * LF^4 + b33 * LF^3 + c33 * LF^2 + d33 * LF + e33;
%         COP = b + (a - b) * (33 - T_DAir) / 4;
%     elseif T_DAir < 37
%         a = a33 * LF^4 + b33 * LF^3 + c33 * LF^2 + d33 * LF + e33;
%         b = a37 * LF^4 + b37 * LF^3 + c37 * LF^2 + d37 * LF + e37;
%         COP = b + (a - b) * (37 - T_DAir) / 4;
%     else                % 37�x�ȏ��37�x�Ƃ��Čv�Z
%         COP = a37 * LF^4 + b37 * LF^3 + c37 * LF^2 + d37 * LF + e37;
%     end
        
    % �␅�o�����x�ɉ�����COP��ω�������
    COP = COP * (1 + (ToutCh-7)/20);
    
    % ����d�͂̌v�Z
    Pw = (TinCh - ToutCh) * GCh / 60 * 1.0 * 10^3 * 4.186 / COP;
    if Pw > 0   
    else
        Pw = 0;
    end
    
else
    ToutCh = TinCh;
    COP = 0;
    Pw = 0;
    
end
