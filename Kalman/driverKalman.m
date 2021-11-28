
clear, clc, close all

% Settings

rngFilt = qq(2000,1) : qq(2019,4);

% Load the data

tmp = load("../QPM/results/data.mat");
l_y = 100*log(tmp.db.gdp{rngFilt});

% HP filter
l_y_hp_tnd = hpf(l_y, "lambda", 1600);

% Kalman filter

m = Model("kf2hp.model", "Linear", true, "Growth", true);

m.rho_gap     = 0.00;
m.rho_tnd     = 1.00;
m.ss_dl_y_tnd = 3.00;

sf = 1;

m.std_shock_l_y_gap   = 1.0*sf;
m.std_shock_dl_y_tnd  = 0.1*sf;

m = solve(m);
m = sstate(m);

dbObs.obs_l_y = l_y;

[~, dbFilt] = filter(m, dbObs, rngFilt);
l_y_kf_tnd = dbFilt.mean.l_y_tnd;

% Compare HP and KF trend

plot(rngFilt, l_y, 'r:', 'linewidth', 1);
hold on
plot(rngFilt, l_y_hp_tnd, 'b', 'linewidth', 1.5);
plot(rngFilt, l_y_kf_tnd, 'b:', 'linewidth', 1.5);
legend(["Actual", "HP trend" , "Kalman trend"])
grid

maxabs([l_y_hp_tnd - l_y_kf_tnd])