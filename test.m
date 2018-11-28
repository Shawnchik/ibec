clc;clear;
% Heat Source System Simulation
% Nomenclautre
% CalStep       :Calculation Step (1 minute)

global CalStep 

% global CalStep num_faults

% Set global variables
SetVariable

% Read files for input data
ReadFiles

% Calculate for a day
for CalStep = 0 :  10 * 24 * 60 - 1
    
    % Check the calculation running or not
    CalStep
    
    % Input operation condition (heat load, outside temperature, setting, values,etc)
    Input
    
    % Control pumps and valves and calculate flow rate in chilled water system
    Flow

    % heat calculation
    Heat

    % power calculation
    Power

    % create output array
    Output

    % export csv file of output
    WriteFiles
                
end
    