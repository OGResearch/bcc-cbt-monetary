function p = baseline(p)

% Steady states

p.ss_dl_y_tnd = 3;
p.ss_dl_cpi_tar = 4;
p.ss_dl_z = 0;
p.ss_r = 1;
p.ss_str_def = 3.0;

p.ss_dl_cpif = 2.00;
p.ss_rf = -1;


% Output gap parameters

p.a1 = 0.70;  % Lag
p.a2 = 0.05;  % Expectations
p.a3 = 0.08;  % Real interest rate
p.a4 = 0.20;  % Foreign demand gap
p.a5 = 0.01;  % Real exchange rate
p.a6 = 0.00;  % Fiscal impulse
p.a7 = 0.30;
p.a8 = 0.15; 0.08;  % Credit conditions

% Phillips curve

p.b1 = 0.50; % Lag
p.b3 = 0.05; % Output gap
p.b4 = 0.01; % Real exchange rate gap
p.b5 = 0.001; % Oil
p.b6 = 0.02; % Direct pass-through
p.b7 = 0.70; % Level effect of direct pass-through
p.b8 = 0.50;
p.b9 = 0.10; % Relative price effect


% Non-core CPI inflation

p.b21 = 0.40; % Lag
p.b22 = 0.30; % Oil
p.b23 = 0.10; % Relative price effect


% Headline CPI

p.w_core = 1 - 0.127 - 0.265;


% Policy rule

p.c1 = 0.75; % Lag
p.c2 = 2.; % Inflation reaction
p.c3 = 0.0; % Output gap


% Lending rate transmission

p.c1_il_ceil = 1.20;
p.rho_il_spread_tnd = 0.95;
p.rho_il_spread_gap = 0.80;
p.ss_il_spread = 2.30;
p.switch_ceiling = 1;


% UIP

p.e1 = 0.9; % Share of forward looking agents
p.e2 = 0.6; % Weight of exchange rate target

% Fiscal

p.f1 = 0.2;
p.f2 = 0.5;

% Trends

p.rho_g_y_tnd = 0.90;
p.rho_dl_z_tnd = 0.90;
p.rho_prem = 0.70;
p.rho_dl_s_tar = 0.90;
p.rho_dl_cpi_tar = 0.90;
p.rho_r_tnd = 0.90;
p.rho_str_def = 0.90;

% Standard deviations

p.std_shock_l_y_gap = 0.75;
p.std_shock_dl_cpi_core = 1.20;
p.std_shock_dl_cpi_ncore = 3.20;
p.std_shock_i = 0.25;
p.std_shock_l_s = 1.75;
p.std_shock_def = 2.00;

p.std_shock_g_y_tnd = 0.10;
p.std_shock_l_y_tnd = 0.10;
p.std_shock_dl_z_tnd = 0.20;
p.std_shock_prem = 0.20;
p.std_shock_dl_s_tar = 0.25;
p.std_shock_dl_cpi_tar = 0.01;
p.std_shock_r_tnd = 0.20;
p.std_shock_str_def = 0.10;

% External variables

p.rho_dl_cpif = 0.41;
p.rho_if = 0.76;
p.rho_rf_tnd = 0.97;
p.rho_l_yf_gap = 0.90;
p.rho_l_rp_oil_gap = 0.74;

p.std_shock_dl_cpif =  1.31;
p.std_shock_if =  0.75;
p.std_shock_rf_tnd =  0.15;
p.std_shock_l_yf_gap =  0.53;
p.std_shock_l_rp_oil_gap = 14.98;


% Credit conditions
p.c0_cc_gap = 0.8;


% Credit extension
p.c1_l_bc = 0.07;
p.c1_l_bc_new = 0.21;
p.c2_l_bc_new = 1.5;
p.c1_cc_gap = 0.10;

end%

