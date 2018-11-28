function[P_Pmp,dP_PpPmp,G_Pmp,G_VlvPmp] = Branch01(G,Nm_Pmp,INV,Vlv_Pmp,Cv_max,d2,d1,d0,Kr_PpPmp,Kr_PpVlvPmp)
% �|���v�𕡐�����ɗL����}�ɂ����āA�o�����ʁA�|���vINV�E�o�C�p�X�يJ�x���爳�́A�e���ʂ��v�Z����B
% ���͂́A���͑��������A�|���v�ɂ����������Ƃ���B
% ���ʂ́A�|���v�̌����𐳂Ƃ���B
% Nomenclature %%%%%
% dP            :�}�̏o�������͍�[kPa]
% dPHEX        :�M������O��̈��͍�(=�M������o�C�p�X�ّO��̈��͍�)[kPa]
% dPPmp        :�񎟃|���v�O��̈��͍�(=�񎟃|���v�o�C�p�X�ّO��̈��͍�)[kPa]
% dPPp          :�z�ǈ��͑���
% dPVlvHEX      :�M������o�C�p�X�و��͑���
% dPVlvPmp      :�|���v�o�C�p�X�و��͑���
% maxG,minG     :���ʂ̍ő�l�A�ŏ��l(0.0)[m3/min]
% Nm_Pmp           :�|���v�^�]�䐔
% INV           :INV�̉�]��(0~1)
% c0~c4         :�|���v���\�Ȑ��̌W��
% c0n           :����INV���̍ő刳�́i���\�Ȑ��̈��͐ؕЁj
% KrHEX         :�M�����툳���W��[kPa/(m3/min)^2]
% KrPp          :�z�ǈ����W��[kPa/(m3/min)^2]
% G             :������[m3/min]
% GPmp          :�|���v��䂠����̗���[m3/min]
% GHEX          :�M�����헬��[m3/min],��䂠����̗��ʁB
% Ph            :�|���v�ɂ�鈳��[kPa]
% Phn           :��i�iINV=0)�����Z�̈���
% VlvPmp        :�|���v�o�C�p�X�يJ�x(0~1,0���S��)[-]
% VlvHEX        :�M������o�C�p�X�يJ�x(0~1)[-]
% global d0_CP3 d1_CP3 d2_CP3
% d0 = d0_CP3;
% d1 = d1_CP3;
% d2 = d2_CP3;
% 
% G = 0.6;
% Nm_Pmp = 1;
% INV = 0.5;
% Vlv_Pmp  = 0.1;
% Cv_max = 2000;
% Kr_PpPmp = 1;
% Kr_PpVlvPmp = 1;

if (G == 0)||(INV == 0)&&(Vlv_Pmp == 0)
    P_Pmp = 0;
    dP_PpPmp = 0;
    G_Pmp = 0;
    G_VlvPmp = 0;
% dP��0kPa�ȏ゠��Ƃ�(���͑��������ɂȂ��Ă��Ȃ��Ƃ��A�܂�dP�����ɂȂ��Ă��Ȃ��Ƃ�)
else
    % �o�C�p�X�ق����Ă��鎞
    if Vlv_Pmp == 0
        G_Pmp = G / Nm_Pmp;
        P_Pmp = (d0 + d1 *  (G_Pmp / INV) + d2 *  (G_Pmp / INV)^2) * INV^2;
        dP_PpPmp = - Kr_PpPmp * G_Pmp^2;
        G_VlvPmp = 0;
    else
        G_VlvPmpmax = 0.129;
        G_VlvPmpmin = 0;
        dP_VlvPmp = 10;
        dP_PpVlvPmp = 0;
        P_Pmp = 0;
        dP_PpPmp = 0;
        cnt = 0;
        while (dP_VlvPmp + dP_PpVlvPmp + P_Pmp + dP_PpPmp > 0.001)||(dP_VlvPmp + dP_PpVlvPmp + P_Pmp + dP_PpPmp < -0.001)
            
            cnt = cnt + 1;
            
            G_VlvPmp = (G_VlvPmpmax + G_VlvPmpmin) / 2;

            R = 100;
            Cv = Cv_max * R^(Vlv_Pmp - 1);
            dP_VlvPmp = - 1743 * (G_VlvPmp * 1000 / 60)^2 / Cv^2;
            dP_PpVlvPmp = - Kr_PpVlvPmp * G_VlvPmp^2;

            G_Pmp = (G + G_VlvPmp) / Nm_Pmp;
            P_Pmp = (d0 + d1 *  (G_Pmp / INV) + d2 *  (G_Pmp / INV)^2) * INV^2;
            dP_PpPmp = - Kr_PpPmp * G_Pmp^2;

            if dP_VlvPmp + dP_PpVlvPmp + P_Pmp + dP_PpPmp > 0
                G_VlvPmpmin = G_VlvPmp;
            else
                G_VlvPmpmax = G_VlvPmp;
            end

            if cnt > 25
                break
            end
            
        end
        
    end
end
