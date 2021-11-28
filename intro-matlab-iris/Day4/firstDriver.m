
% Setup

clear, clc, close all

% Read model

m = Model("first.model", "Linear", true, "Growth", false);

% Set parameters

m.c       = 1;
m.rho     = 0.7;
m.std_eps = 2;

% Solve and calculate the steady state

m = solve(m);
m = sstate(m);

% Display the steady state

t = table(m, "SteadyLevels");
disp(t)

% Calculate ACF of y
[c, r] = acf(m, 'order', 1);

% Simulate with the model

% Define the simulation range

simHor = 100;

fd = qq(2000,1);
rngSim = fd : fd+simHor;

% Define the intitial values
dbInit.y = Series(fd-1, 10);

% Define values for the shock
% dbInit.eps = Series(fd+10, 1);
dbInit.eps = Series(rngSim, @randn);

% Run the simulation
dbSim = simulate(m, dbInit, rngSim);

% Plot the simulated series
dbplot(dbSim);
grid on
