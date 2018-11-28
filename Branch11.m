function [G] = Branch11(dP,KrPp,KrEq,Vlv,Cv_max,R)
% �|���v�̂Ȃ��}�ɂ��āA���͑������痬�ʂ����߂�T�u���[�`��
% [����] = Branch0(���͑���,�z�ǈ����W��,�M�������W��,�@�툳���W��,�o���u�J�x)
% Nomenclature
% G         :����[m3/min]
% GHEX      :�M�����헬��[m3/min]
% dP        :�}�̏o�������͍�[kPa]  
% KrPp      :�ǂ̈����W��[kPa/(m3/min)^2]
% KrHEX     :�M���̈����W��[kPa/(m3/min)^2]
% KrEq      :�@��̈����W��[kPa/(m3/min)^2]
% GHEX      :�M���̗���[m3/min]
% Vlv       :�o���u�J�x(1:�S�J,0:�S��)
% dP0       :�񕪖@�p����̈��͍�

% �o�������͍����Ȃ��A�܂��̓o���u���قڕ��Ă���ꍇ�͗���0�Ƃ���B
if (dP > 0)||(Vlv == 0)
    G = 0;
else
    % while�ɓ��邽�߂̏����l,�񕪖@�����l
    Gmax = 30;
    Gmin = 0;
    G = 0;
    dP0 = 10;
    cnt = 0;
    while (dP - dP0 > 0.0001)||(dP - dP0 < - 0.0001)
        
        cnt = cnt + 1;

        G = (Gmax + Gmin) / 2;

        % (�}�̈���) = (�ǈ���) + (�M������) + (�@�툳��) + (�o���u����)
        
        % �و����v�Z�B�����W�A�r���e�BR�̓o�^�t���C�o���u��20
%         R = 20;
        Cv = Cv_max * R^(Vlv - 1);
        dPVlv = - 1743 * (G * 1000 / 60)^2 / Cv^2;
            
        dP0 = - KrPp * G^2 - KrEq * G^2 + dPVlv;

        if dP - dP0 > 0
            Gmax = G;
        else
            Gmin = G;
        end
        
        % �������Ȃ��ꍇ
        if cnt > 30
            break
        end
    

    end
end

