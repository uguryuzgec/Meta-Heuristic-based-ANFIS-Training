%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPFZ104
% Project Title: Evolutionary ANFIS Training in MATLAB
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

function data=LoadData()

    data_orj=load('engine_data');
    data_min_inputs=min(data_orj.Inputs(1:2,:)');
    data_max_inputs=max(data_orj.Inputs(1:2,:)');
    data_min_outputs=min(data_orj.Targets(1:2,:)');
    data_max_outputs=max(data_orj.Targets(1:2,:)');
    %Veri Normalizasyon
    data.Inputs = (data_orj.Inputs - data_min_inputs')./( data_max_inputs'- data_min_inputs');
    data.Targets = (data_orj.Targets - data_min_outputs')./( data_max_outputs'- data_min_outputs');
    %     data(isnan(data)) = 0;
    Inputs=data.Inputs';
    Targets=data.Targets';
    Targets=Targets(:,1);
    
    nSample=size(Inputs,1);
    
    % Shuffle Data
%      S=randperm(nSample);
%      Inputs=Inputs(S,:);
%      Targets=Targets(S,:);
    
    % Train Data
    pTrain=0.7;
    nTrain=round(pTrain*nSample);
    TrainInputs=Inputs(1:nTrain,:);
    TrainTargets=Targets(1:nTrain,:);
    
    % Test Data
    TestInputs=Inputs(nTrain+1:end,:);
    TestTargets=Targets(nTrain+1:end,:);
    
    % Export
    data.TrainInputs=TrainInputs;
    data.TrainTargets=TrainTargets;
    data.TestInputs=TestInputs;
    data.TestTargets=TestTargets;
    
    figure
    subplot(411); plot(data.Inputs(1,:))
    title('input_1')
    subplot(412); plot(data.Inputs(2,:))
    title('input_2')
    subplot(413); plot(data.Targets(1,:))
    title('output_1')
    subplot(414); plot(data.Targets(2,:))
    title('output_2')
end
