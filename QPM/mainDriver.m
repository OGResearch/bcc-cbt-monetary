
%% Setup

clear, clc, close all

%% Read model

readModel();

%% Read the data

readData();

%% Estimate parameters

estimateParams();

%% Plot impulse responses

plotIRF();

%% Simulate scenarios

scenarios.simulateDelayedResponse();

%% Calculate unobserved variables

filterHistory();

%% Plot the filtration results

plotDecomp();
plotTrends();
plotShocks();