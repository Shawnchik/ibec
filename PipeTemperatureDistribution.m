function [Td,T_avg] = PipeTemperatureDistribution(Td0,T_air,R,dR,dr,dt,a_pipe,k_pipe)
 % ��^�]���̔z�Ǔ����x���z�E���x�ω����v�Z����
 % �z�ǉ��x���z Td
 % �z�Ǖ��ω��x T_avg [��]
 % �O�C���x T_air [��]
 % �z�ǊO�a R [m]
 % �z�ǌ��� dR [m]
 % ������ dr [m]
 % �M�g�U�� a [m2/s]
 % �M�`���� k [W/m*��]
 % �����M�`�B�� alpha [W/m2*��]
    % ���� 9.3[W/m2*��] �@���O 23[W/m2*��]
 % �P�ʎ��� dt [s]
 
 % ������n���v�Z
 n = R / dr;
 
 % ���̔M�g�U���ƔM�`����
 a_water = 1.466 * (10^(-7));
 k_water = 0.6104;
 alpha = 9.3;

 % ���x���z�v�Z
 % i = r/dr + 1    r = (i - 1) *dr
 
 for t = 1 : dt 
     
    % ���x���z�̍s����쐬
    Td = zeros(1,n+1);
 
    for i = 0 : n
        if i == 0
            Td(1,1) = ((a_water * 1)/(dr^2)) * ( ((dr^2)/(a_water * 1) - 2) * Td0(1,1) + 2 * Td0(1,2) ); 
        elseif (i > 0) && (i < (R - dR) / dr )
            Td(1,i+1) = ((a_water * 1)/(dr^2)) * ( ( 1 - 1/(2*i) ) * Td0(1,i) + ((dr^2)/(a_water * 1) - 2) * Td0(1,i+1) + ( 1 + 1/(2*i) ) * Td0(1,i+2) ); 
        elseif (i > (R - dR) / dr ) && (i < n)
            Td(1,i+1) = ((a_pipe * 1)/(dr^2)) * ( ( 1 - 1/(2*i) ) * Td0(1,i) + ((dr^2)/(a_pipe * 1) - 2) * Td0(1,i+1) + ( 1 + 1/(2*i) ) * Td0(1,i+2) ); 
        end
    end

    % ���E�ʉ��x�v�Z
    i = round((R - dR) / dr);
    Td(1,i+1) = ( ( k_water / log(i/(i - 1)) ) * Td(1,i) + ( k_pipe / log((i + 1)/i) ) * Td(1,i+2) ) / ( ( k_water / log(i/(i - 1)) ) + ( k_pipe / log((i + 1)/i) ) );

    i = n;
    Td(1,i+1) = ( ( k_pipe / log(i/(i - 1)) ) * Td(1,i) + (i * dr) * alpha * T_air ) / ( ( k_pipe / log(i/(i - 1)) ) + (i * dr) * alpha );

    
    Td0 = Td;
    
 end    
    
 
 % ���ω��x�v�Z �f�ʐς̔�𗘗p
 T_avg_cal = zeros(1,round((R - dR) / dr + 1));
 
 for i = 0 : (R - dR) / dr
     if i == 0
        T_avg_cal(1,i+1) = 0;
     elseif i == 1
        T_avg_cal(1,i+1) = Td(1,i+1);
     else
        T_avg_cal(1,i+1) = Td(1,i+1) * ( i^2 - (i-1)^2 );
     end
 end     
 
 T_avg = sum(T_avg_cal)/ ( ((R - dR)/dr)^2 );
 