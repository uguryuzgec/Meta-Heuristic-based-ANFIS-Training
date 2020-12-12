%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPFZ104
% Project Title: Evolutionary ANFIS Traing in MATLAB
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

clc;
clear;
close all;

%% Load Data

data=LoadData();

%% Generate Basic FIS

fis=CreateInitialFIS(data,10);

%% Training Using GA, PSO, others... 

Options = {'Genetic Algorithm', 'Particle Swarm Optimization'};

[Selection, Ok] = listdlg('PromptString', 'Select training method for ANFIS:', ...
                          'SelectionMode', 'single', ...
                          'ListString', Options);

pause(0.01);
          
if Ok==0
    return;
end

switch Selection
    case 1, output=TrainAnfisUsingGA(fis,data);
            str=string('GA');
            bestcost=output.bestcost;
            fis=output.bestfis;
    case 2, output=TrainAnfisUsingPSO(fis,data);
            str=string('PSO');
            bestcost=output.bestcost;
            fis=output.bestfis; 		
end

%% Results
figure
plot(bestcost);
xlabel('iteration')
ylabel('RMSE')
title(string('training ANFIS using ')+str)

% Train Data
TrainOutputs=evalfis(data.TrainInputs,fis);
PlotResults(data.TrainTargets,TrainOutputs,'Train Data');

% Test Data
TestOutputs=evalfis(data.TestInputs,fis);
PlotResults(data.TestTargets,TestOutputs,'Test Data');
