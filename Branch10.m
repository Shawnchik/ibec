function[G,G_Pmp,G_Vlv,P_Pmp] = Branch10(dP,INV,Vlv,Cv_max,d2,d1,d0,Kr_PpTR,Kr_TR,Kr_PpVlv)
% �|���v����L����}�ɂ����āA�o�������͍��ƃ|���vINV���痬�ʂ����߂�v�Z
% [������,�|���v����,�o�C�p�X�ٗ���,�|���v�S�g��] =
% Branch10(���͍�,�|���vINV,�o�C�p�X�يJ�x,���ʌW��,�|���v�W��0��,�|���v�W��1��,�|���v�W��2��,�z�ǒ�R�W��,�Ⓚ�@��R�W��)
% ���͂́A���͑��������A�|���v�ɂ����������Ƃ���B
% ���ʂ́A�|���v�̌����𐳂Ƃ���B
% Nomenclature %%%%%
% dP            :�}�̏o�������͍�[kPa]
% maxG,minG     :���ʂ̍ő�l�A�ŏ��l(0.0)[m3/min]
% INV           :�|���vINV(0~1)
% Vlv         :�o�C�p�X��(1:�S�J,0:�S��)
% d0~d2         :�|���v���\�Ȑ��̌W��
% Kr_Pp          :�z�ǈ����W��[kPa/(m3/min)^2]
% Kr_TR          :�Ⓚ�@�����W��[kPa/(m3/min)^2]
% G             :������[m3/min]
% G_Pmp           :�Ⓚ�@����[m3/min]
% G_Vlv        :�o�C�p�X�ٗ���[m3/min]
% P_Pmp         :�|���v�ɂ�鈳��[kPa]
% dP_Pp          :�z�ǂɂ�鈳�͑���[kPa]
% dPVlv         :�z�Ǘp����قɂ�鈳�͑���[kPa]
% dP_Vlv       :�Ⓚ�@�o�C�p�X�قɂ�鈳�͑���[kPa]

% INV��0���o�C�p�X�ق����Ă��鎞
if (INV == 0)&&(Vlv == 0)
    G_Pmp = 0;
    G_Vlv = 0;
    G = 0;
    P_Pmp = 0;
% INV��0�����o�C�p�X�ق͊J���Ă��鎞
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
    

% �o�C�p�X�ق͕��Ă��邪INV��0���傫����
elseif Vlv == 0
    
    G_Vlv = 0;
    
    % while�ɓ��邽�߂̏����l,�񕪖@�����l
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
    

% INV��0���傫���A�o�C�p�X�ق��J���Ă��鎞
else 
    % while�ɓ��邽�߂̏����l,�񕪖@�����l
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