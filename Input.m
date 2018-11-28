function Input
% input variables of operation conditions and calculate time
% Nomenclature
% G_Ld           :load flow[m3/min]
% Q_Ld           :load heat[GJ/min](to calculate return water temperature)
% T_air          :outside air temperature['C]
% RH            :outside air relative humidity[%]
global InputValues CalStep
global G_Ld Q_Ld T_air RH minute hour day month year T_room
global Sp_ToutHdr T_wb

i = CalStep + 1;
G_Ld = InputValues(i,1);
Q_Ld = InputValues(i,2);
Sp_ToutHdr = InputValues(i,3);
T_air = InputValues(i,4);
RH = InputValues(i,5);
T_room = InputValues(i,6);

[T_wb] = WetBulbTemperature(T_air,RH);

% time calculation
hour = rem(floor(CalStep / 60),24);
minute = rem(CalStep,60);

if (hour == 0)&&(minute == 0)
    day = day + 1;
end

if (month == 1)||(month == 3)||(month == 5)||(month == 7)||(month == 8)||(month == 10)||(month == 12)
    if day == 32
        day = 1;
        month = month + 1;
        if month == 13
            month = 1;
            year = year + 1;
        end
    end
elseif (month == 4)||(month == 6)||(month == 9)||(month == 11)
    if day == 31
        day = 1;
        month = month + 1;
    end
% February
else
    % leap year
    if rem(year,4) == 0
        if day == 30
            day = 1;
            month = month + 1;
        end   
    else
        if day == 29
            day = 1;
            month = month + 1;
        end
    end
end