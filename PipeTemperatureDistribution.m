function [Td,T_avg] = PipeTemperatureDistribution(Td0,T_air,R,dR,dr,dt,a_pipe,k_pipe)
 % ”ñ‰^“]Žž‚Ì”zŠÇ“à‰·“x•ª•zE‰·“x•Ï‰»‚ðŒvŽZ‚·‚é
 % ”zŠÇ‰·“x•ª•z Td
 % ”zŠÇ•½‹Ï‰·“x T_avg [Ž]
 % ŠO‹C‰·“x T_air [Ž]
 % ”zŠÇŠOŒa R [m]
 % ”zŠÇŒú‚³ dR [m]
 % •ªŠ„• dr [m]
 % ”MŠgŽU—¦ a [m2/s]
 % ”M“`“±—¦ k [W/m*Ž]
 % ‘‡”M“`’B—¦ alpha [W/m2*Ž]
    % Žº“à 9.3[W/m2*Ž] @‰®ŠO 23[W/m2*Ž]
 % ’PˆÊŽžŠÔ dt [s]
 
 % •ªŠ„”n‚ðŒvŽZ
 n = R / dr;
 
 % …‚Ì”MŠgŽU—¦‚Æ”M“`“±—¦
 a_water = 1.466 * (10^(-7));
 k_water = 0.6104;
 alpha = 9.3;

 % ‰·“x•ª•zŒvŽZ
 % i = r/dr + 1    r = (i - 1) *dr
 
 for t = 1 : dt 
     
    % ‰·“x•ª•z‚Ìs—ñ‚ðì¬
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

    % ‹«ŠE–Ê‰·“xŒvŽZ
    i = round((R - dR) / dr);
    Td(1,i+1) = ( ( k_water / log(i/(i - 1)) ) * Td(1,i) + ( k_pipe / log((i + 1)/i) ) * Td(1,i+2) ) / ( ( k_water / log(i/(i - 1)) ) + ( k_pipe / log((i + 1)/i) ) );

    i = n;
    Td(1,i+1) = ( ( k_pipe / log(i/(i - 1)) ) * Td(1,i) + (i * dr) * alpha * T_air ) / ( ( k_pipe / log(i/(i - 1)) ) + (i * dr) * alpha );

    
    Td0 = Td;
    
 end    
    
 
 % •½‹Ï‰·“xŒvŽZ ’f–ÊÏ‚Ì”ä‚ð—˜—p
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
 