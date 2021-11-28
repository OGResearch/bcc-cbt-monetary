
clear, clc, close all

tmp = load("../results/data.mat");
db  = tmp.dbObs;

tmp = load("../results/model.mat");
m   = tmp.m;

% CPI

y = 4*diff(db.obs_l_cpi_f) - m.ss_dl_cpi_f;
[b, ~, ~, stde] = regress(y, y{-1});

% Output gap

y = db.obs_l_y_f_gap;
[b, ~, ~, stde] = regress(y, y{-1});

% Real interest rate trend

y = db.obs_r_f_tnd - m.ss_r_f_tnd;
[b, ~, ~, stde] = regress(y, y{-1});

% Interest rate

y = db.obs_i_f - (m.ss_r_f_tnd + 4*diff(db.obs_l_cpi_f));
[b, ~, ~, stde] = regress(y, y{-1});

% Non-core inflation

y = 4*diff(db.obs_l_cpi_ncore) - m.ss_dl_cpi_ncore;
[b, ~, ~, stde] = regress(y, y{-1})

% Oil
% y = db.obs_l_rp_oil_gap;
% [b, ~, ~, stde] = regress(y, y{-1});